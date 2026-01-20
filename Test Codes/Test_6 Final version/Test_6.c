#include <stdint.h>
#include <stdbool.h>

#include "hal/hal.h"
#include "miv_rv32_hal/miv_rv32_hal.h"
#include "miv_rv32_hal/sample_fpga_design_config.h"
#include "drivers/fpga_ip/CoreUARTapb/core_uart_apb.h"

/* ========================= UART ========================= */
/*
 * Purpose:
 *  - Initialize and use UART for printing debug/status messages to your PC terminal.
 *  - uart_msg() prints fixed strings.
 *  - uart_putc() prints a single character by wrapping it as a 2-byte string (char + '\0').
 *  - uart_print_u64() prints a 64-bit number in decimal without using printf().
 */

static UART_instance_t g_uart;

static void uart_msg(const char *s)
{
    UART_polled_tx_string(&g_uart, (const uint8_t *)s);
}

/* CoreUARTapb always has UART_polled_tx_string(), so use it even for 1 char */
static void uart_putc(char c)
{
    uint8_t s[2];
    s[0] = (uint8_t)c;
    s[1] = 0u;                       /* null terminator so it's a valid C string */
    UART_polled_tx_string(&g_uart, s);
}

/* Print unsigned 64-bit integer (decimal) */
static void uart_print_u64(uint64_t v)
{
    /*
     * Purpose:
     *  - Convert a number like 12345 into ASCII characters '1''2''3''4''5'
     *  - Then send them to UART.
     *
     * How:
     *  - Repeatedly take last digit with v % 10 and shrink v with v /= 10
     *  - This produces digits in reverse order, so we print them back in reverse.
     */

    char buf[24];
    uint32_t i = 0;

    if (v == 0u) {
        uart_putc('0');
        return;
    }

    /* Collect digits in reverse order */
    while ((v > 0u) && (i < sizeof(buf))) {
        buf[i++] = (char)('0' + (v % 10u));
        v /= 10u;
    }

    /* Output digits in correct order */
    while (i > 0u) {
        uart_putc(buf[--i]);
    }
}

/* ========================= ESS GPIO ========================= */
/*
 * Purpose:
 *  - These are the memory-mapped registers for ESS GPIO block:
 *      CLR @ +0x80 : clear input interrupt latches
 *      IN  @ +0x90 : read input pins (GPIO2/3/6/...)
 *      OUT @ +0xA0 : drive output pins (LEDs, start_test, clr_status)
 *
 *  - LED behavior:
 *      leds_fail() turns ON LEDs (OUT[3:0] = 1)
 *      leds_pass() turns OFF LEDs (OUT[3:0] = 0)
 *
 *  - pulse_out(mask) generates a short pulse:
 *      set the bit, then clear it immediately
 *    This is used for start_test and clr_status lines.
 */

#define ESS_GPIO_BASE         0x75000000u
#define GPIO_INT_CLEAR_REG    (*(volatile uint32_t *)(ESS_GPIO_BASE + 0x80u))
#define GPIO_IN_REG           (*(volatile uint32_t *)(ESS_GPIO_BASE + 0x90u))
#define GPIO_OUT_REG          (*(volatile uint32_t *)(ESS_GPIO_BASE + 0xA0u))

/* LEDs on OUT[3:0] */
#define LED_MASK              0x0Fu

static inline void leds_fail(void) {
    GPIO_OUT_REG |= LED_MASK;
}

static inline void leds_pass(void) {
    GPIO_OUT_REG &= ~LED_MASK;
}

/* Inputs */
#define GPIO2_MASK            (1u << 2)   /* START button (active-low) */
#define GPIO3_MASK            (1u << 3)   /* DONE irq */
#define GPIO6_ERR_MASK        (1u << 6)   /* error_latch */

/* Outputs */
#define START_TEST_MASK       (1u << 4)   /* start_test pulse */
#define CLR_STATUS_MASK       (1u << 5)   /* clr_status pulse */

static void pulse_out(uint32_t bitmask)
{
    /* Purpose: generate a short rising edge on the selected output bit */
    GPIO_OUT_REG |= bitmask;
    GPIO_OUT_REG &= ~bitmask;
}

/* ========================= PLIC ========================= */
/*
 * Purpose:
 *  - Configure the Platform-Level Interrupt Controller to enable 2 interrupt sources:
 *      PLIC_ID_START = 1  (GPIO2 start interrupt)
 *      PLIC_ID_DONE  = 2  (GPIO3 done interrupt)
 *
 *  - plic_init_two_sources():
 *      - sets priority for both interrupts
 *      - enables both sources
 *      - clears any stale GPIO interrupt latches so the first press works cleanly
 */

#define PLIC_BASE             0x70000000u
#define PLIC_ENABLE_REG       (*(volatile uint32_t *)(PLIC_BASE + 0x00002000u))
#define PLIC_CLAIMCOMP_REG    (*(volatile uint32_t *)(PLIC_BASE + 0x00200004u))
#define PLIC_PRIORITY_REG(id) (*(volatile uint32_t *)(PLIC_BASE + 4u * (id)))

#define PLIC_ID_START         1u
#define PLIC_ID_DONE          2u

static void plic_init_two_sources(void)
{
    PLIC_PRIORITY_REG(PLIC_ID_START) = 1u;
    PLIC_PRIORITY_REG(PLIC_ID_DONE)  = 1u;

    PLIC_ENABLE_REG = (1u << PLIC_ID_START) | (1u << PLIC_ID_DONE);

    /* Clear any stale GPIO latches */
    GPIO_INT_CLEAR_REG = GPIO2_MASK | GPIO3_MASK;
}

/* ========================= SysTick (debounce) ========================= */
/*
 * Purpose:
 *  - SysTick is configured to tick at 1000 Hz (1ms per tick).
 *  - We use it ONLY for button debounce:
 *      - when a start interrupt happens, we check time since last accepted press
 *      - if less than 50ms, ignore (bounce)
 *
 * Variables:
 *  - g_ms: incremented every 1ms by SysTick_Handler()
 *  - g_last_start_ms: last time we accepted a start press
 */

#define SYSTICK_HZ            1000u
#define START_DEBOUNCE_MS     50u

static volatile uint64_t g_ms = 0;
static volatile uint64_t g_last_start_ms = 0;

void SysTick_Handler(void) {
    g_ms++;
}

void Software_IRQHandler(void) {
    /* clear software interrupt if it fires */
    MRV_clear_soft_irq();
}

/* ========================= MTIME timing ========================= */
/*
 * Purpose:
 *  - MTIME is a free-running 64-bit counter (like a stopwatch).
 *  - read_mtime_u64() reads it safely as 64-bit:
 *      read high, read low, read high again
 *      if high changed, retry (prevents roll-over issue)
 *
 * MTIME_FREQ_HZ:
 *  - tells us how many ticks per second MTIME increments.
 *  - used to convert ticks -> ns/us.
 *
 * DONE_TIMEOUT_TICKS:
 *  - if DONE doesn't happen after this many ticks, we declare TIMEOUT.
 */

#define MTIME_FREQ_HZ         (50000000ULL) /* your MTIME clock */
#define DONE_TIMEOUT_TICKS    5000u

static uint64_t read_mtime_u64(void)
{
    uint32_t hi0, lo, hi1;
    do {
        __asm volatile ("csrr %0, timeh" : "=r"(hi0));
        __asm volatile ("csrr %0, time"  : "=r"(lo));
        __asm volatile ("csrr %0, timeh" : "=r"(hi1));
    } while (hi0 != hi1);

    return ((uint64_t)hi1 << 32) | lo;
}

/* Print microseconds with 3 decimals from MTIME ticks */
static void uart_print_us_3dp(uint64_t ticks)
{
    /*
     * Purpose:
     *  - Convert elapsed ticks to time and print it as:  <us_int>.<us_frac> us
     *
     * Math:
     *  - ns = ticks * 1e9 / MTIME_FREQ_HZ
     *  - us = ns / 1000
     */

    uint64_t ns = 0u;

    if (MTIME_FREQ_HZ != 0u)
    {
        ns = (ticks * 1000000000ULL) / MTIME_FREQ_HZ;  /* ticks -> nanoseconds */
    }

    uint64_t us_int  = ns / 1000ULL;  /* whole microseconds */
    uint64_t us_frac = ns % 1000ULL;  /* fractional (0..999), printed as 3 digits */

    uart_print_u64(us_int);
    uart_putc('.');
    uart_putc((char)('0' + (char)((us_frac / 100u) % 10u)));
    uart_putc((char)('0' + (char)((us_frac / 10u)  % 10u)));
    uart_putc((char)('0' + (char)((us_frac / 1u)   % 10u)));
}

/* ========================= State ========================= */
/*
 * Purpose:
 *  - These variables are shared between ISR and main loop.
 *
 * Flags:
 *  - g_waiting_done: true after START until DONE occurs (or timeout)
 *  - g_result_ready: set by DONE ISR, consumed by main() to print results
 *
 * Timing:
 *  - g_start_time: MTIME tick count when test started
 *  - g_stop_time : MTIME tick count when test finished
 *
 * Status:
 *  - g_status_in_done: snapshot of GPIO_IN when DONE happened (contains error_latch)
 */

static volatile bool     g_waiting_done   = false;
static volatile bool     g_result_ready   = false;
static volatile uint64_t g_start_time     = 0;
static volatile uint64_t g_stop_time      = 0;
static volatile uint32_t g_status_in_done = 0u;

/* ========================= External IRQ ========================= */
/*
 * Purpose:
 *  - Handles external interrupts from PLIC:
 *      - START interrupt (ID=1) from GPIO2 (active-low button)
 *      - DONE  interrupt (ID=2) from GPIO3
 *
 * START path:
 *  - debounce using g_ms
 *  - print "Discovery started" and "Testing SRAM..."
 *  - clear old latches (CLR_STATUS pulse)
 *  - record start time (MTIME)
 *  - pulse START_TEST
 *
 * DONE path:
 *  - record stop time (MTIME)
 *  - snapshot GPIO_IN (to check error latch)
 *  - set g_result_ready so main() prints PASS/FAIL and time
 *  - clear latches for next run
 */

uint8_t External_IRQHandler(void)
{
    uint32_t id = PLIC_CLAIMCOMP_REG;

    if (id == PLIC_ID_START)
    {
        /* active-low START */
        if ((GPIO_IN_REG & GPIO2_MASK) == 0u)
        {
            uint64_t now_ms = g_ms;

            if ((now_ms - g_last_start_ms) >= START_DEBOUNCE_MS)
            {
                g_last_start_ms = now_ms;

                uart_msg("\r\nDiscovery started.\r\n");
                uart_msg("Testing SRAM...\r\n");

                /* Clear previous latched status */
                pulse_out(CLR_STATUS_MASK);

                /* Start timing and test */
                g_start_time = read_mtime_u64();
                g_waiting_done = true;
                g_result_ready = false;

                pulse_out(START_TEST_MASK);
            }
        }

        /* Clear the START interrupt latch */
        GPIO_INT_CLEAR_REG = GPIO2_MASK;
    }
    else if (id == PLIC_ID_DONE)
    {
        if (g_waiting_done)
        {
            g_stop_time = read_mtime_u64();
            g_status_in_done = GPIO_IN_REG;

            g_waiting_done = false;
            g_result_ready = true;
        }

        /* Clear done/error latch for next run */
        pulse_out(CLR_STATUS_MASK);

        /* Clear the DONE interrupt latch */
        GPIO_INT_CLEAR_REG = GPIO3_MASK;
    }

    /* Complete the interrupt in PLIC */
    if (id != 0u) {
        PLIC_CLAIMCOMP_REG = id;
    }

    return 0u;
}

/* ========================= main ========================= */
/*
 * Purpose:
 *  - Initialize UART, GPIO outputs, PLIC, interrupts, and SysTick.
 *  - Wait for events (WFI).
 *
 * Runtime behavior:
 *  - If test is running (g_waiting_done), check timeout using MTIME.
 *  - When DONE ISR sets g_result_ready, main() prints PASS/FAIL and elapsed time.
 */

int main(void)
{
    UART_init(&g_uart,
              COREUARTAPB0_BASE_ADDR,
              BAUD_VALUE_115200,
              (DATA_8_BITS | NO_PARITY));

    uart_msg("\r\n\r\n**** Hello From Armenia ****\r\n");
    uart_msg("Press START to begin.\r\n");

    /* Clear outputs, show PASS (LEDs off) */
    GPIO_OUT_REG = 0u;
    leds_pass();

    plic_init_two_sources();

    HAL_enable_interrupts();
    MRV_enable_local_irq(MRV32_EXT_IRQn);

    /* 1ms SysTick for debounce */
    MRV_systick_config(SYS_CLK_FREQ / SYSTICK_HZ);

    while (1u)
    {
        /* Timeout if DONE never arrives */
        if (g_waiting_done)
        {
            uint64_t now = read_mtime_u64();
            if ((now - g_start_time) > (uint64_t)DONE_TIMEOUT_TICKS)
            {
                g_waiting_done = false;

                uart_msg("\r\nERROR: DONE TIMEOUT\r\n");
                leds_fail();

                /* Clear latches for safety */
                pulse_out(CLR_STATUS_MASK);
            }
        }

        /* When DONE arrives, print PASS/FAIL + time */
        if (g_result_ready)
        {
            g_result_ready = false;

            uint64_t dt_ticks = 0u;

            if (g_stop_time >= g_start_time)
            {
                dt_ticks = g_stop_time - g_start_time; /* elapsed MTIME ticks */
            }

            bool error = ((g_status_in_done & GPIO6_ERR_MASK) != 0u);

            if (error) {
                uart_msg("SRAM TEST: FAIL\r\n");
                leds_fail();
            } else {
                uart_msg("SRAM TEST: PASS\r\n");
                leds_pass();
            }

            uart_msg("Time: ");
            uart_print_u64(dt_ticks);
            uart_msg(" ticks (");
            uart_print_us_3dp(dt_ticks);
            uart_msg(" us)\r\n");
        }

        __asm__ volatile ("wfi");
    }
}