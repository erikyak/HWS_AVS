.data
factargprint: .asciz "Max factorial argument before overflow: " 
factprint: .asciz "\nMax factorial value before overflow: " 
recursfactargprint: .asciz "\nMax factorial argument before overflow(recursion): " 
recursfactprint: .asciz "\nMax factorial value before overflow(recursion): " 
.text
main:
	li a7 4
	la a0 factargprint
	ecall
	jal fact		# Calculating the factorial directly
	li a7 1
	ecall
	li a7 4
	la a0 factprint	
	ecall
	mv a0 a1
	li a7 1
	ecall
	
	
	li a7 4
	la a0 recursfactargprint
	ecall
	jal recursfactsetup	# Calculating the factorial by recursion
	li a7 1
	ecall
	li a7 4
	la a0 recursfactprint
	ecall
	mv a0 a1
	li a7 1
	ecall
	li a7 10
	ecall

fact:
	addi sp sp -4
	sw ra (sp)		# Memoring ra (just in case)
	li t1 1
	li t2 1
	li t3 2
	li t4 2
loop:
	addi t3 t3 -1
	innerloop:		# Calculating factorial by summing because if you multiply there'll be overflow,
		add t1 t1 t2	# but value'll be higher than before
		blt t1 t2 end
		addi t3 t3 -1
		bgtz t3 innerloop
	mv t2 t1
	addi t4 t4 1
	mv t3 t4
	j loop			# Calculating factorial before overflow happens
end:
	lw ra (sp)		# Restoring ra
	addi sp sp 4
	mv t3 t4
	addi t3 t3 -1
	mv a0 t3
	mv a1 t2
	ret			# Return a0 as factorial argument, and a1 as factorial value


recursfactsetup:
	li a0 10000		# Calculating up to 10000'th factorial (obviously, there'll be overflow before 10000'th number)
	mv t4 sp		# Memoring sp, ra and s1 for overflow situation
	mv t5 ra
	mv t6 s1
recursfact:
	addi sp sp -8		# Memoring ra and s1 for every iteration
	sw ra 4(sp)
	sw s1 (sp)
	mv s1 a0
	addi a0 s1 -1
	blez a0 a0plus		# If a0 equals 0 making a0 equals 1 then going to done
	jal recursfact		# If a0 not equals 0, going for next iteration (n-1)!
	mv t2 s1		# Calculating factorial
	addi t2 t2 -1
	mv t3 a0
	mv a1 s1
	addi a1 a1 -1
	recursinnerloop:
		add a0 a0 t3
		blt a0 t3 overflow
		addi a1 a1 -1
		bgtz a1 recursinnerloop
done:				# Restoring values of ra, s1 and partly sp and return a0 for previos iteration
	lw s1 (sp)
	lw ra 4(sp)
	addi sp sp 8
	ret
overflow:			# Restoring values of ra, sp and s16 then return a0 as factorial argument, and a1 as factorial value
	mv sp t4
	mv ra t5
	mv s1 t6
	mv a1 t3
	mv a0 t2
	ret
a0plus:
	addi a0 a0 1
	j done