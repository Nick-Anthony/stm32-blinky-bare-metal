TARGET = main
CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

CFLAGS = -mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard
CFLAGS += -O0 -Wall -nostdlib
LDFLAGS = --specs=nosys.specs -lgcc -T./STM32F411RETx.ld

all: $(TARGET).bin

$(TARGET).elf: startup.o main.c
	$(CC) $(CFLAGS) $(LDFLAGS) startup.o main.c -o $(TARGET).elf

startup.o: startup.S
	$(CC) -x assembler-with-cpp -c $(CFLAGS) startup.S -o startup.o

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin

flash: $(TARGET).bin
	st-flash write $(TARGET).bin 0x08000000

clean:
	rm -f *.o *.elf *.bin
