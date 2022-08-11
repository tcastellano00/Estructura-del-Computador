.begin

.macro cargar_cte_32 reg, cte1, cte2, left
	sethi cte1, reg
	sll reg, 2, reg
	add reg, cte2, reg
.endmacro

.org 2048
A: .dwb 80000
cte_32 .equ 0xC0102030
cte_20 .equ 0xC0102
cte_12 .equ 0x030

cargar_cte_32 %r1, cte_20, cte_12, 2

ld %r1, %r0, %r2

add %r1, 4, %r1
ld %r1, %r3
add %r3, %r2, %r2

.org 0xC0102030
A:	1
	5
	4
	6
	8
	-2


.end

