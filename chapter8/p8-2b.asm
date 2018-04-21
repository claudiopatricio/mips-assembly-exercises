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

		.include "../macros.asm"
		.data
str0:		.asciiz "Introduza um numero: "
str1:		.asciiz "\nIntroduza a base: "
		.text
		.globl main	
	
main:		stack_save
		print_str(str0)			# print_str("Introduza um numero: ")
		read_int			# read_int()
		move $s0, $v0			# Number
		print_str(str1)			# print_str("Introduza a base: ")
		read_int			# read_int()
		move $a1, $v0			# Base
		move $a0, $s0
		jal print_int_acli		# print_int_acli(Number, Base)
		li $v0, 0			# return 0
		stack_restore

		

# Includes
.include "../functions.asm"			# All functions
