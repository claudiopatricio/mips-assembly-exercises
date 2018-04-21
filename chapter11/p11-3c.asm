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
		.eqv SIZE 11
str0:		.asciiz "Introduza graus em Fahrenheit: "
str1:		.asciiz "Array: "
str2:		.asciiz "Max: "
str3:		.asciiz "Media: "
str4:		.asciiz "Mediana: "
str5:		.asciiz "Variancia: "
str6:		.asciiz "Desvio padrao: "

#array:		.double 0:SIZE
array:		.double 8.0, -4.0, 3.0, 5.0, 12.0, -15.0, 87.0, 9.0, 27.0, 15.0, 35.0

		.text
		.globl main	
	
main:		stack_save
		la $t0, array			# array
		li $t1, 0			# i = 0
main_d0i:					# do
						# {
		print_str(str0)			# 	print_str("Introduza graus em Fahrenheit: ")
		read_double			# 	read_double()
		mov.d $f12, $f0
		jal f2c				#	f2c(read_double)
		sdc1 $f0, 0($t0)		#	*array = f2c(read_double())
		addiu $t0, $t0, 8		#	array++
		addiu $t1, $t1, 1		#	i = i + 1
		blt $t1, SIZE, main_d0i		# } while(i < SIZE)
		
		# Array de temperaturas completo
		print_str(str1)			# print_str("Array: ")
		li $t1, 0			# i = 0
		la $t0, array			# array
main_d1i:					# do
						# {
		ldc1 $f12, 0($t0)		#	*array
		print_double			#	print_double(*array)
		print_char(' ')			#	print_char(' ')
		addiu $t0, $t0, 8		#	array++
		addiu $t1, $t1, 1		#	i++
		blt $t1, SIZE, main_d1i		# } while(i < SIZE)
		print_nl			# print_nl
		
		# Temperatura máxima
		la $a0, array
		li $a1, SIZE
		jal max				# max(array, SIZE)
		print_str(str2)			# print_str("Max: ")
		mov.d $f12, $f0
		print_double			# print_double(max(array, SIZE))
		print_nl			# print_nl
		
		# Média
		la $a0, array
		li $a1, SIZE
		jal average			# average(array, SIZE)
		print_str(str3)			# print_str("Media: ")
		mov.d $f12, $f0
		print_double			# print_double(average(array, SIZE))
		print_nl			# print_nl
		
		# Mediana
		la $a0, array
		li $a1, SIZE
		jal sortd			# sortd(array, SIZE)
		print_str(str4)			# print_str("Mediana: ")
		mov.d $f12, $f0
		print_double			# print_double(sortd(array, SIZE))
		print_nl			# print_nl
		
		# Variancia
		la $a0, array
		li $a1, SIZE
		jal var				# var(array, SIZE)
		print_str(str5)			# print_str("Variancia: ")
		mov.d $f12, $f0
		print_double			# print_double(var(array, SIZE))
		print_nl			# print_nl
		
		# Desvio Padrao
		la $a0, array
		li $a1, SIZE
		jal stdev			# stdev(array, SIZE)
		print_str(str6)			# print_str("Desvio Padrao = ")
		mov.d $f12, $f0
		print_double			# print_double(stdev(array, SIZE))
		li $v0, 0			# return 0
		stack_restore
		
	
	
# Includes
.include "../functions.asm"			# All functions
