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

str0:		.ascii "\nOperacao desconhecida"
str1:		.ascii "\nNumero de argumentos errado"

		.text
		.globl main	


main:		stack_save
		move $s0, $a0			# argc
		move $s1, $a1			# argv
		li $s5, 0
		bne $s0, 3, main_if0else	# if(argc == 3)
						# {
		lw $a0, 0($s1)			# 	argv[0]
		jal atoi			#	atoi(argv[0])
		move $s2, $v0			# 	val1 = atoi(argv[0])
		lw $a0, 8($s1)			# 	argv[2]
		jal atoi			#	atoi(argv[2])
		move $s3, $v0			# 	val2 = atoi(argv[2])
		lw $s6, 4($s1)			# 	op = argv[1]
		lb $s6, 0($s6)			# 	op = argv[1][0]
		bne $s6, 'x', main_if1else1	# 	if(op == 'x')
		mulu $s4, $s2, $s3		# 		res = val1 * val2
		j main_if1end
main_if1else1:	bne $s6, '/', main_if1else2	# 	else if(op == '/')
						#	{
		move $a0, $s2
		move $a1, $s3
		jal div				# 		div(val1, val2)
		srl $t0, $v0, 16
		mthi $t0
		and $s4, $v0, 0xFFFF		# 		res = div(val1, val2)
		j main_if1end			# 	}
main_if1else2:	bne $s6, '%', main_if1else3	# 	else if(op == '%')
						#	{
		divu $t0, $s2, $s3
		mfhi $s4			# 		res = val1 % val2
		j main_if1end			# 	}
main_if1else3:	print_str(str0)			# 	else
		li $s5, 1			# 		exit_code = 1
		j main_if1end			# }
main_if0else:	print_str(str1)			# else 
						# {
		li $s5, 2			# 	exit_code = 2
						# }
main_if1end:	bnez $s5, main_end		# if(exit_code == 0)
						# {
		move $a0, $s2
		li $a1, 10
		jal print_int_acli		# 	print_int_acli(val1, 10)
		print_charvar($s6)		# 	print_char(op)
		move $a0, $s3
		li $a1, 10
		jal print_int_acli		# 	print_int_acli(val1, 10)
		print_char('=')			# 	print_char('=')
		move $a0, $s4
		li $a1, 10
		jal print_int_acli		# 	print_int_acli(val1, 10)
						# }
main_end:	move $v0, $s5			# return exit_code
		stack_restore
		
	
# Includes
.include "../functions.asm"			# All functions
