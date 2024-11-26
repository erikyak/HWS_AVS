.globl strncpy
.include "macrolib.s"
.text
strncpy:
	push(ra)
	mv t0 a0
	mv t1 a1
	mv t2 a2
	loop:
		lb t3 (t1)
		beqz t3 end
		beqz t2 end
		sb t3 (t0)
		plus1(t0)
		plus1(t1)
		addi t2 t2 -1
		j loop
	end:
	pop(ra)
	ret