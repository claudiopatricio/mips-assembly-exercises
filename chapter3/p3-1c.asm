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

str1:		.asciiz "Introduza um numero: "
str2:		.asciiz "O valor em binario: "
char0:		.ascii "0"
char1:		.ascii "1"


		.text
		.globl main

main:		print_str(str1)			# print_str("Introduza um numero: ")
		read_int			# read_int()
		move $t0, $v0			# val1
		print_str(str2)			# print_str("O valor em binario: ")
		li $t2, 0			# i = 0
		li $t3, 0x80000000
		li $t4, 0xFFFFFFFC
while:		bnez $t1, loop			# while(bit == 0 && i < 31)
		bgeu $t2, 31, loop		# {			
		addiu $t2, $t2, 1		# 	i = i + 1
		sll $t0, $t0, 1			#	val1 = val1 << 1
		and $t1, $t0, $t3		#	bit = val1 & 0x80000000
		j while				# }
loop:		bgeu $t2, 32, quit		# while(i < 32)
						# {
		and $t1, $t0, $t3		#	bit = val1 & 0x80000000
		bnez $t1, else			#	if(bit == 0)
		print_char('0')			#		print_char('0')
		j if_end			#	else
else:		print_char('1')			#		print_char('1')
if_end:		sll $t0, $t0, 1			#	val1 = val1 << 1
		addiu $t2, $t2, 1		#	i = i + 1
		nor $t5, $t2, $t4		#	aux = ~(i | 0xFFFFFFFC) - Last 2 bits
		blt $t5, 3, loop		#	if(aux >= 3)
		print_char(' ')			#		print_char(' ')
		j loop				# }
quit:		jr $ra				# return
