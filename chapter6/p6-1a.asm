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

		.eqv SIZE 3
	
		.align 2
array1:		.asciiz "Array"
array2:		.asciiz "de"
array3:		.asciiz "ponteiros"

lista:		.word array1, array2, array3

		.text
		.globl main	
	
main:		li $t0, 0			# $t0: i = 0
for_i:		bgeu $t0, SIZE, end		# for(i=0; i < SIZE; i++)
						# {
		sll $t1, $t0, 2			#	Each entry have 4 bytes
		lw $t2, lista($t1)		#	lista[i]
		print_strvar($t2)		#	print_str(lista[i]
		print_char('\n')		#	print_str("\n")
		addiu $t0, $t0, 1		#	i = i + 1
		b for_i				# }
end:		jr $ra
