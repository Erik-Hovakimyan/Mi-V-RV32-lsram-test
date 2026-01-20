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
    "GPIO map:\r\n"
    "  IN2  (IRQ neg edge) = START button (active-low)\r\n"
    "  IN3  (IRQ pos edge) = DONE irq (done_irq)\r\n"
    "  OUT4             = start_test pulse\r\n"
    "  OUT5             = clr_status pulse\r\n"
    "  IN6              = error_latch status\r\n"
    "  IN7              = done_latch status\r\n"
    "LEDs: OUT[3:0] = PASS/FAIL indicator (ON=FAIL, OFF=PASS)\r\n"
    "Registers per MIV_ESS: CLR 0x80 IN 0x90 OUT 0xA0\r\n";

/* ---------------- ESS GPIO base ---------------- */
#define ESS_GPIO_BASE         0x75000000u
#define GPIO_INT_CLEAR_REG    (*(volatile uint32_t *)(ESS_GPIO_BASE + 0x80u))
#define GPIO_IN_REG           (*(volatile uint32_t *)(ESS_GPIO_BASE + 0x90u))
#define GPIO_OUT_REG          (*(volatile uint32_t *)(ESS_GPIO_BASE + 0xA0u))

/* Optional LEDs on OUT[3:0] */
#define LED_MASK              0x0Fu

/* Inputs */
#define GPIO2_MASK            (1u << 2)   /* START button (active-low) */
#define GPIO3_MASK            (1u << 3)   /* DONE irq */
#define GPIO6_ERR_MASK        (1u << 6)   /* error_latch */
#define GPIO7_DONE_MASK       (1u << 7)   /* done_latch */

/* Outputs to SRAM test module */
#define START_TEST_MASK       (1u << 4)   /* GPIO_OUT[4] -> start_test pulse */
#define CLR_STATUS_MASK       (1u << 5)   /* GPIO_OUT[5] -> clr_status pulse */

/* ---------------- PLIC ---------------- */
#define PLIC_BASE             0x70000000u
#define PLIC_ENABLE_REG       (*(volatile uint32_t *)(PLIC_BASE + 0x00002000u))
#define PLIC_CLAIMCOMP_REG    (*(volatile uint32_t *)(PLIC_BASE + 0x00200004u))
#define PLIC_PRIORITY_REG(id) (*(volatile uint32_t *)(PLIC_BASE + 4u * (id)))

#define PLIC_ID_START         1u
#define PLIC_ID_DONE          2u

/* ---------------- SysTick (debounce only) ---------------- */
#define SYSTICK_HZ            1000u
static volatile uint64_t g_systick_ticks = 0;

void SysTick_Handler(void)
{
    g_systick_ticks++;
}

void Software_IRQHandler(void)
{
    MRV_clear_soft_irq();
}

/* ---------------- Timing/state ---------------- */
static volatile bool     g_waiting_done   = false;
static volatile bool     g_result_ready   = false;
static volatile uint64_t g_start_time     = 0;
static volatile uint64_t g_stop_time      = 0;
static volatile uint32_t g_status_in_done = 0u; /* snapshot of GPIO_IN on DONE */

/* Debounce (ms) */
#define START_DEBOUNCE_MS     50u
static volatile uint64_t g_last_start_ms  = 0;

/* Timeout in MTIME ticks (NOTE: adjust to your MTIME frequency!) */
#define DONE_TIMEOUT_TICKS    5000u

/* ---------------- MTIME frequency ----------------
 * Set this to your MTIME clock. In your log it is 50 MHz.
 */
#define MTIME_FREQ_HZ         (50000000ULL)

/* ---------------- UART print u64 ---------------- */
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

/* ---------------- Read MTIME (64-bit) ---------------- */
static inline uint64_t read_mtime_u64(void)
{
    uint32_t hi0, lo, hi1;
    do {
        __asm volatile ("csrr %0, timeh" : "=r"(hi0));
        __asm volatile ("csrr %0, time"  : "=r"(lo));
        __asm volatile ("csrr %0, timeh" : "=r"(hi1));
    } while (hi0 != hi1);
    return ((uint64_t)hi1 << 32) | lo;
}

/* ---------------- Convert ticks to nanoseconds ---------------- */
static inline uint64_t mtime_ticks_to_ns(uint64_t ticks)
{
    if (MTIME_FREQ_HZ == 0u) return 0u;
    return (ticks * 1000000000ULL) / MTIME_FREQ_HZ;
}

/* Print microseconds with 3 decimals, e.g. 0.920 us */
static void uart_print_us_3dp_from_ticks(uint64_t ticks)
{
    uint64_t ns = mtime_ticks_to_ns(ticks);
    uint64_t us_int  = ns / 1000ULL;
    uint64_t us_frac = ns % 1000ULL;

    uart_print_u64(us_int);
    UART_polled_tx_string(&g_uart, (const uint8_t *)".");
    if (us_frac < 100) UART_polled_tx_string(&g_uart, (const uint8_t *)"0");
    if (us_frac < 10)  UART_polled_tx_string(&g_uart, (const uint8_t *)"0");
    uart_print_u64(us_frac);
}

/* ---------------- GPIO helpers ---------------- */
static inline void pulse_out(uint32_t bitmask)
{
    GPIO_OUT_REG |= bitmask;
    GPIO_OUT_REG &= ~bitmask;
}
static inline void leds_on(void)  { GPIO_OUT_REG |=  LED_MASK; }
static inline void leds_off(void) { GPIO_OUT_REG &= ~LED_MASK; }

/* ---------------- External IRQ Handler ---------------- */
uint8_t External_IRQHandler(void)
{
    uint32_t id = PLIC_CLAIMCOMP_REG;

    if (id == PLIC_ID_START)
    {
        if ((GPIO_IN_REG & GPIO2_MASK) == 0u) /* active-low */
        {
            uint64_t now_ms = g_systick_ticks;

            if ((now_ms - g_last_start_ms) >= START_DEBOUNCE_MS)
            {
                g_last_start_ms = now_ms;

                /* Clear previous done/error latches in SRAM test module */
                pulse_out(CLR_STATUS_MASK);

                /* Start timing */
                g_start_time = read_mtime_u64();
                g_waiting_done = true;
                g_result_ready = false;

                /* Start SRAM test */
                pulse_out(START_TEST_MASK);

                /* IMPORTANT:
                 * LEDs are now PASS/FAIL indicator only.
                 * Do NOT turn LEDs on/off here.
                 */
            }
        }

        GPIO_INT_CLEAR_REG = GPIO2_MASK;
    }
    else if (id == PLIC_ID_DONE)
    {
        if (g_waiting_done)
        {
            g_stop_time = read_mtime_u64();
            g_waiting_done = false;
            g_result_ready = true;

            g_status_in_done = GPIO_IN_REG;
        }

        /* Clear DONE latch for next run */
        pulse_out(CLR_STATUS_MASK);

        /* IMPORTANT:
         * LEDs are handled in main() after we decode PASS/FAIL.
         * Do NOT touch LEDs here.
         */
        GPIO_INT_CLEAR_REG = GPIO3_MASK;
    }

    if (id != 0u)
    {
        PLIC_CLAIMCOMP_REG = id;
    }

    return 0u;
}

static void plic_init_two_sources(void)
{
    PLIC_PRIORITY_REG(PLIC_ID_START) = 1u;
    PLIC_PRIORITY_REG(PLIC_ID_DONE)  = 1u;

    PLIC_ENABLE_REG = (1u << PLIC_ID_START) | (1u << PLIC_ID_DONE);

    GPIO_INT_CLEAR_REG = GPIO2_MASK | GPIO3_MASK;
}

static void uart_print_hex32(uint32_t v)
{
    char hex[9];
    const char *h = "0123456789ABCDEF";
    hex[0] = h[(v >> 28) & 0xF];
    hex[1] = h[(v >> 24) & 0xF];
    hex[2] = h[(v >> 20) & 0xF];
    hex[3] = h[(v >> 16) & 0xF];
    hex[4] = h[(v >> 12) & 0xF];
    hex[5] = h[(v >>  8) & 0xF];
    hex[6] = h[(v >>  4) & 0xF];
    hex[7] = h[(v >>  0) & 0xF];
    hex[8] = '\0';
    UART_polled_tx_string(&g_uart, (const uint8_t *)hex);
}

int main(void)
{
    UART_init(&g_uart,
              COREUARTAPB0_BASE_ADDR,
              BAUD_VALUE_115200,
              (DATA_8_BITS | NO_PARITY));

    UART_polled_tx_string(&g_uart, msg_start);
    UART_polled_tx_string(&g_uart, msg_help);

    UART_polled_tx_string(&g_uart, (const uint8_t *)"MTIME_FREQ_HZ = ");
    uart_print_u64(MTIME_FREQ_HZ);
    UART_polled_tx_string(&g_uart, (const uint8_t *)"\r\n");

    /* Start with outputs cleared and LEDs OFF */
    GPIO_OUT_REG = 0u;
    leds_off();

    plic_init_two_sources();

    HAL_enable_interrupts();
    MRV_enable_local_irq(MRV32_EXT_IRQn);

    /* 1ms SysTick for debounce */
    MRV_systick_config(SYS_CLK_FREQ / SYSTICK_HZ);
    UART_polled_tx_string(&g_uart,
        (const uint8_t *)"SysTick configured at 1000 Hz (1 tick = 1 ms)\r\n");

    while (1u)
    {
        if (g_waiting_done)
        {
            uint64_t now = read_mtime_u64();
            if ((now - g_start_time) > (uint64_t)DONE_TIMEOUT_TICKS)
            {
                g_waiting_done = false;

                UART_polled_tx_string(&g_uart,
                    (const uint8_t *)"\r\nERROR: SRAM DONE TIMEOUT\r\n");

                /* Timeout is treated as FAIL -> turn on 4 LEDs */
                leds_on();

                /* Clear latches for safety */
                pulse_out(CLR_STATUS_MASK);
            }
        }

        if (g_result_ready)
        {
            uint64_t start = g_start_time;
            uint64_t stop  = g_stop_time;
            uint64_t dt_ticks = (stop >= start) ? (stop - start) : 0u;

            uint64_t dt_ns = mtime_ticks_to_ns(dt_ticks);

            uint32_t in = g_status_in_done;
            bool error = ((in & GPIO6_ERR_MASK) != 0u);
            bool done  = ((in & GPIO7_DONE_MASK) != 0u);

            g_result_ready = false;

            UART_polled_tx_string(&g_uart, (const uint8_t *)"\r\nGPIO_IN snapshot = 0x");
            uart_print_hex32(in);
            UART_polled_tx_string(&g_uart, (const uint8_t *)"\r\n");

            UART_polled_tx_string(&g_uart, (const uint8_t *)"done_latch(GPIO7) = ");
            UART_polled_tx_string(&g_uart, (const uint8_t *)(done ? "1" : "0"));
            UART_polled_tx_string(&g_uart, (const uint8_t *)", error_latch(GPIO6) = ");
            UART_polled_tx_string(&g_uart, (const uint8_t *)(error ? "1" : "0"));
            UART_polled_tx_string(&g_uart, (const uint8_t *)"\r\n");

            UART_polled_tx_string(&g_uart, (const uint8_t *)"SRAM TEST: ");
            if (error) {
                UART_polled_tx_string(&g_uart, (const uint8_t *)"FAIL\r\n");
                /* FAIL -> turn ON all 4 LEDs */
                leds_on();
            } else {
                UART_polled_tx_string(&g_uart, (const uint8_t *)"PASS\r\n");
                /* PASS -> turn OFF LEDs */
                leds_off();
            }

            UART_polled_tx_string(&g_uart, (const uint8_t *)"Delta mtime ticks = ");
            uart_print_u64(dt_ticks);

            UART_polled_tx_string(&g_uart, (const uint8_t *)"  (");
            uart_print_u64(dt_ns);
            UART_polled_tx_string(&g_uart, (const uint8_t *)" ns, ");
            uart_print_us_3dp_from_ticks(dt_ticks);
            UART_polled_tx_string(&g_uart, (const uint8_t *)" us)\r\n");
        }

        __asm__ volatile ("wfi");
    }
}