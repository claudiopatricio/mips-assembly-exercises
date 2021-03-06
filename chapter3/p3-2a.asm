# Copyright (c) 2018 Cl�udio Patr�cio
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

str1:		.asciiz "Introduza um numero: "
str2:		.asciiz "O valor em hexadecimal: 0x"

		.text
		.globl main	

main:		print_str(str1)			# print_str("Introduza um numero: ")
		read_int			# read_int()
		move $t0, $v0			# val1 = read_int()
		print_str(str2)			# print_str("O valor em hexadecimal: 0x")
		li $t1, 8			# i = 8
		li $t2, 0xF0000000		# Start with 1's and others are 0
		li $t6, 0x30			# char '0'
while:		beqz $t1, cont			# while(i > 0)
						# {
		and $t3, $t0, $t2		# 	aux = value & 0xF0000000
		bnez $t3, loop			# 	if(aux == 0)
						# 		break;
		sll $t0, $t0, 4			# 	val1 = val1 << 4
		addiu $t1, $t1, -1		# 	i = i - 1
		j while				# }
loop:		beqz $t1, end			# while(i > 0)
						# {
		and $t3, $t0, $t2		# 	digito = value & 0xF0000000
		sll $t0, $t0, 4			# 	value = value << 4
		srl $t3, $t3, 28		# 	digito = digito >> 28
		addiu $t1, $t1, -1		#	i = i - 1
		addu $t4, $t3, $t6		# 	aux = '0' + digito
		bleu $t3, 9, cont		#	if(digito >= 9
		addu $t4, $t4, 7		#		aux += 7
cont:		print_charvar($t4)		# 	print_char(aux)
		j loop				# }
end:		jr $ra				# return 
