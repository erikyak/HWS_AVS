.data
num1: 4 5 -2 -9 9 -9 0 10									# Массив числителей для тестов
den1: 2 3 5 4 -4 -4 2 0										# Массив знаменателей для тестов
correct: .asciz  "2 0" "1 2" "0 -2" "-2 -1" "-2 1" "2 -1" "0 0" "You can not divide by zero!!!"	# Массив правильных ответов для тестов
denomiszero: .asciz "На ноль делить нельзя!!!"
printnum1: .asciz "Числитель: "
printden1: .asciz "    Знаменатель: "
num0: .asciz "Введите числитель: "
den0: .asciz "Введите знаменатель: "
res: .asciz "Частное: "
remain: .asciz "Остаток от деления: "
option: .asciz "Если вы хотите ввести числа с клавиатуры, введите 0\nЕсли хотите прогнать тесты, введите 1: "
correctansw: .asciz "Правильный ответ(первый частное, второй остаток): "
.text
mv t6 zero
mv t5 zero
li a4 8
choice:			# Выбор между ручного ввода и тестами
	li a7 4
	la a0 option
	ecall
	li a7 5
	ecall
	mv a1 a0
	beqz a1 preloop0# При 0 перейдет к вводу с рук, при 1 будут проведены тесты
strartpreloop1:		# Установление адресов при тестах
	la a2 num1
	la a3 den1
	la a5 correct
preloop1:		# Циклический вывод числителя и знаменателя и сдвиг a2 и a3
	beqz a4 testingend
	lw t0 (a2)
	lw t1 (a3)
	li a7 4
	la a0 printnum1
	ecall
	li a7 1
	lw a0 (a2)
	ecall
	li a7 4
	la a0 printden1
	ecall
	li a7 1
	lw a0 (a3)
	ecall
	li a7 11
	li a0 '\n'
	ecall
	addi a2 a2 4
	addi a3 a3 4
	addi a4 a4 -1
	j endpreloop0
preloop0:		# Считывание с клавиатуры числителя и знаменателя
	li a7 4
	la a0 num0
	ecall
	li a7 5
	ecall
	mv t0 a0
	li a7 4
	la a0 den0
	ecall
	li a7 5
	ecall
	mv t1 a0
endpreloop0:		# Оба считывание с клавиатуры и тесты переходят сюда и начинается основной код
	beqz t1 divbyzero# Если деление на 0, то ничего не вычисляем, а переходим к метке divbyzero
	bltz t0 numerneg# Делаем модуль числителя, но также не забываем об этом
numnegend:
	bltz t1 denomneg# Делаем модуль знаменателся, но также не забываем об этом
dennegend:
	neg t4 t1	# t4 - число которое мы будем складывать с t0, то есть вычитаем t1 из t0
	mv t2 zero	# Частное

loop:			# Цикл, где мы вычитаем t1 из t0, пока t1 не станет больше t0, и после цикла частное - t2, остаток - t0
	bgt t1 t0 end
	add t0 t0 t4
	addi t2 t2 1
	j loop
end:			# Вывод частного и знаменателя после цикла
	li a7 4
	la a0 res
	ecall
	li a7 1
	bltz t5 quotientneg# Если числитель был отрицательным, то делаем и числитель и знаменатель отрицательными
quotientnegend:
	bltz t6 remainderneg# Если знаменатель был отрицательным, то делаем числитель отрицательным
remaindernegend:
	mv a0 t2
	ecall
	li a7 11
	li a0 '\n'
	ecall
	li a7 4
	la a0 remain
	ecall
	li a7 1
	mv a0 t0
	ecall
	mv t5 zero
	mv t6 zero
	li a7 11
	li a0 '\n'
	ecall
	bnez a1 correctanswer# Если были выбраны тесты, то переходим к выводу правильных значений
testingend:
	li a7 10
	ecall
divbyzero:		# Как раз метка после деления на ноль
	li a7 4
	la a0 denomiszero
	ecall
	li a7 11
	li a0 '\n'
	ecall
	bnez a1 correctanswer
	li a7 10
	ecall
numerneg:		# Модуль числителя
	neg t0 t0
	li t5 -1
	j numnegend
denomneg:		# Модуль знаменателя
	neg t1 t1
	li t6 -1
	j dennegend
quotientneg:		# Делаем и числитель и знаменатель отрицательными
	neg t2 t2
	neg t0 t0
	j quotientnegend
remainderneg:		# Делаем числитель отрицательным
	neg t2 t2
	j remaindernegend
correctanswer:		# Выводим правильные ответы
	li a7 4
	la a0 correctansw
	ecall
	print_string:	# Вывод посимвольно, так как у нас это строка
    	lb a0, 0(a5)
    	beqz a0, end_print
    	li a7, 11
    	ecall
    	addi a5, a5, 1
    	j print_string
	end_print:
	addi a5, a5, 1
	li a7 11
	li a0 '\n'
	ecall
	j preloop1	# Переход к началу тестирование, но сдвиг есть))