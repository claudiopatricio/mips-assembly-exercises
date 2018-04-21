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
	
str1:		.asciiz "Introduza uma string: "

str:		.space	80

		.text
		.globl main	

main:		print_str(str1)			# print_str("Introduza uma string: ")
		la $t0, str			# str
		read_string($t0, 20)		# read_str(str, 20)
		lb $t1, 0($t0)			# *p
loop:		beqz $t1, end			# while (*p != 0)
						# {
		bltu $t1, 'a', cont		#	if(*p >= 'a'
		bgtu $t1, 'z', cont		#	&& *p <= 'z')
						#	{
		add $t1, $t1, 'A'		# 		*p = *p + 'A'
		sub $t1, $t1, 'a'		# 		*p = *p - 'a'
		sb $t1, 0($t0)			#		*str = *p
						#	}
cont:		addiu $t0, $t0, 1		# 	p = p + 1
		lb $t1, 0($t0)			# 	*p
		j loop				# }
end:		print_str(str)			# print_str(p)
		jr $ra				# return
