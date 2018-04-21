# Copyright (c) 2018 Cláudio Patrício
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

		.data
str_logic1:	.asciiz "Para valores $t0: "
str_logic2:	.asciiz "$t1: "
str1:		.asciiz "AND: "
str2:		.asciiz "OR: "
str3:		.asciiz "NOR: "
str4:		.asciiz "XOR: "
str_negbit:	.asciiz "Negação bit a bit de "
str_and:	.asciiz " e "
str_eq:		.asciiz ": "
str_nl:		.asciiz "\n"		
		
		.text
		.globl	main

main:		move $t6, $ra			# save $ra
		li $t0, 0x12345678
		li $t1, 0x0000000F
		jal calculate			# calculate
		
		li $t0, 0x12345678
		li $t1, 0x000FF000
		jal calculate
		
		li $t0, 0x762A5C1B
		li $t1, 0x89D5A3E4
		jal calculate
		
		li $t0, 0x0000FF1E
		jal calc_negbit
		
		li $t0, 0xF5A30614
		jal calc_negbit
		
		li $t0, 0x1ABCE543
		jal calc_negbit
		
		jr $t6
			
			
calculate:	move $t7, $ra			# Protecção da variável de retorno

		la $a0, str_logic1
		li $v0, 4
		syscall				# print_str("Para valores $t0: ")
		
		move $a0, $t0
		li $v0, 34
		syscall				# print_hex(val1)
		
		jal print_and			# print_str(" e ")
		
		la $a0, str_logic2
		li $v0, 4
		syscall				# print_str("$t1: ")
		
		move $a0, $t1
		li $v0, 34
		syscall				# print_hex(val2)
		
		jal print_nl			# print_str("\n")

		and $t2, $t0, $t1		# result = val1 & val2
		la $a0, str1
		li $v0, 4
		syscall				# print_str("AND: ")
		move $a0, $t2
		li $v0, 34
		syscall				# print_hex(result)
		jal print_nl
		
		or $t2, $t0, $t1		# result = val1 | val2
		la $a0, str2
		li $v0, 4
		syscall				# print_str("OR: ")
		move  $a0, $t2
		li $v0, 34
		syscall				# print_hex(result)
		jal print_nl			# print_str("\n")
		
		nor $t2, $t0, $t1		# result = ~(val1 | val2)
		la $a0, str3
		li $v0, 4
		syscall				# print_str("NOR: ")
		move $a0, $t2
		li $v0, 34
		syscall				# print_hex(result)
		jal print_nl			# print_str("\n")
		
		xor $t2, $t0, $t1		# result = val1 ^ val2
		la $a0, str4
		li $v0, 4
		syscall				# print_str("XOR: ")
		move  $a0, $t2
		li $v0, 34
		syscall				# print_hex(result)
		jal print_nl			# print_str("\n")

		jr $t7				# return
		
		
calc_negbit:	move $t7, $ra			# Protecção da variável de retorno

		la $a0, str_negbit
		li $v0, 4
		syscall				# print_str("Negação bit a bit de ")
		move $a0, $t0
		li $v0, 34
		syscall				# print_hex(val)
		la $a0, str_eq
		li $v0, 4
		syscall				# print_str(": ")
		#li $t3, 0xFFFFFFFF		# Negação bit a bit
		#xor $a0, $t3, $t0		# result = val ^ 0xFFFFFFFF
		not $a0, $t0			# result = ~ val
		li $v0, 34
		syscall
		jal print_nl			# print_str("\n")
		
		jr $t7				# return
		
		
print_nl:	la $a0, str_nl
		li $v0, 4
		syscall				# print_str("\n")
		
		jr $ra
		
print_and:	la $a0, str_and
		li $v0, 4
		syscall				# print_str(" e ")
		jr $ra
