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

str0:		.asciiz "\nNr de Letras: "
str1:		.asciiz "\nNr de Caracteres: "
str2:		.asciiz	"\nP"
str3:		.asciiz ": "
str4:		.asciiz "\nMaior String: "

		.text
		.globl main	

main:		li $t0, 0			# i = 0
		li $t7, 0			# aux = 0
		move $t1, $a0			# argc
		move $t2, $a1			# argv
for_i:		bgeu $t0, $t1, for_e		# for(i=0; i < argc; i++)
						# {
		print_str(str2)			#	print_str("\nP")
		print_int($t0)			# 	print_int(i)
		print_str(str3)			#	print_str(": ")
		sll $t3, $t0, 2			# 	Each entry have 4 bytes
		addu $t3, $t2, $t3		# 	&(argv[i])
		lw $t5, 0($t3)			# 	argv[i]
		print_strvar($t5)		#	print_str(argv[i])
		li $t3, 0			#	j = 0
		li $t9, 0			# 	m = 0 - Number of letters
		lb $t4, 0($t5)			# 	argv[i][j]
		addiu $t0, $t0, 1		# 	i = i + 1
for_2i:		beqz $t4, for_2e		# 	while(argv[i][j] != 0)
						#	{
		addiu $t3, $t3, 1		# 		j = j + 1
		addu $t6, $t3, $t5		# 		&(lista[i][j])
		bltu $t4, 0x41, for_2a		# 		if(lista[i][j] >= 'A'
		bgtu $t4, 0x5A, for_2a		# 		&& lista[i][j] <= 'Z')
		addiu $t9, $t9, 1		# 			m = m + 1
for_2a:		bltu $t4, 0x61, for_2b		# 		if(lista[i][j] >= 'a'
		bgtu $t4, 0x7A, for_2b		# 		&& lista[i][j] <= 'z')
		addiu $t9, $t9, 1		# 			m = m + 1
for_2b:		lb $t4, 0($t6)			# 		lista[i][j]
		b for_2i			#	}
for_2e:		print_str(str1)			#	print_str("\nNr de Caracteres: ")
		print_int($t3)			# 	print_int(j)
		print_str(str0)			#	print_str("\nNr de Letras: ")
		print_int($t9)			# 	print_int(m)
		print_nl			#	print_str("\n")
		bltu $t3, $t7, for_i		# 	if(j < aux)
						#	{
		move $t7, $t3			# 		aux = j
		move $t8, $t5			# 		aux2 = &(lista[i])
		b for_i				#	}
						# }
for_e:		print_str(str4)			# print_str("\nMaior String: ")
		print_strvar($t8)		# print_str(argv[i])
end:		li $v0, 0			# return 0
		jr $ra
		