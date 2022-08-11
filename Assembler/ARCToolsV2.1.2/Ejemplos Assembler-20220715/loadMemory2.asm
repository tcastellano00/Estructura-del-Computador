.begin	
.org 2048
	!Posicion 0xFF451200
	X22 .equ 0x051200
	X10 .equ 0x3FD144

	sethi X22,%r1
	sethi X10,%r2
	srl %r1,10,%r1
	or %r1,%r2,%r3

.end
