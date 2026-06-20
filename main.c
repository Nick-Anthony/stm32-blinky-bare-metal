#include "stm32f411re.h"
int main(void) {
  // enable RCC for GPIOA (0) and GPIOC (2)
  RCC->AHB1ENR |= (1 << 0) | (1 << 2);

  // enable output mode on PinA5
  GPIOA->MODER |= (1 << (PIN_A5 * 2));

  // use pull-down on PC13
  GPIOC->PUPDR |= (1 << (PIN_C13 * 2 + 1));

  // create mask for high value on PinA5
  const uint32_t PIN_A5_ODR = (1 << PIN_A5);

  uint8_t prev_state = 0;

  while (1) {
    uint8_t pin_c13_state = (GPIOC->IDR >> PIN_C13) & 0x1;

    if (pin_c13_state && !prev_state) {

      // alternate between enable and disable through xor ^
      GPIOA->ODR ^= PIN_A5_ODR;
    }
    prev_state = pin_c13_state;
  }
  return 0;
}
