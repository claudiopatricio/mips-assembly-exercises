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

str1:		.asciiz "Nr de parametros: "
str2:		.asciiz	"\nP"
str3:		.asciiz ": "

		.text
		.globl main	

main:		li $t0, 0			# i = 0
		move $t1, $a0			# argc
		move $t2, $a1			# argv
		print_str(str1)			# print_str("Nr de parametros: ")
		print_int($t1)			# print_int(argc)
for_i:		bgeu $t0, $t1, end		# for(i=0; i < argc; i++)
						# {
		print_str(str2)			#	print_str("\nP")
		print_int($t0)			#	print_int(i)
		print_str(str3)			#	print_str(": ")
		sll $t3, $t0, 2			# 	Each entry have 4 bytes
		addu $t3, $t2, $t3		# 	&(argv[i])
		lw $t5, 0($t3)			# 	argv[i]
		print_strvar($t5)		# 	print_str(argv[i])
		addiu $t0, $t0, 1		# 	i = i + 1
		b for_i				# }
end:		li $v0, 0			# return 0
		jr $ra
	