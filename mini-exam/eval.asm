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


eval:		addiu $sp, $sp, -20
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sd $f20, 12($sp)
		move $s0, $a0
		bnez $s0, eval_i0e		# if(n == 0)
		.data				# {
eval_n1:	.double 1.0
		.text
		l.d $f0, eval_n1		#	aux = 1.0;
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		ld $f20, 12($sp)
		addiu $sp, $sp, 20
		jr $ra				#	return aux;
						# }
eval_i0e:	mtc1 $0, $f20			# else
		mtc1 $0, $f21			# {
		li $s1, 0			# 	sum = 0.0; i=0;
eval_f0i:	bgeu $s1, $s0, eval_f0e		# 	while(i < n)
						#	{
		move $a0, $s1			#		
		jal eval			#		eval(i);
		add.d $f20, $f20, $f0		# 		sum += eval(i);
		addiu $s1, $s1, 1		#		i++;
		j eval_f0i			#	}
eval_f0e:	.data
eval_n2:	.double 2.0
		.text
		l.d $f4, eval_n2		# aux = 2.0;
		mul.d $f0, $f20, $f4		# ret = 2.0 * sum
		mtc1 $s0, $f4
		cvt.d.w $f4, $f4
		div.d $f0, $f0, $f4		# ret = ret / n
		add.d $f0, $f0, $f4		# ret = ret + n
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $f20, 12($sp)
		addiu $sp, $sp, 20
		jr $ra				# return (2.0 * sum / n) + n;