.eqv BUF_SIZE 20
.data
	text: .space BUF_SIZE
	text_end: .space 1
	copy: .space BUF_SIZE
	copy_end: .space 1
	short: .asciz "Hello"
	long: .asciz "The quick brown fox jumps over the lazy dog"
.include "macrolib.s"
.globl main
.text 
main:
la a0 text
li a2 BUF_SIZE
read_str(a0, a2)
print_str("Entered: ")
print_str_reg(a0)
la a0 text
strlen(a0, a3)
print_str("Lenght of entered string: ")
print_int(a3)
newline()
la a0 text
la a1 copy
less_or_eq(a3, a2, a2)
strncpy_mac(a1, a0, a2)
la a0 copy
print_str("Copy: ")
print_str_reg(a0)
la a0 copy
li a1 BUF_SIZE
clear(a0, a1)
newline()


print_str("Entered: ")
la a0 short
la a1 copy
li a2 BUF_SIZE
print_str_reg(a0)
newline()
strlen(a0, a3)
print_str("Lenght of entered string: ")
print_int(a3)
less_or_eq(a3, a2, a2)
strncpy_mac(a1, a0, a2)
la a0 copy
newline()
print_str("Copy: ")
print_str_reg(a0)
la a0 copy
li a1 BUF_SIZE
clear(a0, a1)
newline()
newline()

print_str("Entered: ")
la a0 long
la a1 copy
li a2 BUF_SIZE
print_str_reg(a0)
newline()
strlen(a0, a3)
print_str("Lenght of entered string: ")
print_int(a3)
less_or_eq(a2, a3, a2)
strncpy_mac(a1, a0, a2)
la a0 copy
newline()
print_str("Copy: ")
print_str_reg(a0)
la a0 copy
li a1 BUF_SIZE
clear(a0, a1)
exit()