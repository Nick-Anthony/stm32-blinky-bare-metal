.cpu cortex-m4
.thumb
.syntax unified
.fpu softvfp

.global vtable
.global reset_handler

.type vtable, %object
.section .vector_table, "a",%progbits
vtable:
	.word _estack
	.word reset_handler
.size vtable, .-vtable

/*
 * The Reset handler. Called on reset.
 */
.type reset_handler, %function
reset_handler:
	LDR	r0, =_sdata
	LDR	r1, =_edata
	LDR	r2, =_sidata
	MOVS	r3, #0
	B	copy_data_check

copy_data_loop:
	LDR	r4, [r2, r3]
	STR	r4, [r0, r3]
	ADDS	r3, r3, #4
	B copy_data_check

copy_data_check:
	ADDS	r4, r0, r3
	CMP	r4, r1
	BCC	copy_data_loop
	
	// data copy done, now set up BSS Zeroing
	LDR	r2, =_sbss
	LDR	r4, =_ebss
	MOVS	r3, #0
	B	zero_bss_check

zero_bss_loop:
	STR	r3, [r2]
	ADDS	r2, r2, #4
	B	zero_bss_check

zero_bss_check:
	CMP	r2, r4
	BCC	zero_bss_loop

	BL	main

infinite_loop:
	B	infinite_loop

.size reset_handler, .-reset_handler

