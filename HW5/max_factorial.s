li t1 1
li t2 1
li t3 2
li t4 2
loop:
	addi t3 t3 -1
	innerloop:
		add t1 t1 t2
		blt t1 t2 end
		addi t3 t3 -1
		bgtz t3 innerloop
	mv t2 t1
	addi t4 t4 1
	mv t3 t4
	j loop
end:
	mv a0 t4
	li a7 1
	ecall
	li a0 '\n'
	li a7 11
	ecall
	mv a0 t2
	li a7 1
	ecall
	li a0 '\n'
	li a7 11
	ecall
	mv a0 t1
	li a7 1
	ecall
	li a0 '\n'
	li a7 11
	ecall
	li a7 10
	ecall