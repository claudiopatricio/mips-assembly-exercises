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

.macro print_str(%str_input)		# Prints the var received in input as a string
	la $a0, %str_input
	li $v0, 4
	syscall
.end_macro

.macro print_strvar(%str_input)		# Prints the var received in input as a string
	move $a0, %str_input
	li $v0, 4
	syscall
.end_macro

.macro print_char(%char_input)		# Prints the var received in input as a char
	la $a0, %char_input
	li $v0, 11
	syscall
.end_macro

.macro print_charvar(%char_input)	# Prints the var received in input as a char
	move $a0, %char_input
	li $v0, 11
	syscall
.end_macro

.macro print_nl				# Prints a new line
	.data
nl:	.asciiz "\n"
	.text
	la $a0, nl
	li $v0, 4
	syscall
.end_macro

.macro print_int(%int_input)		# Prints the var received in input as an integer
	add $a0, $zero, %int_input
	li $v0, 1
	syscall
.end_macro

.macro print_intu(%int_input)		# Prints the var received in input as an integer
	add $a0, $zero, %int_input
	li $v0, 36
	syscall
.end_macro

.macro print_hex(%hex_input)		# Prints the var received in input as an hexadecimal
	move $a0, %hex_input
	li $v0, 34
	syscall
.end_macro

.macro print_float			# Print float
	li $v0, 2
	syscall
.end_macro

.macro print_double			# Print double
	li $v0, 3
	syscall
.end_macro

.macro read_int				# Reads a int from keyboard and save in $a0
	li $v0, 5
	syscall
.end_macro

.macro read_int(%int_input)
	li $v0, 5
	syscall
	add %int_input, $v0, 0
.end_macro

.macro read_float
	li $v0, 6
	syscall
.end_macro

.macro read_double
	li $v0, 7
	syscall
.end_macro

.macro read_string(%buffer, %limit)	# Reads a string from keyboard and save in $a0
	move $a0, %buffer
	la $a1, %limit
	li $v0, 8
	syscall
.end_macro

.macro read_str(%buffer, %limit)	# Reads a string and removes \n
	move $a0, %buffer
	move $a2, %buffer
	la $a1, %limit
	li $v0, 8
	syscall
	jal strlen
	beq $v0, %limit, read_str_end
	addu $a2, $a2, $v0
	addiu $a2, $a2, -1
	sb $0, 0($a2)
read_str_end:
.end_macro	

.macro stack_save			# Save in stack variables $s[x]
	addiu $sp, $sp, -36
	sw $s7, 32($sp)
	sw $s6, 28($sp)
	sw $s5, 24($sp)
	sw $s4, 20($sp)
	sw $s3, 16($sp)
	sw $s2, 12($sp)
	sw $s1, 8($sp)
	sw $s0, 4($sp)
	sw $ra, 0($sp)
.end_macro

.macro stack_restore
	lw $s7, 32($sp)
	lw $s6, 28($sp)
	lw $s5, 24($sp)
	lw $s4, 20($sp)
	lw $s3, 16($sp)
	lw $s2, 12($sp)
	lw $s1, 8($sp)
	lw $s0, 4($sp)
	lw $ra, 0($sp)
	addiu $sp, $sp, 36
	jr $ra
.end_macro
	
.macro quit				# Exit the program
	li $v0, 10
	syscall
.end_macro

.macro quit_int(%int_input)
	add $a0, $0, %int_input
	li $v0, 17
	syscall
.end_macro
