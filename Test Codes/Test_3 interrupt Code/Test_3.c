#include <stdint.h>
#include "hal/hal.h"
#include "miv_rv32_hal/miv_rv32_hal.h"

#define ESS_GPIO_BASE         0x75000000u

#define GPIO_INT_CLEAR_REG    (*(volatile uint32_t *)(ESS_GPIO_BASE + 0x80u))
#define GPIO_IN_REG           (*(volatile uint32_t *)(ESS_GPIO_BASE + 0x90u))
#define GPIO_OUT_REG          (*(volatile uint32_t *)(ESS_GPIO_BASE + 0xA0u))

#define LED_MASK              0x0Fu
#define GPIO2_MASK            (1u << 2)
#define GPIO3_MASK            (1u << 3)


#define PLIC_BASE             0x70000000u
#define PLIC_ENABLE_REG       (*(volatile uint32_t *)(PLIC_BASE + 0x00002000u))
#define PLIC_CLAIMCOMP_REG    (*(volatile uint32_t *)(PLIC_BASE + 0x00200004u))///////PLIC base + offsets
#define PLIC_PRIORITY_REG(id) (*(volatile uint32_t *)(PLIC_BASE + 4u * (id)))


#define PLIC_ID_GPIO2         1u
#define PLIC_ID_GPIO3         2u

uint8_t External_IRQHandler(void)
{
    uint32_t id = PLIC_CLAIMCOMP_REG;

    if (id == PLIC_ID_GPIO2)
    {

        GPIO_OUT_REG = LED_MASK; ///// First pin (GPIO2) high -> turn ON all LEDs

        GPIO_INT_CLEAR_REG = GPIO2_MASK;////// Clear latch
    }
    else if (id == PLIC_ID_GPIO3)
    {

        GPIO_OUT_REG = 0u; ///// Second pin (GPIO3) high -> turn OFF all LEDs

        GPIO_INT_CLEAR_REG = GPIO3_MASK;//////Clear latch
    }

    if (id != 0u)
    {
        PLIC_CLAIMCOMP_REG = id;//// Complete interrupt at PLIC
    }

    return 0u;
}

static void plic_init_two_gpio_sources(void)
{
    PLIC_PRIORITY_REG(PLIC_ID_GPIO2) = 1u;///giving non zero value
    PLIC_PRIORITY_REG(PLIC_ID_GPIO3) = 1u;///

    PLIC_ENABLE_REG = (1u << PLIC_ID_GPIO2) | (1u << PLIC_ID_GPIO3);///Enable interrupt IDs 1 and 2

    GPIO_INT_CLEAR_REG = GPIO2_MASK | GPIO3_MASK;/////Clear any stale latched interrupts
}

int main(void)
{
    GPIO_OUT_REG = 0u;

    plic_init_two_gpio_sources();

    MRV_enable_local_irq(MRV32_EXT_IRQn);////Enable MEIE + global interrupts
    MRV_enable_interrupts();

    while (1)
    {
        __asm__ volatile ("wfi");
    }
}
