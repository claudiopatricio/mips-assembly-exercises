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
str_logic1:	.asciiz "Para valor $t0: "
str_logic2:	.asciiz "Imm: "
str1:		.asciiz "SLL: "
str2:		.asciiz "SRL: "
str3:		.asciiz "SRA: "
str_and:	.asciiz " e "
str_eq:		.asciiz ": "
str_nl:		.asciiz "\n"		
		
		.text
		.globl	main

main:		li $t0, 0x12345678
		li $t1, 1
		jal calculate
		
		li $t0, 0x12345678
		li $t1, 4
		jal calculate
		
		li $t0, 0x12345678
		li $t1, 16
		jal calculate
		
		li $t0, 0x862A5C1B
		li $t1, 2
		jal calculate
		
		li $t0, 0x862A5C1B
		li $t1, 4
		jal calculate
		
		li $t0, 0x12345678
		jal calculate_uniq
		
		li $v0, 10
		syscall
		
		
calculate:	move $t7, $ra		# Protecção da variável de retorno

		la $a0, str_logic1
		li $v0, 4
		syscall
		move $a0, $t0
		li $v0, 34
		syscall
		jal print_and
		la $a0, str_logic2
		li $v0, 4
		syscall
		move $a0, $t1
		li $v0, 1
		syscall
		jal print_nl

		sllv $t2, $t0, $t1
		la $a0, str1
		li $v0, 4
		syscall
		move $a0, $t2
		li $v0, 34
		syscall
		jal print_nl
		
		srlv $t2, $t0, $t1
		la $a0, str2
		li $v0, 4
		syscall
		move  $a0, $t2
		li $v0, 34
		syscall
		jal print_nl
		
		srav $t2, $t0, $t1
		la $a0, str3
		li $v0, 4
		syscall
		move  $a0, $t2
		li $v0, 34
		syscall
		jal print_nl

		jr $t7
		
		
calculate_uniq:	move $t7, $ra		# Protecção da variável de retorno

		la $a0, str_logic1
		li $v0, 4
		syscall
		move $a0, $t0
		li $v0, 34
		syscall
		jal print_nl

		srl $t2, $t0, 28
		move $a0, $t2
		li $v0, 34
		syscall
		jal print_nl

		andi $t1, $t0, 0x0F000000		
		srl $t2, $t1, 24
		move $a0, $t2
		li $v0, 34
		syscall
		jal print_nl
		
		andi $t1, $t0, 0x00F00000		
		srl $t2, $t1, 20
		move $a0, $t2
		li $v0, 34
		syscall
		jal print_nl
		
		andi $t1, $t0, 0x000F0000		
		srl $t2, $t1, 16
		move $a0, $t2
		li $v0, 34
		syscall
		jal print_nl
		
		andi $t1, $t0, 0x0000F000		
		srl $t2, $t1, 12
		move $a0, $t2
		li $v0, 34
		syscall
		jal print_nl
		
		andi $t1, $t0, 0x00000F00		
		srl $t2, $t1, 8
		move $a0, $t2
		li $v0, 34
		syscall
		jal print_nl
		
		andi $t1, $t0, 0x000000F0		
		srl $t2, $t1, 4
		move $a0, $t2
		li $v0, 34
		syscall
		jal print_nl
		
		andi $t2, $t0, 0x0000000F
		move $a0, $t2
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
