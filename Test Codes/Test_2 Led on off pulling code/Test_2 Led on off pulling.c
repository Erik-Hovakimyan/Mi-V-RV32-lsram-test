#include <stdint.h>

/* From your fpga_design_config.h:
 * COREGPIO_OUT_BASE_ADDR = 0x75000000UL
 * This matches the ESS GPIO module base (MIV_ESS base + 0x5000000).
 */
#define ESS_GPIO_BASE         0x75000000u

#define GPIO_IN_REG           (*(volatile uint32_t *)(ESS_GPIO_BASE + 0x90u))////ESS GPIO registers (APB_WIDTH = 32)
#define GPIO_OUT_REG          (*(volatile uint32_t *)(ESS_GPIO_BASE + 0xA0u))

#define LED_MASK              0x0Fu/// leds that we are masking

#define GPIO4_MASK            (1u << 4)//// inputs
#define GPIO5_MASK            (1u << 5)

int main(void)
{
    GPIO_OUT_REG = 0u; //// strating with the led off

    while (1)
    {
        uint32_t in = GPIO_IN_REG;
        if (in & (GPIO4_MASK | GPIO5_MASK)) //// If GPIO4 or GPIO5 is HIGH -> LEDs ON, else
        {
            GPIO_OUT_REG = LED_MASK; //// LEDs ON
        }
        else
        {
            GPIO_OUT_REG = 0u; //// LEDs OFF
        }
    }
}
