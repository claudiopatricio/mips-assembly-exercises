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

a_ints:		.word 7692, 23, 5, 234

		.text
		.globl main	

main:		li $t3, 0			# soma = 0
		la $t0, a_ints			# p = array
		addi $t1, $t0, 12		# pultimo = array + 3
loop:		bgt $t0, $t1, exit		# while(p <= pUltimo)
						# {
		lw $t2, 0($t0)			# 	*p
		add $t3, $t3, $t2		# 	soma = soma + *p
		addi $t0, $t0, 4		# 	p = p + 1
		b loop				# }
exit:		print_int($t3)			# print_int(soma)
		jr $ra				# return
