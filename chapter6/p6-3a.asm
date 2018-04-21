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

		.include "macros.asm"
		.data

		.eqv SIZE 3
str1:		.asciiz "\nString #"
str2:		.asciiz ": "
	
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
		sll $t1, $t0, 2			# 	Each entry have 4 bytes
		lw $t2, lista($t1)		# 	lista[i]
		print_str(str1)			#	print_str("\nString #")
		print_int($t0)			#	print_int(i)
		print_str(str2)			#	print_str(": ")
		li $t3, 0			# 	j = 0
		lb $t4, 0($t2)			#	lista[i][j]
		addiu $t0, $t0, 1		# 	i = i + 1
for_2i:		beqz $t4, for_i			# 	while(argv[i][j] != 0)
						#	{
		print_charvar($t4)		#		print_char(lista[i][j]
		print_char('-')
		addiu $t3, $t3, 1		# 		j = j + 1
		addu $t5, $t3, $t2		# 		&(lista[i][j])
		lb $t4, 0($t5)			# 		lista[i][j]
		b for_2i			#	}
end:		jr $ra				# }
