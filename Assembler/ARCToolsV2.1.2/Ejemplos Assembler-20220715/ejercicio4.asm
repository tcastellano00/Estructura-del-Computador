.begin	
.org 2048
	ld X,%r0,%r1
	ld Y,%r0,%r2
	st %r1,%r0,Y
	st %r2,%r0,X

	X: 25
	Y:45
.end
