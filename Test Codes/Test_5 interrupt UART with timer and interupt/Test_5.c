#include <stdint.h>
#include <stdbool.h>

#include "hal/hal.h"
#include "miv_rv32_hal/miv_rv32_hal.h"
#include "miv_rv32_hal/sample_fpga_design_config.h"
#include "drivers/fpga_ip/CoreUARTapb/core_uart_apb.h"

/* ---------------- UART ---------------- */
static UART_instance_t g_uart;

static const uint8_t msg_start[] =
    "\r\n\r\n**** Hello From Armenia ****\r\n";

static const uint8_t msg_help[] =
    "GPIO2 IRQ = START, GPIO3 IRQ = STOP. Prints delta time.\r\n";

/* ---------------- Your ESS GPIO base ---------------- */
#define ESS_GPIO_BASE         0x75000000u
#define GPIO_INT_CLEAR_REG    (*(volatile uint32_t *)(ESS_GPIO_BASE + 0x80u))
#define GPIO_OUT_REG          (*(volatile uint32_t *)(ESS_GPIO_BASE + 0xA0u))

#define LED_MASK              0x0Fu
#define GPIO2_MASK            (1u << 2)
#define GPIO3_MASK            (1u << 3)

/* ---------------- PLIC ---------------- */
#define PLIC_BASE             0x70000000u
#define PLIC_ENABLE_REG       (*(volatile uint32_t *)(PLIC_BASE + 0x00002000u))
#define PLIC_CLAIMCOMP_REG    (*(volatile uint32_t *)(PLIC_BASE + 0x00200004u))
#define PLIC_PRIORITY_REG(id) (*(volatile uint32_t *)(PLIC_BASE + 4u * (id)))

#define PLIC_ID_GPIO2         1u
#define PLIC_ID_GPIO3         2u

/* ---------------- SysTick timebase ----------------
 * We'll configure SysTick to 1ms ticks:
 * tick_rate_hz = 1000 Hz -> one tick every 1ms
 *
 * MRV_systick_config() expects "ticks" in CPU cycles.
 * So we pass SYS_CLK_FREQ / 1000.
 *
 * SYS_CLK_FREQ must be correct in sample_fpga_design_config.h
 */
#define SYSTICK_HZ            1000u

static volatile uint64_t g_systick_ticks = 0;

/* This runs on MTIME interrupt after MRV_systick_config() */
void SysTick_Handler(void)
{
    g_systick_ticks++;
}

/* Optional: required stub in some projects */
void Software_IRQHandler(void)
{
    MRV_clear_soft_irq();
}

/* ---------------- Timing state (set in External IRQ) ---------------- */
static volatile bool     g_timing_running = false;
static volatile bool     g_result_ready   = false;
static volatile uint64_t g_start_tick     = 0;
static volatile uint64_t g_stop_tick      = 0;

/* ---------------- Small UART number printing ---------------- */
static void uart_print_u64(uint64_t v)
{
    char buf[32];
    uint32_t i = 0;

    if (v == 0u) {
        UART_polled_tx_string(&g_uart, (const uint8_t *)"0");
        return;
    }

    while ((v > 0u) && (i < (sizeof(buf) - 1u))) {
        uint64_t q = v / 10u;
        uint64_t r = v - (q * 10u);
        buf[i++] = (char)('0' + (char)r);
        v = q;
    }
    buf[i] = '\0';

    for (uint32_t a = 0, b = (i ? (i - 1u) : 0u); a < b; a++, b--) {
        char t = buf[a]; buf[a] = buf[b]; buf[b] = t;
    }

    UART_polled_tx_string(&g_uart, (const uint8_t *)buf);
}

/* ---------------- External interrupt handler (PLIC) ---------------- */
uint8_t External_IRQHandler(void)
{
    uint32_t id = PLIC_CLAIMCOMP_REG;

    if (id == PLIC_ID_GPIO2)
    {
        /* START timing */
        g_start_tick = g_systick_ticks;
        g_timing_running = true;

        GPIO_OUT_REG = LED_MASK;         /* optional */
        GPIO_INT_CLEAR_REG = GPIO2_MASK; /* clear latch */
    }
    else if (id == PLIC_ID_GPIO3)
    {
        /* STOP timing (only if started) */
        if (g_timing_running)
        {
            g_stop_tick = g_systick_ticks;
            g_timing_running = false;
            g_result_ready = true;
        }

        GPIO_OUT_REG = 0u;               /* optional */
        GPIO_INT_CLEAR_REG = GPIO3_MASK; /* clear latch */
    }

    if (id != 0u)
    {
        PLIC_CLAIMCOMP_REG = id;         /* complete at PLIC */
    }

    return 0u;
}

static void plic_init_two_gpio_sources(void)
{
    PLIC_PRIORITY_REG(PLIC_ID_GPIO2) = 1u;
    PLIC_PRIORITY_REG(PLIC_ID_GPIO3) = 1u;

    PLIC_ENABLE_REG = (1u << PLIC_ID_GPIO2) | (1u << PLIC_ID_GPIO3);

    GPIO_INT_CLEAR_REG = GPIO2_MASK | GPIO3_MASK;
}

int main(void)
{
    /* UART init */
    UART_init(&g_uart,
              COREUARTAPB0_BASE_ADDR,
              BAUD_VALUE_115200,
              (DATA_8_BITS | NO_PARITY));

    UART_polled_tx_string(&g_uart, msg_start);
    UART_polled_tx_string(&g_uart, msg_help);

    /* Setup PLIC/GPIO */
    GPIO_OUT_REG = 0u;
    plic_init_two_gpio_sources();

    /* Enable global interrupts */
    HAL_enable_interrupts();

    /* Enable external interrupts (PLIC -> MEIE) */
    MRV_enable_local_irq(MRV32_EXT_IRQn);

    /* Configure SysTick based on MTIME (generates SysTick_Handler interrupts) */
    MRV_systick_config(SYS_CLK_FREQ / SYSTICK_HZ);

    UART_polled_tx_string(&g_uart,
        (const uint8_t *)"SysTick configured at 1000 Hz (1 tick = 1 ms)\r\n");

    while (1u)
    {
        if (g_result_ready)
        {
            uint64_t start = g_start_tick;
            uint64_t stop  = g_stop_tick;
            uint64_t dt_ticks = (stop >= start) ? (stop - start) : 0u;

            g_result_ready = false;

            UART_polled_tx_string(&g_uart, (const uint8_t *)"\r\nDelta ticks = ");
            uart_print_u64(dt_ticks);

            UART_polled_tx_string(&g_uart, (const uint8_t *)"  (ms = ");
            uart_print_u64(dt_ticks); /* because 1 tick = 1ms */
            UART_polled_tx_string(&g_uart, (const uint8_t *)")\r\n");
        }

        __asm__ volatile ("wfi");
    }
}
