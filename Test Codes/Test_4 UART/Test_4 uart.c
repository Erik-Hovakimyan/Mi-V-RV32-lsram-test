/*******************************************************************************
 * UART test program
 * Prints messages on the serial terminal to verify UART operation.
 ******************************************************************************/

#include <stdint.h>
#include "drivers/fpga_ip/CoreUARTapb/core_uart_apb.h"
#include "miv_rv32_hal/sample_fpga_design_config.h"
#include "miv_rv32_hal/miv_rv32_hal.h"

/* --------------------------------------------------
 * UART test messages (same style as your example)
 * -------------------------------------------------- */
const uint8_t uart_test_start_message[] =
        "\r\n\r\n\r\n **** UART TEST START ****\r\n\r\n\r\n";

const uint8_t uart_test_hello_message[] =
        "\r\n Hello from CoreUARTapb! UART is working. \r\n";

/* --------------------------------------------------
 * UART instance
 * -------------------------------------------------- */
UART_instance_t g_uart;

/* --------------------------------------------------
 * main
 * -------------------------------------------------- */
int main(void)
{
    /**************************************************************
     * Initialize CoreUARTapb
     **************************************************************/
    UART_init(&g_uart,
              COREUARTAPB0_BASE_ADDR,
              BAUD_VALUE_115200,
              (DATA_8_BITS | NO_PARITY));
    MRV_enable_local_irq(MRV32_MSYS_EIE1_IRQn);
    HAL_enable_interrupts();

    /**************************************************************
     * Print test messages
     **************************************************************/
    UART_polled_tx_string(&g_uart, uart_test_start_message);
    UART_polled_tx_string(&g_uart, uart_test_hello_message);

    /**************************************************************
     * Print periodically so you can see it clearly
     **************************************************************/
    while (1u)
    {
        UART_polled_tx_string(&g_uart,
            (const uint8_t *)"UART TEST: still running...\r\n");

        /* simple delay */
        for (volatile uint32_t i = 0; i < 3000000u; i++)
        {
            __asm__ volatile ("nop");
        }
    }

    return 0;
}
