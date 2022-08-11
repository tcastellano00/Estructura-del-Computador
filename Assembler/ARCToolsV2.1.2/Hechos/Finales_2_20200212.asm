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
cte .equ 0xC21000A4
cte_20 .equ 0xC2100
cte_12 .equ 0x0A4

limpiar %r1 !valor actual perif
limpiar %r2 !cantidad positivos
limpiar %r3 !longitud
limpiar %r16 !backup main
limpiar %r17 !direccion periferico

add %r15, %r0, %r16

sethi cte_20, %r17
sll %r17, 2, %r17
add %r17, cte_12, %r17

ld [cant_a_leer], %r3

call contar_positivos

push %r2

jmpl %r16, 4, %r0

contar_positivos:
	andcc %r3, %r3, %r0	!me fijo si es 0
	be done
	limpiar %r1
	ld %r17, %r1		!cargo valor de periferico
	add %r17, 4, %r17		!muevo el perif para simular.
	add %r3, -1, %r3		!resto uno a la cantidad por leer
	srl %r1, 31, %r1		!me quedo con el bit mas significativo para saber su signo
	andcc %r1, %r1, %r0
	be es_positivo
	ba contar_positivos

es_positivo:
	add %r2, 1, %r2
	ba contar_positivos

done: jmpl %r15, 4, %r0
	

cant_a_leer: 64
.org cte
perif: 	0x0FFFFFFF
	0x0FFFFFFF
 	0x0FFFFFFF
 	0x0FFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 	0xFFFFFFFF
 
 
.end
