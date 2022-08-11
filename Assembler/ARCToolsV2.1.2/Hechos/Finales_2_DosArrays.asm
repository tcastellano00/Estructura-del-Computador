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
pos_start .equ 3000	!posicion donde arranca el array de positivos
neg_start .equ 4000	!posicion donde arranca el array de negativos

limpiar %r1		!dir positivos
limpiar %r2		!largo positivos
limpiar %r3		!dir negativos
limpiar %r4		!largo negativos
limpiar %r16		!back up dir main
limpiar %r17		!dir periferico

add %r15, %r0, %r16
sethi cte_20, %r17
sll %r17, 2, %r17
add %r17, cte_12, %r17

ld [pos_direccion], %r1
ld [pos_largo], %r2
ld [neg_direccion], %r3
ld [neg_largo], %r4

call rellenar_arreglos

jmpl %r16, 4, %r0

rellenar_arreglos:
	andcc %r2, %r2, %r0
	be done
	andcc %r4, %r4, %r0
	be done
	limpiar %r7	!valor leido periferico
	limpiar %r8	!bit pos o neg
	ld %r17, %r7
	add %r17, 4, %r17	!leo y me muevo en el periferico para simularlo
	srl %r7, 31, %r8	!me guardo el bit del signo
	andcc %r8, %r8, %r0
	be rellenar_arreglo_positivo
	st %r7, %r3	!guardo en los negativos
	add %r3, 4, %r3	!muevo la dir del array
	add %r4, -1, %r4	!resto uno en la capacidad
	ba rellenar_arreglos

rellenar_arreglo_positivo:
	st %r7, %r1	!guardo en los positivos
	add %r1, 4, %r1	!muevo la dir del array
	add %r2, -1, %r2	!resto uno en la capacidad
	ba rellenar_arreglos

done: jmpl %r15, 5, %r0
	

pos_largo: 48
pos_direccion: pos_start
neg_largo: 48
neg_direccion: neg_start

.org pos_start
positivos: .dwb 48

.org neg_start
negativos: .dwb 48

.org cte
perif: -1
	2
	3
	4
	-5
	-8
	-12
	9
	-78

.end
