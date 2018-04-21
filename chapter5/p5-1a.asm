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

str1:		.asciiz "\nIntroduza um numero: "
		.eqv SIZE 5

lista:		.word 0:SIZE

		.text
		.globl main	

main:		li $t0, 0			# i = 0
		la $t1, lista			# lista
		li $t2, 0			# aux
loop:		bgeu $t0, SIZE, end		# for(i=1; i < SIZE; i++)
						# {
		print_str(str1)			#	print_str("\nIntroduza um numero: ")
		read_int			#	read_int()
		sll $t2, $t0, 2			# 	Each int have 4 bytes
		sw $v0, lista($t2)		# 	lista[i] = read_int()
		addi $t0, $t0, 1		# 	num = num + 1
		b loop				# }
end:		jr $ra				# return
	