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

str1:		.asciiz "Escreva uma string: "

str:		.space	80

		.text
		.globl main	

main:		print_str(str1)
		la $t2, str			# Address of str
		read_string($t2, 20)		# read_str(buf, 20)
		li $t0, 0			# num = 0
		li $t1, 0			# i = 0
		addiu $t3, $t2, $t1		# Address of str[i]
		lb $t4, 0($t3)			# str[i]
loop:		beqz $t4, end			# while(str[i] != 0)
						# {
		bltu $t4, '0', cont		#	if(str[i] >= '0'
		bgtu $t4, '9', cont		#	&& str[i] <= '9')
						#	{ 
		addiu $t0, $t0, 1		# 		num = num + 1
cont:		addiu $t1, $t1, 1		# 		i = i + 1
						#	}
		addiu $t3, $t2, $t1		# 	Address of str[i]
		lb $t4, 0($t3)			# 	str[i]
		b loop				# }
end:		print_int($t0)			# print_int10(num)
		jr $ra				# return
