#Lab 04a

#Program Description:	Loops and decision making
#Author:		Octavio Cea
#Creation Date:		02/10/16

.data
str01:	.asciiz "How many numbers that are divisible by 6 do you want to add? "
str02:	.asciiz "Enter a number between 1 and 100: "
str03:	.asciiz "Error, that number is not in the range of 1 to 100.\n"
str04:	.asciiz "That number is divisible by 6.\n"
str05:	.asciiz "That number is not divisible by 6.\n"
str06:	.asciiz "The sum of all the numbers that are divisible by 6 is: "

.text
main:
	la $a0, str01			#Print directions
	li $v0, 4
	syscall
	
	li $v0, 5			#store input into v0
	syscall

	add $s0, $0, $v0		#move v0 to s0

	li $s4, 0			#store 0 into s4
	li $t0, 100			#store 5 into t0
	li $t1, 1			#store 0 into t1
	li $t2, 6			#store 6 into t2
	li $s3, 0			#store 0 into s3

loopParameter: beq $s4, $s0, Proceed	#when s4 is equal to s0 proceed
	
	la $a0, str02			#Print directions
	li $v0, 4
	syscall
	
	li $v0, 5			#store input into v0
	syscall

	add $s1, $0, $v0		#move v0 to s1
	
	beq $s1, $0, Error		#if s1 is equal to 0 go to error
	bgt $s1, $t0, Error		#if s1 is greater than t0 go to error
	blt $s1, $0, Error		#if s1 is less than t1 go to error
	
	div $s1, $t2			#divide s1 by t2
	mfhi $t3			#move remainder to t3

	bne $t3, $0, notDiv		#if t3 is not equal to 0 go to is not divisible

	la $a0, str04			#Print out is divisible
	li $v0, 4
	syscall

	add $s3, $s3, $s1		#accumulate imputs if divisible by 6

	addi $s4, $s4, 1		#increment counter
	j loopParameter
		
Proceed:
	la $a0, str06			#Print total sum string
	li $v0, 4
	syscall

	add $a0, $0, $s3		#move total sum to a0

	li $v0, 1			#print total sum to the screen
	syscall

	li $v0, 10			#end the program
	syscall

Error:
	la $a0, str03
	li $v0, 4
	syscall

	j loopParameter

notDiv:
	la $a0, str05
	li $v0, 4
	syscall

	j loopParameter