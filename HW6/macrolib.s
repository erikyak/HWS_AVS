.macro strncpy_mac(%dst %src %len)
	mv t0 %dst
	mv t1 %src
	mv t2 %len
	push(a0)
	push(a1)
	push(a2)
	mv a0 t0
	mv a1 t1
	mv a2 t2
	jal strncpy
	pop(a2)
	pop(a1)
	pop(a0)
.end_macro 

# Печать содержимого регистра как целого
.macro print_int (%x)
	push (a0)
	li a7, 1
	mv a0, %x
	ecall
	pop(a0)
.end_macro

.macro strlen(%x %save_reg)
	mv t0 %x
	li t1 0
	loop:
		lb t2 (t0)
		beqz t2 end
		plus1(t1)
		plus1(t0)
		j loop
	end:
	mv %save_reg t1
.end_macro 

.macro plus1(%n)
	addi %n %n 1
.end_macro 


# Ввод целого числа с консоли в регистр a0
.macro read_int_a0
	li a7, 5
	ecall
.end_macro

# Ввод целого числа с консоли в указанный регистр,
# исключая регистр a0
.macro read_int(%x)
   push	(a0)
	li a7, 5
	ecall
	mv %x, a0
	pop (a0)
.end_macro

.macro read_str(%x %buf)
	mv t0 %x
	mv t1 %buf
	mv a0 t0
	mv a1 t1
	li a7 8
	ecall
.end_macro

.macro print_str_reg(%x)
	push(a0)
	push(a1)
	mv a0 %x
	loop:
		lb a1 (a0)
		beqz a1 end
		print_char_reg(a1)
		plus1(a0)
		j loop
	end:
	pop(a1)
	pop(a0)
.end_macro 

.macro print_str (%x)
.data
str:	.asciz %x
.text
	push (a0)
	li a7, 4
	la a0, str
	ecall
	pop (a0)
.end_macro

.macro print_char(%x)
	push(a0)
	li a7, 11
	li a0, %x
	ecall
	pop(a0)
.end_macro

.macro print_char_reg(%x)
	push(a0)
	li a7, 11
	mv a0, %x
	ecall
	pop(a0)
.end_macro

.macro newline
	print_char('\n')
.end_macro

# Завершение программы
.macro exit
    li a7, 10
    ecall
.end_macro

# Сохранение заданного регистра на стеке
.macro push(%x)
	addi	sp, sp, -4
	sw	%x, (sp)
.end_macro

# Выталкивание значения с вершины стека в регистр
.macro pop(%x)
	lw	%x, (sp)
	addi	sp, sp, 4
.end_macro

.macro clear(%x %n)
	mv t0 %x
	mv t1 %n
	li t2 ' '
	loop:
		blez t1 end
		sb t2 (t0)
		addi t1 t1 -1
		plus1(t0)
		j loop
	end:
.end_macro 

.macro greater(%first %second %save_reg)
	bgt %first %second greater
	mv %save_reg %second
	j end
	greater:
	mv %save_reg %first
	end:
.end_macro 

.macro greater_or_eq(%first %second %save_reg)
	bge %first %second greater
	mv %save_reg %second
	j end
	greater:
	mv %save_reg %first
	end:
.end_macro 

.macro less(%first %second %save_reg)
	blt %first %second less
	mv %save_reg %second
	j end
	less:
	mv %save_reg %first
	end:
.end_macro 

.macro less_or_eq(%first %second %save_reg)
	ble %first %second less
	mv %save_reg %second
	j end
	less:
	mv %save_reg %first
	end:
.end_macro 