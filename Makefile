TARGET = main
CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

CFLAGS = -mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard
CFLAGS += -O0 -Wall -nostdlib
LDFLAGS = --specs=nosys.specs -lgcc -T./STM32F411RETx.ld

all: $(TARGET).bin

$(TARGET).elf: core.o main.c
	$(CC) $(CFLAGS) $(LDFLAGS) core.o main.c -o $(TARGET).elf

core.o: core.S
	$(CC) -x assembler-with-cpp -c $(CFLAGS) core.S -o core.o

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin

flash: $(TARGET).bin
	st-flash write $(TARGET).bin 0x08000000

clean:
	rm -f *.o *.elf *.bin
