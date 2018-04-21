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

		.text
		.globl main	
	
main:		stack_save
		li $s0, 0			# i = 0
		move $s1, $a0			# argc
		move $s2, $a1			# argv
for_i:		bgeu $s0, $s1, end		# for(i=0; i < argc; i++)
						# {
		sll $t0, $s0, 2			# 	Each entry have 4 bytes
		addu $t0, $s2, $t0		# 	&(argv[i])
		lw $t1, 0($t0)			# 	argv[i]
		print_char('\n')		#	print_str("\n")
		print_strvar($t1)		# 	print_str(argv[i])
		print_char(' ')			#	print_char('')
		print_char('-')			#	print_char('-')
		print_char(' ')			#	print_char('')
		move $a0, $t1
		jal strlen			# 	strlen(argv[i])
		print_int($v0)			#	print_int(strlen(argv[i]))
		addiu $s0, $s0, 1		# 	i = i + 1
		b for_i				# }
end:		li $v0, 0			# return 0
		stack_restore


# Includes
.include "../functions.asm"			# All functions