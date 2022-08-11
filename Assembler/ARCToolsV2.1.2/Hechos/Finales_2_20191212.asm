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
cte .equ 0xA500A120
cte_20 .equ 0xA500A
cte_12 .equ 0x120
a_start .equ 3000

limpiar 	%r1 	!dir array
limpiar	%r2	!cant elementos
limpiar	%r16	!backup main
limpiar	%r17	!dir periferico


ld [direccion], %r1
ld [largo], %r2
add %r15, %r0, %r16

sethi cte_20, %r17
sll %r17, 2, %r17
add %r17, cte_12, %r17

call rellenar_con_periferico

jmpl %r16, 4, %r0

rellenar_con_periferico:
	limpiar %r20
	add %r15, %r0, %r20
	call loop
	jmpl %r20, 4, %r0
	
loop:
	limpiar %r21
	limpiar %r23
	add %r15, %r0, %r21
	andcc %r2, %r2, %r0
	be done
	call leer_periferico
	pop %r23
	st %r23, %r1
	add %r1, 4, %r1
	add %r2, -1, %r2
	add %r21, %r0, %r15
	ba loop

leer_periferico:
	limpiar %r18
	ld %r17, %r18
	sll %r18, 14, %r18
	sra %r18, 14, %r18
	push %r18
	jmpl %r15, 4, %r0

done: jmpl %r15, 4, %r0


!-- array
largo: 1
direccion: a_start
.org a_start
array: .dwb 20


!-- periferico
.org cte
perif: 	0xCAB3FFFF
	0xCAB3FFFF
 	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
	0xCAB3FFFF
 
.end
