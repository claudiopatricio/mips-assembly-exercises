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
str1:		.asciiz "String #"
str2:		.asciiz ": "

		.align 2
array1:		.asciiz "Array"
array2:		.asciiz "de"
array3:		.asciiz "ponteiros"

lista:		.word array1, array2, array3

		.text
		.globl main	

main:		la $t0, lista			# p = lista
		li $t1, SIZE
		li $t2, 0			# i = 0
		sll $t1, $t1, 2			# Each entry have 4 bytes
		addu $t1, $t1, $t0		# pUltimo = p + SIZE
for_i:		bgeu $t0, $t1, end		# while(p < pUltimo)
						# {
		print_str(str1)			#	print_str("String #")
		print_int($t2)			#	print_int(i)
		print_str(str2)			#	print_str(": ")
		lw $t4, 0($t0)			# 	*p
		lb $t5, 0($t4)			#	**p
for_2i: 	beqz $t5, for_2e		#	while(**p != 0)
						#	{
		print_charvar($t5)		#		print_char(**p)
		print_char('-')			#		print_char('-')
		addiu $t4, $t4, 1		# 		*p = *p + 1
		lb $t5, 0($t4)			#		**p
		b for_2i			#	}
for_2e:		addiu $t0, $t0, 4		#	p = p + 1
		addiu $t2, $t2, 1		#	i = i + 1
		print_nl			#	print_str("\n")
		b for_i				# }
end:		jr $ra				# return
