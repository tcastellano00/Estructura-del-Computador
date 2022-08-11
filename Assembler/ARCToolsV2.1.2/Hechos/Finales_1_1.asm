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
numA: -5
numB: -89
a_start .equ 3000

limpiar %r16
limpiar %r1
limpiar %r2
limpiar %r3

!preparo los numeros.
add %r15, %r0, %r16
ld [numA], %r1
ld [numB], %r2
push %r1
push %r2
limpiar %r1
limpiar %r2

!preparo el array
ld [address], %r8
ld [numA], %r1
st %r1, %r8

!comienzo ej
pop %r1
pop %r2

addcc %r1, %r2, %r3
bvs excede !deberia ser bvs

call finalizar !termino.

excede:
	limpiar %r5 !contiene la direccion del elemento.
	limpiar %r6 !contiene la cantidad de elementos.
	ld [address], %r5
	ld [largo], %r6
	ba excede_loop

excede_loop:
	andcc %r6, %r6, %r0
	be finalizar
	st %r0, %r5
	add %r5, 4, %r5
	add %r6, -1, %r6
	ba excede_loop

finalizar:
	jmpl %r16, 4, %r0 !salgo del main.

largo: 12
address: a_start

.org a_start
A: .dwb 12

.end
