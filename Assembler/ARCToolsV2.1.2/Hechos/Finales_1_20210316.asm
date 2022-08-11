.begin
.macro push arg
	add %r14, -4, %r14
	st arg, %r14
.endmacro
.macro pop arg
	ld %r14, arg
	add %r14, 4, %r14
.endmacro
.macro limpiar arg
	and %r0, %r0, arg
.endmacro
.macro cargar_cte cte_A, cte_B, bitsToLeft, reg
	sethi cte_A, reg
	sll reg, 2, reg
	add reg, cte_B, reg
.endmacro

.org 2048

cte_A .equ 0x1F652704
cte_A_20 .equ 0x1F652
cte_A_12 .equ 0x704
cte_B .equ 0x1F652720
cte_B_20 .equ 0x1F652
cte_B_12 .equ 0x720

limpiar %r1
limpiar %r2
limpiar %r3
limpiar %r16

add %r15, %r0, %r16 !backup dir main.

cargar_cte cte_A_20, cte_A_12, 2, %r1
cargar_cte cte_B_20, cte_B_12, 2, %r2

push %r2
push %r1

call sumar_direcciones

pop %r9

jmpl %r16, 4, %r0

sumar_direcciones: 
	limpiar %r4
	limpiar %r5
	limpiar %r6
	limpiar %r7
	limpiar %r8

	pop %r4
	pop %r5

	ld %r4, %r6
	ld %r5, %r7

	add %r6, %r7, %r8
	push %r8

.org cte_A
A: 545

.org cte_B
B: 155

.end
