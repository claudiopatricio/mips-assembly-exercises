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

main:		li $t0, 0x12345678
		li $t1, 0x0000000F
		jal calculate
		
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
		
		li $v0, 10
		syscall
		
		
calculate:	la $t7, ($ra)		# Protecção da variável de retorno
		la $a0, str_logic1
		li $v0, 4
		syscall
		la $a0, ($t0)
		li $v0, 34
		syscall
		jal print_and
		la $a0, str_logic2
		li $v0, 4
		syscall
		la $a0, ($t1)
		li $v0, 34
		syscall
		jal print_nl

		and $t2, $t0, $t1
		la $a0, str1
		li $v0, 4
		syscall
		la $a0, ($t2)
		li $v0, 34
		syscall
		jal print_nl
		
		or $t2, $t0, $t1
		la $a0, str2
		li $v0, 4
		syscall
		la  $a0, ($t2)
		li $v0, 34
		syscall
		jal print_nl
		
		nor $t2, $t0, $t1
		la $a0, str3
		li $v0, 4
		syscall
		la  $a0, ($t2)
		li $v0, 34
		syscall
		jal print_nl
		
		xor $t2, $t0, $t1
		la $a0, str4
		li $v0, 4
		syscall
		la  $a0, ($t2)
		li $v0, 34
		syscall
		jal print_nl

		jr $t7
		
		
calc_negbit:	la $t7, ($ra)		# Protecção da variável de retorno

		la $a0, str_negbit
		li $v0, 4
		syscall
		la $a0, ($t0)
		li $v0, 34
		syscall
		la $a0, str_eq
		li $v0, 4
		syscall
		li $t3, 0xFFFFFFFF
		xor $a0, $t3, $t0	# Negação bit a bit
		li $v0, 34
		syscall
		jal print_nl
		
		jr $t7
		
		
print_nl:	la $a0, str_nl
		li $v0, 4
		syscall
		
		jr $ra
		
print_and:	la $a0, str_and
		li $v0, 4
		syscall
		
		jr $ra
