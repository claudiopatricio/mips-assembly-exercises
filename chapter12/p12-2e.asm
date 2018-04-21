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
str5:		.asciiz "Media: "

		.eqv MAX_STUDENTS 2
		
		.eqv std_id, 0
		.eqv std_fname, 4
		.eqv std_lname, 22
		.eqv std_grade, 40
		.eqv std_size, 44
		.eqv std_fname_size, 18
		.eqv std_lname_size, 15

		.align 2
st_array:	.space 176
media:		.float 0.0

		.text
		.globl main	
	
main:		stack_save
		la $a0, st_array
		li $a1, MAX_STUDENTS
		jal read_data			# read_data(st_array, MAX_STUDENTS)
		print_nl
		la $a0, st_array
		li $a1, MAX_STUDENTS
		la $a2, media
		jal maxst			# maxst(st_array, MAX_STUDENTS, &media)
		move $a0, $v0
		jal print_student		# print_student(maxst(st_array, MAX_STUDENTS, &media))
		print_nl
		print_nl
		print_str(str5)
		l.s $f12, media
		print_float
		li $v0, 0			# return 0
		stack_restore



read_data:	stack_save			# void read_data(student *st, int ns)
		move $s0, $a0
		move $s1, $a1
		li $t0, 0			# i = 0
read_data_w0i:	bgeu $t0, $s1, read_data_end	# while(i < ns)
						# {
		print_str(str0)			#	print_str("N. Mec: ")
		read_int			#	read_int()
		sw $v0, std_id($s0)		#	*st.id = read_int()
		print_str(str1)			#	print_str("Primeiro Nome: ")
		la $t1, std_fname($s0)		#	st.first_name
		read_str($t1, std_fname_size)	#	*st.first_name = read_string()
		print_str(str2)			#	print_str("Ultimo Nome: ")
		la $t1, std_lname($s0)		#	st.last_name
		read_str($t1, std_lname_size)	#	*st.last_name = read_string()
		print_str(str3)			#	print_str("Nota: ")
		read_float			#	read_float()
		swc1 $f0, std_grade($s0)	#	*st.id_number = read_float
		addiu $s0, $s0, std_size	#	st++
		addiu $t0, $t0, 1		# 	i++
		j read_data_w0i			# }
read_data_end:	stack_restore			# return



maxst:		stack_save			# student* maxst(student *st, int ns, float *media)
		.data
maxst_max:	.float -20.0
		.text
		l.s $f4, maxst_max		# max_grade = -20.0
		li $t0, 0			# i = 0
		mtc1 $t0, $f5			# sum = 0.0
maxst_w0i:	bgeu $t0, $a1, maxst_end	# while(i < ns)
						# {
		lwc1 $f0, std_grade($a0)	# 	st->grade
		add.s $f5, $f5, $f0		#	sum += st->grade
		c.le.s $f4, $f0			#	check = (st->grade <= max_grade) ? true : false
		bc1f maxst_i0e			#	if(st->grade > max_grade)
						#	{
		mov.s $f4, $f0			#		max_grade = p_grade
		move $v0, $a0			#		pmax = st
						#	}
maxst_i0e:	addiu $t0, $t0, 1		#	i++
		addiu $a0, $a0, std_size	#	st++
		j maxst_w0i			# }
maxst_end:	mtc1 $a1, $f1
		cvt.s.w $f1, $f1		# float(ns)
		div.s $f1, $f5, $f1		# sum / ns
		swc1 $f1, 0($a2)		# media = sum / ns
		stack_restore



print_student:	stack_save			# void print_student(student *p)
		move $s0, $a0			# student *p
		print_str(str0)			# print_str("N. Mec: ")
		lw $t0, std_id($s0)		# std.id
		print_intu($t0)			# print_intu(std.id)
		print_nl
		print_str(str4)			# print_str("Nome: ")
		la $t0, std_fname($s0)		# std.first_name
		print_strvar($t0)		# print_str(std.first_name)
		print_char(',')			# print_char(',')
		la $t0, std_lname($s0)		# std.last_name
		print_strvar($t0)		# print_str(std.last_name)
		print_nl
		print_str(str3)			# print_str("Nota: ")
		lwc1 $f12, std_grade($s0)	# std.grade
		print_float			# print_float(std.grade)
		stack_restore			# return

# Includes
.include "../functions.asm"			# All functions
