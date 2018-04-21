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
loop:		bgeu $t1, SIZE, bubble		# while(i < SIZE)
						# {
		print_str(str1)			#	print_str("\nIntroduza um numero: ")
		read_int			#	read_int()
		sw $v0, 0($t0)			#	*p = read_int()
		addi $t0, $t0, 4		# 	p = p + 1
		addi $t1, $t1, 1		# 	i = i + 1
		b loop				# }
	
		# Starting bubble-sort algorythm
bubble:		la $t3, SIZE			# SIZE
		subi $t3, $t3, 1		# pUltimo = SIZE - 1
		sll $t3, $t3, 2			# Each int have 4 bytes
		la $t1, lista			# lista
		add $t3, $t3, $t1		# pUltimo = lista + (SIZE - 1)
do_i:						# do
						# {
		li $t2, 0			# 	houveTroca = FALSE
		la $t1, lista			# 	p = lista
for_do:		bgeu $t1, $t3, do		# 	for(p = lista; p < pUltimo; p++)
						#	{
		lw $t4, 0($t1)			#	 	*p
		lw $t5, 4($t1)			#	 	*(p+1)
		ble $t4, $t5, for_e		#	 	if(*p > *(p+1))
						#		{
		sw $t5, 0($t1)			# 			*p = *(p+1)
		sw $t4, 4($t1)			# 			*(p+1) = aux
		li $t2, 1			# 			houveTroca = TRUE
						# 		}
for_e:		addi $t1, $t1, 4		# 		p = p + 1
		b for_do			# 	}
do:		beq $t2, 1, do_i		# } while(houveTroca==TRUE)

		# Starting print array lista
		li $t1, 0			# i = 0
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
