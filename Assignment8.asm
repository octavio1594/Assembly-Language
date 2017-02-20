#Lab 07

#Program Description:	floating point
#Author:		Octavio Cea
#Creation Date:		02/29/16

.data
str01:	.asciiz "Please enter the temperature in Celsius: "
str02:	.asciiz "The temperature in Farenheit is: "
num:    .float 1.8 
num01:	.float 32.0

.text
main:
	la $a0, str01			#Print directions
	li $v0, 4
	syscall

	li $v0, 5			#store input into v0
	syscall		

	mtc1 $v0, $f1			#move content in v0 to f1

	cvt.s.w $f1, $f1		#convert number in f1 from integer to floating point   

	l.s $f2, num			#load 1.8 address into f2

	mul.s $f3, $f2, $f1		#multiply users input by 1.8

	l.s $f4, num01

	add.s $f3, $f3, $f4		#add 32 to the product to get farenheit temperature

	la $a0, str02			#Print directions
	li $v0, 4
	syscall
	
	li $v0, 2			  	
	mov.s $f12, $f3			#move value in f3 to f12 to get printed 						#$f0 to$f12 to get printed		
	syscall

	li $v0, 10			#end program
	syscall