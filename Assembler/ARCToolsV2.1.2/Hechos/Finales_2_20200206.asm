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

a_start .equ 3000

limpiar %r1 	!dir array
limpiar %r2 	!largo array
limpiar %r3	!promedio
limpiar %r16 	!backup dir

ld [direccion], %r1
ld [largo], %r2
add %r15, %r0, %r16

call calcular_total

srl %r3, 4, %r3	!divido por 16 que es la cantidad de elementos del array.
push %r3		!sube al stack el promedio
jmpl %r16, 4, %r0	!termina.

calcular_total:
	andcc %r2, %r2, %r0
	be done
	limpiar %r20 !elemento
	ld %r1, %r20
	add %r3, %r20, %r3	!acumulo
	add %r1, 4, %r1 		!me muevo en el array
	add %r2, -1, %r2
	ba calcular_total

done:
	jmpl %r15, 4, %r0

direccion: a_start
largo: 16
.org a_start
array: 	10
	10
	10
	10
	10
	10
	10
	10
	10
	10
	10
	10
	10
	10
	10
	10

	
.end
