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

.org 2048
cte .equ 0xC0102030
cte_20 .equ 0xC0102
cte_12 .equ 0x030

limpiar %r1

add %r0, cte, %r1
ld [cte], %r1

val: 0xC0102030

.end
