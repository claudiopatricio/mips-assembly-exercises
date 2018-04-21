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

str0:		.asciiz "N. Mec: "
str1:		.asciiz "Primeiro Nome: "
str2:		.asciiz "Ultimo Nome: "
str3:		.asciiz "Nota: "
str4:		.asciiz "Nome: "

		.eqv std_id, 0
		.eqv std_fname, 4
		.eqv std_lname, 22
		.eqv std_grade, 40
		.eqv std_fname_size, 18
		.eqv std_lname_size, 15

		.align 2
std:		.word 73284
		.asciiz "Claudio"
		.space 10			# 18 - strlen(fname)
		.asciiz "Patricio"
		.space 6
		.align 2
		.float 17.9

		.text
		.globl main	
	
main:		stack_save
		la $t0, std
                print_str(str0)			# print_str("N. Mec: ")
                read_int			# read_int()
                sw $v0, std_id($t0)
                print_str(str1)			# print_str("Primeiro Nome: ")
		la $t1, std_fname($t0)
                read_str($t1, std_fname_size)# read_string()
                print_str(str2)			# print_str("Ultimo Nome: ")
		la $t1, std_lname($t0)
                read_str($t1, std_lname_size)# read_string()
                print_str(str3)			# print_str("Nota: ")
                read_float			# read_float()
                swc1 $f0, std_grade($t0)
                print_nl
		print_str(str0)			# print_str("N. Mec: ")
		lw $t1, std_id($t0)
		print_intu($t1)			# print_intu(std.id)
		print_nl
		print_str(str4)			# print_str("Nome: ")
		la $t1, std_lname($t0)
		print_strvar($t1)		# print_str(std.last_name)
		print_char(',')			# print_char(',')
		print_char(' ')			# print_char(' ')
		la $t1, std_fname($t0)
		print_strvar($t1)		# print_str(std.first_name)
		print_nl
		print_str(str3)			# print_str("Nota: ")
		lwc1 $f12, std_grade($t0)
		print_float			# print_float(std.grade)
		li $v0, 0			# return 0
		stack_restore
		
	
	
# Includes
.include "../functions.asm"			# All functions
