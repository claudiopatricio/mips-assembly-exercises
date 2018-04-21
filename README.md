# MIPS Assembly Exercises

Collection of exercises from Computer Architecture at University of Aveiro @ 2013/14

**Note**: The exercises reports are written in Portuguese, and the solutions may contain some notes in Portuguese as well.

## How to run

* 1. Download Mars from this repository (You will need Java installed to be able to run Mars)
* 2. Open "**asm**" file in **Mars**
* 3. Click "Assemble" (F3)
* 4. Click "Go" (F5)

## Important files

Some of the code are needed for multiple exercises, for that reason there are 2 files, one for macros and the other for functions created for each exercise that may be needed in another exercise.

You can also use this files in your projects as a standalone library.

### functions.asm

Contains a collection of functions:

* int		soma(int *array, int nelem)
* double	average(double *array, uint nelem)
* double	max(double *array, uint nelem)
* uint		fact(uint n)
* int		xtoy(int x, uint y)
* double	xtoyd(double x, int y)
* double	sqrtd(double val)
* int		abs(int val)
* double	var(double *array, int nelem)
* double	stdev(double *array, int nelem)
* void		print_int_acl(uint num, uint base)
* void		print_int_acli(uint val, uint base)
* char*		strcpy(char *dst, char *src)
* char*		strcpyrec(char *dst, char *src)
* char*		strlcat(char *dst, char *src)
* int		strlen(char *s)
* int		strlenrec(char *s)
* uint		atoi(char *s)
* uint		atoibin(char *s)
* char*		itoa(uint n, uint b, char *s)
* char*		strrev(char *str)
* void		exchange(char *c1, char *c2)
* char		ascii(char v)
* uint		div(uint a, uint b)
* double	sortd(double *array, int nval)
* void		tohanoy(int n, int p1, int p2, int p3)
* void		hanoiprint(int t1, int t2, int cnt)
* double	sort(double *array, int nval)

### macros.asm

Contains a library of IO procedures and a stack save and restore procedure to avoid repeating the code for each time you need to do IO or stack management.

* void 		print_str(const char *s)
* void 		print_strvar(char *s)
* void 		print_char(const char c)
* void 		print_charvar(char c)
* void 		print_nl()
* void 		print_int(int n)
* void 		print_uint(uint n)
* void 		print_hex(int16 n)
* void 		print_float(float n)
* void 		print_double(double n)
* int		read_int()
* float		read_float()
* double	read_double()
* char*		read_str()
* char*		read_string()
* void		stack_save()
* void		stack_restore()
* void		quit()
* void		quit_int(int n)

### startup.s

This file includes the code to start the main function and will work as a exception handler.

To avoid errors in some exercises, you need to include this file as the exception handler of Mars.

**Note**: Go to Settings -> Exception Handler... -> Activate the "Include this exception handler file in all assemble operations" -> Browse the startup.s -> Press OK

# Donate

If you like my work and want to contribute by donating money, check my [Donation page](http://anjo2.com/donate/)

# License
Copyright (c) 2018 Cláudio Patrício <<cpatricio@ua.pt>>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.