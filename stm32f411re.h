#ifndef STM32F411RE_H
#define STM32F411RE_H

#include <stdint.h>

// Base addresses
#define GPIOA_BASE 0x40020000
#define GPIOC_BASE 0x40020800
#define RCC_BASE   0x40023800

typedef struct {
	volatile uint32_t MODER;
	volatile uint32_t OTYPER;
	volatile uint32_t OSPEEDR;
	volatile uint32_t PUPDR;
	volatile uint32_t IDR;
	volatile uint32_t ODR;
	volatile uint32_t BSRR;
	volatile uint32_t LCKR;
	volatile uint32_t AFRL;
	volatile uint32_t AFRH;
} GPIO_TypeDef;

typedef struct {
	volatile uint32_t CR;
	volatile uint32_t PLLCFGR;
	volatile uint32_t CFGR;
	volatile uint32_t CIR;
	volatile uint32_t AHB1RSTR;
	volatile uint32_t AHB2RSTR;
	volatile uint32_t RESERVED0;
	volatile uint32_t RESERVED1;
	volatile uint32_t APB1RSTR;
	volatile uint32_t APB2RSTR;
	volatile uint32_t RESERVED2;
	volatile uint32_t RESERVED3;
	volatile uint32_t AHB1ENR;
	volatile uint32_t AHB2ENR;
	volatile uint32_t RESERVED4;
	volatile uint32_t RESERVED5;
	volatile uint32_t APB1ENR;
	volatile uint32_t APB2ENR;
	volatile uint32_t RESERVED6;
	volatile uint32_t RESERVED7;
	volatile uint32_t AHB1LPENR;
	volatile uint32_t AHB2LPENR;
	volatile uint32_t RESERVED8;
	volatile uint32_t RESERVED9;
	volatile uint32_t BDCR;
	volatile uint32_t CSR;
	volatile uint32_t RESERVED10;
	volatile uint32_t RESERVED11;
	volatile uint32_t SSCGR;
	volatile uint32_t PLLI2SCFGR;
	volatile uint32_t RESERVED12;
	volatile uint32_t DCKCFGR;
} RCC_TypeDef;

#define RCC ((RCC_TypeDef *)RCC_BASE)

#define GPIOA ((GPIO_TypeDef *)GPIOA_BASE)
#define GPIOC ((GPIO_TypeDef *)GPIOC_BASE)

#define PIN_A5 5
#define PIN_C13 13

#endif
