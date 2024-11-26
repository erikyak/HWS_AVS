li t1 1
li t2 1
li t3 2
li t4 2
li t5 13
loop:
	addi t3 t3 -1
	innerloop:
		add t1 t1 t2
		addi t3 t3 -1
		bgtz t3 innerloop
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
	li a0 '\n'
	li a7 11
	ecall
	li a0 '\n'
	li a7 11
	ecall
	li a0 '\n'
	li a7 11
	ecall
	mv t2 t1
	beq t5 t4 end
	addi t4 t4 1
	mv t3 t4
	j loop
end:
	li a7 10
	ecall