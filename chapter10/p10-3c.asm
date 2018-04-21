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
		.eqv SIZE 11
str0:		.asciiz "Função média\n\n"
str1:		.asciiz "Introduza um numero: "
str2:		.asciiz "Resultado: "

array:		.double 0:SIZE

		.text
		.globl main	
	
main:		stack_save			
		print_str(str0)			# print_str("Função média\n\n")
		la $t0, array			# array
		li $t1, 0			# i = 0
main_d0i:					# do
						# {
		print_str(str1)			# 	print_str("Introduza um numero: ")
		read_int			# 	read_int()
		mtc1 $v0, $f0
		cvt.d.w $f0, $f0		#	(double)read_int()
		sdc1 $f0, 0($t0)		#	array[i] = (double)read_int()
		addiu $t0, $t0, 8		#	array++
		addiu $t1, $t1, 1		#	i = i + 1
		blt $t1, SIZE, main_d0i		# } while(i < SIZE)
		la $a0, array
		li $a1, SIZE
		jal average			# average(array, SIZE)
		print_str(str2)			# print_str("Resultado: ")
		mov.d $f12, $f0
		print_double			# print_double(average(array, SIZE))
		li $v0, 0			# return 0
		stack_restore
		
	
	
# Includes
.include "../functions.asm"			# All functions
