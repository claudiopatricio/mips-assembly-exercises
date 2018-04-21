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
str0:		.asciiz "Introduza um numero: "
val1:		.float 2.59375
val2:		.float 0.0
		.text
		.globl main	
	
main:		stack_save			
		l.s $f2, val2			# val2 = 0.0
						# do
main_d0i:					# {
		print_str(str0)			# 	print_str("Introduza um numero: ")
		read_int			# 	read_int()
		l.s $f1, val1			#	val1 = 2.59375
		mtc1 $v0, $f0
		cvt.s.w $f0, $f0		#	(float)read_int()
		mul.s $f12, $f0, $f1		#	aux = val1 * (float)read_int()
		print_float			#	print_float
		print_nl			#	print_str("\n")
		c.eq.s $f12, $f2		#	check = (aux == 0.0) ? false : true
		bc1f main_d0i			# } while(res != 0.0)
		li $v0, 0			# return 0
		stack_restore
		
	
	
# Includes
.include "../functions.asm"			# All functions
