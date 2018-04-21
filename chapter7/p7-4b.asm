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

		.eqv SIZE, 50
	
str1:		.asciiz "Arquitectura de "
	
str2:		.space SIZE

str3:		.asciiz "Computadores"

		.text
		.globl main	
	
main:		stack_save
		la $a1, str1
		la $a0, str2
		jal strcpy			# strcpy(str1, str2)
		la $a0, str2
		la $a1, str3
		jal strcat			# strcat(str2, str3)
		move $s2, $v0			# aux = strcat(str2, str3)
		print_strvar($s2)		# print_str(aux)
exit:		li $v0, 0			# return 0
		stack_restore
	
	
# Includes
.include "../functions.asm"			# All functions