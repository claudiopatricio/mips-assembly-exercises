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

	# All functions:
	#
	# int		soma(int *array, int nelem)
	# double	average(double *array, uint nelem)
	# double	max(double *array, uint nelem)
	# uint		fact(uint n)
	# int		xtoy(int x, uint y)
	# double	xtoyd(double x, int y)
	# double	sqrtd(double val)
	# int		abs(int val)
	# double	var(double *array, int nelem)
	# double	stdev(double *array, int nelem)
	# void		print_int_acl(uint num, uint base)
	# void		print_int_acli(uint val, uint base)
	# char*		strcpy(char *dst, char *src)
	# char*		strcpyrec(char *dst, char *src)
	# char*		strlcat(char *dst, char *src)
	# int		strlen(char *s)
	# int		strlenrec(char *s)
	# uint		atoi(char *s)
	# uint		atoibin(char *s)
	# char*		itoa(uint n, uint b, char *s)
	# char*		strrev(char *str)
	# void		exchange(char *c1, char *c2)
	# char		ascii(char v)
	# uint		div(uint a, uint b)
	# double	sortd(double *array, int nval)
	# void		tohanoy(int n, int p1, int p2, int p3)
	# void		hanoiprint(int t1, int t2, int cnt)
	# double	sort(double *array, int nval)



soma:		stack_save			# int soma(int *array, int nelem)
		move $s0, $a0			# int *array
		li $v0, 0
		beqz $a1, soma_end		# if(nelem != 0)
						# {
		addiu $a0, $a0, 4		#	array + 1
		addiu $a1, $a1, -1		#	nelem - 1
		jal soma			#	soma(array + 1, nelem - 1)
		lw $t0, 0($s0)			#	*array
		add $v0, $v0, $t0		#	*array + soma(array + 1, nelem - 1)
						# }
soma_end:	stack_restore			# return



average:	stack_save			# double average(double *array, uint nelem)		
		li $t0, 1			# i = 1
		ldc1 $f0, 0($a0)		# res = *array
		addiu $a0, $a0, 8		# array = array + 1
average_w0i:	bgeu $t0, $a1, average_end	# while(i < nelem)
						# {
		ldc1 $f2, 0($a0)		#	*array
		add.d $f0, $f0, $f2		#	res += *array
		addiu $t0, $t0, 1		#	i = i + 1
		addiu $a0, $a0, 8		#	array = array + 1
		j average_w0i			# }
average_end:	mtc1 $a1, $f2
		cvt.d.w $f2, $f2		# (double)nelem
		div.d $f0, $f0, $f2		# res = res / nelem
		stack_restore			# return res



max:		stack_save			# double max(double *array, uint nelem)
		li $t0, 1			# i = 1
		ldc1 $f0, 0($a0)		# res = *array
		addiu $a0, $a0, 8		# array = array + 1
max_w0i:	bgeu $t0, $a1, max_end		# while(i < nelem)
						# {
		ldc1 $f2, 0($a0)		#	*array
		c.lt.d $f2, $f0			#	check = (*array < res) ? true : false
		bc1t max_i0e			#	if(!check)
		mov.d $f0, $f2			#		res = *array
max_i0e:	addiu $t0, $t0, 1		#	i = i + 1
		addiu $a0, $a0, 8		#	array = array + 1
		j max_w0i			# }
max_end:	stack_restore			# return res



fact:		stack_save			# uint fact(uint n)
		bgtu $a0, 12, fact_error	# if(i > 12) exit(1)
		li $v0, 1			# ret = 1
		blez $a0, fact_end		# if(n > 1)
						# {
		move $s0, $a0			# 	uint n
		addiu $a0, $a0, -1		# 	n - 1
		jal fact			# 	fact(n - 1)
		mulu $v0, $v0, $s0		# 	ret = n * fact(n - 1)
fact_end:	stack_restore			# 	return ret
fact_error:	quit_int($v0)			# exit(1) Overflow



xtoy:		stack_save			# int xtoy(int x, uint y)
		li $v0, 1
		beqz $a1, xtoy_end		# if(y != 0)
						# {
		addiu $a1, $a1, -1		# 	y - 1
		jal xtoy			# 	xtoy(x, y - 1)
		mulu $v0, $v0, $a0		# 	x * xtoy(x, y - 1)
xtoy_end:	stack_restore			# 	return x * xtoy(x, y - 1)
						# } else return 1


xtoyd:		stack_save			# double xtoyd(double x, int y)
		li $t0, 1
		mtc1 $t0, $f0
		cvt.d.w $f0, $f0		# result = 1.0
		li $t0, 0			# i = 0
		jal abs				# abs(y)
xtoyd_w0i:	bgeu $t0, $v0, xtoyd_end	# while(i < abs(y))
						# {
		blez $a0, xtoyd_i0e		#	if(y > 0)
		mul.d $f0, $f0, $f12		#		result *= x
		j xtoyd_i0c			#	else
xtoyd_i0e:	div.d $f0, $f0, $f12		#		result /= x
xtoyd_i0c:	addiu $t0, $t0, 1		# 	i++
		j xtoyd_w0i			# }
xtoyd_end:	stack_restore			# return result



sqrtd:		stack_save			# double sqrtd(double val)
		mtc1 $zero, $f0
		mtc1 $zero, $f1
		c.le.d $f12, $f0		# check = (val <= 0.0) ? true : false
		bc1f sqrtd_i0e			# if(check == true)
		stack_restore			#	return 0.0
sqrtd_i0e:	li $t0, 1
		mtc1 $t0, $f0
		cvt.d.w $f0, $f0		# xn = 1.0
		li $t0, 0			# i = 0
		.data
sqrtd_aux0:	.double 0.5			# aux0 = 0.5
		.text
		l.d $f4, sqrtd_aux0
sqrtd_d0i:					# do
						# {
		mov.d $f2, $f0			#	aux = xn
		div.d $f0, $f12, $f0		#	xn = val/xn
		add.d $f0, $f0, $f2		#	xn = (xn + val/xn)
		mul.d $f0, $f0, $f4		#	xn = 0.5 * (xn + val/xn)
		addiu $t0, $t0, 1		#	i++
		c.eq.d $f0, $f2			#	check = (xn == aux) ? true : false
		bc1t sqrtd_end			#
		bltu $t0, 25, sqrtd_d0i		# } while ((aux != xn) && (++i < 25))
sqrtd_end:	stack_restore



abs:						# int abs(int val)
		move $v0, $a0
		bgez $v0, abs_end		# if(val < 0)
		neg $v0, $v0			#	val = -val
abs_end:	jr $ra				# return val



var:		stack_save			# double var(double *array, int nelem)
		move $s0, $a0			# double *array
		jal average			# average(array, nelem)
		mov.d $f4, $f0			# media = average(array, nelem)
		li $s1, 0			# i = 0
		mtc1 $zero, $f6			# res = 0.0
		mtc1 $zero, $f7
var_w0i:	bgeu $s1, $a1, var_end		# while(i < nelem)
						# {
		ldc1 $f12, 0($s0)		#	*array
		sub.d $f12, $f12, $f4		#	aux = *array - media
		li $a0, 2
		jal xtoyd			#	xtoyd(aux, 2)
		add.d $f6, $f6, $f0		#	res += xtoyd(aux)
		addiu $s1, $s1, 1		#	i = i + 1
		addiu $s0, $s0, 8		#	array = array + 1
		j var_w0i			# }
var_end:	mtc1 $a1, $f0
		cvt.d.w $f0, $f0
		div.d $f0, $f6, $f0		# res = soma / nval
		stack_restore			# return



stdev:		stack_save			# double stdev(double *array, int nelem)
		jal var				# var(array, nelem)
		mov.d $f12, $f0
		jal sqrtd			# sqrtd(var(array, nelem))
		#sqrt.d $f0, $f0
		stack_restore			# return



print_int_acl:	stack_save			# void print_int_acl(uint num, uint base)
		move $s0, $a0			# uint num
		divu $t0, $a0, $a1		# num / base
		mflo $t0
		mfhi $s1			# num % base
		beqz $t0, print_iacl_end	# if(num / base)
		move $a0, $t0
		jal print_int_acl		# print_int_acl( num / base, base)
print_iacl_end: move $a0, $s1
		jal ascii			# tosacii(num % base)
		print_charvar($v0)		# print_char(toascii(num % base))
		stack_restore



print_int_acli:	stack_save			# void print_int_acli(uint val, uint base)	
		.data
print_acli_buf:	.space 33
		.text
		la $a2, print_acli_buf
		jal itoa			# itoa(val, base, buf)
		print_strvar($v0)		# print_str(itoa(val, base, buf)
		stack_restore			# return



strcpy:		stack_save			# char* strcpy(char *dst, char *src)
		move $s0, $a0			# $s0: *dst
strcpy_d0i:					# do
						# {
		lb $t0, 0($a1)			# 	*src
		sb $t0, 0($a0)			# 	*dst = *src
		addiu $a0, $a0, 1		# 	dst++
		addiu $a1, $a1, 1		# 	src++
strcpy_d0e:	bnez $t0, strcpy_d0i		# } while(*src++ != 0)
		move $v0, $s0
		stack_restore			# return dst
		
		
		
strcpyrec:	stack_save			# char* strcpyrec(char *dst, char *src)
		move $s0, $a0			# char *dst
		lb $t0, 0($a1)			# *src
		sb $t0, 0($a0)			# *dst = *src
		beqz $t0, strcpyrec_end		# if((*dst = *src) != '\0')
						# {
		addiu $a0, $a0, 1		# 	dst + 1
		addiu $a1, $a1, 1		# 	src + 1
		jal strcpyrec			# 	strcpyrec(dst + 1, src + 1)
						# }
strcpyrec_end:	move $v0, $s0
		stack_restore			# return dst



strcat:		stack_save			# char* strlcat(char *dst, char *src)
		move $t0, $a0			# char *dst
		#move $s1, $a1			# char *src
		#move $s2, $s0			# ret = dst
		lb $t1, 0($a0)			# *p
strcat_w0i:	beqz $t1, strcat_w0e		# while(*p != 0)
						# {
		addiu $a0, $a0, 1		# 	p++
		lb $t0, 0($a0)			#	*p
		j strcat_w0i			# }
strcat_w0e:	jal strcpy			# strcpy(p, src)
		move $v0, $a0
		stack_restore			# return dst
		
		

strlen:		stack_save			# int strlen(char *s)
		move $s0, $a0			# char *s
		lb $s1, 0($s0)			# *s
		li $s2, 0			# $s2: i = 0
strlen_f0i:	beqz $s1, strlen_f0e		# while(*s != 0)
						# {
		addiu $s2, $s2, 1		# 	i = i + 1
		addiu $s0, $s0, 1		# 	s++
		lb $s1, 0($s0)			# 	$s1: *s
		b strlen_f0i			# }
strlen_f0e:	move $v0, $s2
		stack_restore			# return i
		
strlenrec:	stack_save			# int strlenrec(char *s)
		li $v0, 0			# ret = 0
		lb $t0, 0($a0)			# *s
		beqz $t0, strlenrec_end		# if(*s != '\0')
						# {
		addiu $a0, $a0, 1		# 	s + 1
		jal strlenrec			# 	strlenrec(s + 1)
		addiu $v0, $v0, 1		# 	ret = 1 + strlenrec(s + 1)
						# }
strlenrec_end:	stack_restore			# return ret



atoi:		stack_save			# uint atoi(char *s)
		move $s0, $a0			# $s0: char *s
		li $s1, 0			# res = 0
		lb $t0, 0($s0)			# *s
atoi_w0i:	bltu $t0, '0', atoi_w0end	# while(*s>='0'
		bgtu $t0, '9', atoi_w0end	# && *s<='9')
						# {
		subu $t1, $t0, '0'		# 	digit = *s + '0'
		mulu $s1, $s1, 10
		addu $s1, $s1, $t1		# 	res = 10 * res + digit
		addiu $s0, $s0, 1		# 	s++
		lb $t0, 0($s0)			# 	*s++
		b atoi_w0i			# }
atoi_w0end:	move $v0, $s1
		stack_restore			# return res



atoibin:	stack_save			# uint atoibin(char *s)
		move $s0, $a0			# $s0: char *s
		li $s1, 0			# res = 0
		lb $t0, 0($s0)			# *s
atoibin_w0i:	bltu $t0, '0', atoibin_w0end	# while(*s>='0'
		bgtu $t0, '1', atoibin_w0end	# && *s<='1')
						# {
		subu $t1, $t0, '0'		# 	digit = *s + '0'
		sll $s1, $s1, 1
		addu $s1, $s1, $t1		# 	res = 2 * res + digit
		addiu $s0, $s0, 1		# 	s++
		lb $t0, 0($s0)			# 	*s++
		b atoibin_w0i			# }
atoibin_w0end:	move $v0, $s1
		stack_restore			# return res



itoa:		stack_save			# char* itoa(uint n, uint b, char *s)
		move $s0, $a0			# $s0: uint n
		move $s1, $a1			# $s1: uint b
		move $s2, $a2			# $s2: char *s
		move $s4, $a2			# p
		lb $s3, 0($s2)			# *p
itoa_do0i:					# do
						# {
		divu $s0, $s0, $s1		#	
		mflo $s0
		mfhi $t0			# 	digit
		move $a0, $t0
		jal ascii			# 	ascii(digit)
		sb $v0, 0($s2)			# 	*p = ascii(digit)
		addiu $s2, $s2, 1		# 	p++
		bgtz $s0, itoa_do0i		# } while( n > 0 )
		sb $0, 0($s2)			# *p = '\0'
		move $a0, $s4			
		jal strrev			# strrev(s)
		stack_restore			# return s



strrev:		stack_save			# char* strrev(char *str)
		move $s0, $a0			# $s0: p1
		move $s1, $a0			# $s1: p2
		move $s3, $a0			# $s3: char *str (save entry)
		lb $s2, 0($s1)			# $s2: *p2
strrev_f0i:	beqz $s2, strrev_f0end		# while(*str0 != 0)
						# {
		addiu $s1, $s1, 1		# 	p2++
		lb $s2, 0($s1)			# 	$s2: *p2
		b strrev_f0i			# }
strrev_f0end:	subiu $s1, $s1, 1		# p2--
strrev_f1i:	bgeu $s0, $s1, strrev_f1end	# while( p1 < p2 )
						# {
		move $a0, $s0
		move $a1, $s1
		jal exchange			# 	exchange(p1, p2)
		addiu $s0, $s0, 1		# 	p1++
		subiu $s1, $s1, 1		# 	p2--
		b strrev_f1i			# }
strrev_f1end:	move $v0, $s3
		stack_restore			# return str



exchange:	stack_save			# void exchange(char *c1, char *c2)
		lb $s0, 0($a0)			# *c1 (aux)
		lb $s1, 0($a1)			# *c2 (aux)
		sb $s0, 0($a1)			# *c2 = *c1
		sb $s1, 0($a0)			# *c1 = *c2
		stack_restore


		
ascii:		stack_save			# char ascii(char v)
		move $s0, $a0			# char v
		addu $s0, $s0, '0'		# v += '0'
		bleu $s0, '9', ascii_end	# if(v > '9')
		add $s0, $s0, 7			# 	v += 7
ascii_end:	move $v0, $s0
		stack_restore			# return v



div:		stack_save			# uint div(uint a, uint b)
		move $s0, $a0			# uint a
		move $s1, $a1			# uint b
		sll $s1, $s1, 16		# b = b << 16
		and $s0, $s0, 0xffff		# a = a & 0xFFFF
		sll $s0, $s0, 1			# a = a << 1
		li $s2, 0			# i = 0
div_w0i:	bgeu $s2, 16, div_w0end		# while(i < 16)
						# {
		li $s3, 0			# 	bit = 0
		blt $s0, $s1, div_if0end	# 	if(a >= b)
						#	{
		sub $s0, $s0, $s1		# 		a = a - b
		li $s3, 1			# 		bit = 1
						#	}
div_if0end:	sll $s0, $s0, 1			# 	a = a << 1
		or $s0, $s0, $s3		# 	a = a | bit
		addiu $s2, $s2, 1		# 	i++
		j div_w0i			# }
div_w0end:	sra $s5, $s0, 1			# rest = a >> 1
		andi $s5, $s5, 0xffff0000	# rest = rest & 0xFFFF0000
		andi $s4, $s0, 0xffff		# quotient = a & 0xFFFF
		or $v0, $s5, $s4
		move $v0, $s4
		stack_restore			# return (rest | quotient)



sortd:						# double sortd(double *array, int nval)
		subiu $t2, $a1, 1		# nval - 1
						# do
						# {
sortd_d0i:	li $t0, 0			# 	houveTroca = FALSE
		li $t1, 0			# 	i = 0
sortd_f0i:	bgeu $t1, $t2, sortd_f0e	# 	for(i = 0; i < SIZE - 1; i++)
						#	{
		sll $t3, $t1, 3			# 		i * 8 (Double is 8 bytes)
		addu $t3, $t3, $a0		#		&array[i]
		ldc1 $f0, 0($t3)		# 		aux1 = array[i]
		ldc1 $f2, 8($t3) 		#		aux2 = array[i+1]
		c.lt.d $f0, $f2			#		check = (array[i] < array[i+1]) ? true : false
		bc1t sortd_i0e			# 		if(array[i] > array[i+1])
						#		{
		li $t0, 1			# 			houveTroca = TRUE
		sdc1 $f0, 8($t3)		# 			array[i] = array[1+1]
		sdc1 $f2, 0($t3)		# 			array[i+1] = array[i]
						#		}
sortd_i0e:	addiu $t1, $t1, 1		#		i = i + 1
		j sortd_f0i			#	}
sortd_f0e:	addiu $t2, $t2, -1		# 	Last double is always the big one
		beq $t0, 1, sortd_d0i		# } while(houveTroca==TRUE)
		srl $a1, $a1, 1			# nval / 2
		sll $a1, $a1, 3			# Each double have 8 bytes
		addu $a0, $a0, $a1		# array + (nval / 2)
		ldc1 $f0, 0($a0)		# return array[nval / 2]
		jr $ra



tohanoi:	stack_save			# void tohanoy(int n, int p1, int p2, int p3)
		.data
tohanoi_cnt:	.word 0				# static int count = 0
		.text
		move $s0, $a0			# int n
		move $s1, $a1			# int p1
		move $s2, $a2			# int p2
		move $s3, $a3			# int p3
		beq $s0, 1, tohanoi_else	# if(n != 1)
						# {
		addiu $a0, $s0, -1		# 	n - 1
		move $a1, $s1
		move $a2, $s3
		move $a3, $s2
		jal tohanoi			# 	tohanoi(n - 1, p1, p3, p2)
		lw $s4, tohanoi_cnt		# 	count
		addiu $s4, $s4, 1
		sw $s4, tohanoi_cnt		# 	count++
		move $a0, $s1
		move $a1, $s2
		move $a2, $s4
		jal hanoiprint			# 	hanoiprint(p1, p2, ++count)
		addiu $a0, $s0, -1
		move $a1, $s3
		move $a2, $s2
		move $a3, $s1
		jal tohanoi			# 	tohanoi(n - 1, p3, p2, p1)
		stack_restore			# }
tohanoi_else:					# else {
		lw $s4, tohanoi_cnt		#	count
		addiu $s4, $s4, 1		
		sw $s4, tohanoi_cnt		# 	count++
		move $a0, $s1
		move $a1, $s2
		move $a2, $s4
		jal hanoiprint			# 	hanoiprint(p1, p2, ++count)
		stack_restore			# }



hanoiprint:	stack_save			# void hanoiprint(int t1, int t2, int cnt)
		.data
hanoiprint_s0:	.asciiz "\nPasso "
hanoiprint_s1:	.asciiz " - Mover disco de topo de "
hanoiprint_s2:	.asciiz " para "
		.text
		move $s0, $a0			# int t1
		move $s1, $a1			# int t2
		move $s2, $a2			# int cnt
		print_str(hanoiprint_s0)	# print_str("\nPasso ")
		move $a0, $s2
		li $a1, 10
		jal print_int_acl		# print_int_acl(cnt, 10)
		print_str(hanoiprint_s1)	# print_str(" - Mover disco de topo de ")
		move $a0, $s0
		li $a1, 10
		jal print_int_acl		# print_int_acl(t1, 10)
		print_str(hanoiprint_s2)	# print_str(" para ")
		move $a0, $s1
		li $a1, 10
		jal print_int_acl		# print_int_acl(t2, 10)
		stack_restore			# return void



f2c:		stack_save			# double f2c(double ft)
		.data
f2c_val0:	.double 32
f2c_val1:	.double 1.8			# 9 / 5
		.text
		l.d $f0, f2c_val0
		sub.d $f0, $f12, $f0		# ft - 32.0
		l.d $f4, f2c_val1
		div.d $f0, $f0, $f4		# (ft - 32) / 1.8
		stack_restore			# return (ft - 32) / 1.8
