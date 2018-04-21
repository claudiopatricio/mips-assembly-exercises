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
	
		.eqv STR_MAX_SIZE, 10
		.eqv SIZE, 11
	
error1:		.asciiz "String too long. Nothing done!\n"
	
str0:		.space SIZE

		.text
		.globl main	
	
main:		stack_save
		move $s0, $a0			# argc
		move $s1, $a1			# argv
		li $v0, 0
		bne $s0, 1, exit		# if(argc == 1)
						# {
		lw $s2, 0($s1)			# 	argv[0]
		move $a0, $s2
		jal strlen			#	strlen(argv[0])
		move $s3, $v0
		bgtu $s3, STR_MAX_SIZE, else	# 	if(strlen(argv[0]) <= STR_MAX_SIZE)
						#	{
		la $a0, str0
		move $a1, $s2
		jal strcpy			#		strcpy(str0, argv[0])
		print_str(str0)			#		print_str(str0)
		li $v0, 0			# 		return 0
		j exit				#	}
else:						#	else
						#	{
		print_str(error1)		#		print_str("String too long!")
		li $v0, 1			# 		return 1
						#	}
exit:		stack_restore			# }
	
	
	
# Includes
.include "../functions.asm"			# All functions
