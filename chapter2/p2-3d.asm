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
str1:		.asciiz	"Introduza 2 numeros\n"
str2:		.asciiz "A soma dos 2 numeros e': "

		.text
		.globl main

main:		print_str(str1)			# print_str("Introduza 2 numeros\n")
		read_int			# read_int()
		move $t0, $v0			# val1 = read_int()
		read_int			# read_int()
		move $t1, $v0			# val2 = read_int()
		add $t2, $t0, $t1		# result = val1 + val2
		print_str(str2)			# print_str("A soma dos 2 numeros e': ")
		print_int($t2)			# print_int(result)
		jr $ra				# return
