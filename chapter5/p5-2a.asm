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

str1:		.asciiz "\nConteudo do array:\n"
lista:		.word 8, -4, 3, 5, 124, -15, 87, 9, 27, 15
		.eqv SIZE 10

		.text
		.globl main	

main:		la $t0, lista			# p = lista
		li $t1, 0			# i = 0
		print_str(str1)			# print_str("\nConteudo do array:\n")
loop:		bgeu $t1, SIZE, exit		# for(i=0; i < SIZE, i++)
						# {
		lw $t2, 0($t0)			# 	*p
		print_int($t2)			#	print_int(*p)
		print_char('-')			#	print_char('-')
		addi $t0, $t0, 4		# 	p = p + 1
		addi $t1, $t1, 1		# 	i = i + 1
		b loop				# }
exit:		jr $ra				# return
