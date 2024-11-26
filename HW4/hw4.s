.data 
array: .space 40							# Creating empty array
arrend:
enter: .asciz "Enter "
number: .asciz " number: "
successanswer: .asciz "Sum of array elements: "
overflownumber: .asciz "Number of summed elements before overflow: "
overflowlastsum: .asciz "Last sum before overflow: "
even: .asciz "Number of even: "
odd: .asciz "Number of odd: "
.text
la t0 array
la t1 arrend
li a1 10		# If user just enter "Enter" this will end filling
li a2 '-'		# Setting this to check if first char is '-'
li a3 1
mv t4 zero
mv t5 zero
li a4 '0'		# This made for getting real number from char
li t3 1
neg a4 a4
fill:
	li a7 4
	la a0 enter
	ecall
	li a7 1
	mv a0 t3
	ecall
	li a7 4
	la a0 number
	ecall
	addi t3 t3 1
	mv t2 zero	# Setting 0 for every iteration
	li a7 12
	ecall		# Reading char
	beq a1 a0 fillend # If entered "Enter" end filling
	bne a2 a0 fillint # If entered '-' remember this and set a0 with '0'
	li a3 0
	li a0 '0'
	fillint:
		add a0 a0 a4 # Making int from char (1 is 49, 0 is 48 as chars, so 1 as number is 49 - 48)
		mul t2 t2 a1 # Multiply number by 10 and in example if you enter firsly 1 and then 2 you'll get 12
		add t2 t2 a0
		li a7 12
		ecall
		bne a0 a1 fillint # Reading chars until you enter "Enter"
	bnez a3 storeint # Making number negative if needed
		neg t2 t2
		li a3 1
	storeint:	# Storing number in array
		sw t2 (t0)
		addi t0 t0 4
		bne t0 t1 fill
fillend:		# Storing position of last element
	mv t6 t0
	la t0 array	# Updating position to start array
sum:
	lw a3 (t0)
	add t4 t4 a3
	bltz a3 lessthanzero # Check for negative overflow
		blt t4 t5 overflow
		j graterthanzero
	lessthanzero:	# Check for positive overflow
		bgt t4 t5 overflow
	graterthanzero:
	mv t5 t4	# Updating pre-last element to last
	addi t0 t0 4
	bne t0 t6 sum	# If current position doesn't equals to last element continue summing
end:			# Success ending
	li a7 4
	la a0 successanswer
	ecall
	li a7 1
	mv a0 t4
	ecall
	j evenoddchecksetup
overflow:		# Overflow ending
	li a7 11
	li a0 '\n'
	ecall
	mv t2 zero
	la t3 array
	neg t3 t3
	add t0 t3 t0
	addi t0 t0 -4
	loop:		# Counting elements summed before overflow
		bltz t0 endloop
		addi t0 t0 -4
		addi t2 t2 1
		j loop
	endloop:
	li a7 4
	la a0 overflownumber
	ecall
	mv a0 t2
	li a7 1
	ecall
	li a7 11
	li a0 '\n'
	ecall
	li a7 4
	la a0 overflowlastsum
	ecall
	mv a0 t5	# Print last element of sum before overflow
	li a7 1
	ecall
evenoddchecksetup:
	mv a5 zero
	mv a6 zero
	la t0 array
	li t4 10
evenoddcheck:
	lw t2 (t0)
	bgtz t2 digitscheck # Making absolute value
		neg t2 t2
	digitscheck:
	blt t2 t4 digitloop # If number less than 10 it is last digit
	div t3 t2 t4	# Getting last digit from number
	mul t3 t3 t4
	neg t3 t3
	add t2 t2 t3
	digitloop:	# Checking is it odd or even
		blez t2 enddigitloop
		addi t2 t2 -2
		j digitloop
	enddigitloop:
	beqz t2 evenplus # Count odd or even number
		addi a5 a5 1
		j oddplus
	evenplus:
		addi a6 a6 1
	oddplus:
	addi t0 t0 4
	bne t0 t6 evenoddcheck
	
	li a7 11
	li a0 '\n'
	ecall
	li a7 4
	la a0 even
	ecall
	mv a0 a6
	li a7 1
	ecall
	li a7 11
	li a0 '\n'
	ecall
	li a7 4
	la a0 odd
	ecall
	mv a0 a5
	li a7 1
	ecall
	li a7 10
	ecall
