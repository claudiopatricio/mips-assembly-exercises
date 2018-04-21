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
		.align 2
lista:		.space SIZE

		.text
		.globl main	

main:		li $t1, 0			# i = 0
		la $t0, lista			# p = array
loop:		bgeu $t1, SIZE, seq		# while(i < SIZE)
						# {
		print_str(str1)			#	print_str("\nIntroduza um numero: ")
		read_int			#	read_int()
		sw $v0, 0($t0)			#	*p = read_int()
		addi $t0, $t0, 4		# 	p = p + 1
		addi $t1, $t1, 1		# 	i = i + 1
		b loop				# }

		# Starting sequential-sort algorythm
seq:		la $t3, SIZE			# SIZE
		subiu $t3, $t3, 1		# SIZE - 1
		li $t1, 0			# i = 0
for_1:		bgeu $t1, $t3, print		# for(i = 0; i < SIZE - 1; i++)
						# {
for_2i:		add $t2, $t1, 1			# 	j = i + 1
for_2:		bgeu $t2, SIZE, for_1e		# 	for(j = i + 1; j < SIZE; j++)
						#	{
		sll $t6, $t1, 2			# 		i * 4 (Word is 4 bytes)
		lw $t4, lista($t6)		# 		aux = lista[i]
		sll $t7, $t2, 2			# 		j * 4 (Word is 4 bytes)
		lw $t5, lista($t7)		# 		aux2 = lista[j]
		ble $t4, $t5, for_2e		# 		if(lista[i] > lista[j])
						#		{
		sw $t5, lista($t6)		# 			lista[i] = lista[j]
		sw $t4, lista($t7)		# 			lista[j] = aux
						#		}
for_2e: 	addi $t2, $t2, 1		# 		j = j + 1
		b for_2				#	}
for_1e: 	addi $t1, $t1, 1		# 	i = i + 1
		b for_1				# }

		# Starting print array lista
print:		li $t1, 0			# i = 0
		print_str(str1)			# print_str("\nIntroduza um numero: ")
loop2:		bgeu $t1, SIZE, end		# while(i < SIZE)
						# {
		sll $t2, $t1, 2			#	Each entry have 4 bytes
		lw $t2, lista($t2)		# 	lista[i]
		print_int($t2)			#	print_int(lista[i])
		print_char('-')			#	print_char('-')
		addi $t1, $t1, 1		# 	i = i + 1
		b loop2				# }
end:		jr $ra				# return
