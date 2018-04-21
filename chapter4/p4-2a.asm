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

main:		print_str(str1)			# print_string("Escreva uma string: ")
		la $t1, str			# str
		read_string($t1, 20)		# read_str(str, 20)
		li $t0, 0			# num = 0
		lb $t2, 0($t1)			# *str
loop:		beqz $t2, end			# while(*str != 0)
						# {
		bltu $t2, '0', loop_e		#	if *str >= '0'
		bgtu $t2, '9', loop_e		#	&& *str <= '9')
		addiu $t0, $t0, 1		# 		num = num + 1
loop_e:		addiu $t1, $t1, 1		# 	str+1
		lb $t2, 0($t1)			# 	*str
		b loop				# }
end:		print_int($t0)			# print_int(num)
		jr $ra				# return
