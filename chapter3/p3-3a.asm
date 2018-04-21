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

str1:		.asciiz "Introduza dois numeros: "
str2:		.asciiz "Resultado: "

		.text
		.globl main	

main:		print_str(str1)			# print_str(Introduza dois numeros: ")
		read_int			# read_int()
		la $t0, ($v0)			# mdor = read_int()
		read_int			# read_int()
		la $t1, ($v0)			# mdo = read_int()
		li $t2, 0			# i = 0
		li $t3, 0x00000001
		li $t5, 0			# res = 0
while:		bgeu $t2, 4, end		# while(i < 4 && mdor != 0)
		beqz $t0, end			# {
		addiu $t2, $t2, 1		#	i = i + 1
		and $t6, $t0, $t3		# 	aux = mdor & 0x00000001
		beqz $t6, if_end		# 	if(aux != 0)
		addu $t5, $t5, $t1		# 		res = res + mdo
if_end:		sll $t1, $t1, 1			# 	mdo = mdo << 1
		srl $t0, $t0, 1			# 	mdor = mdor >> 1
		j while				# }
end:		print_str(str2)			# print_str("Resultado: ")
		print_int($t5)			# print_int(res)
		jr $ra				# return
