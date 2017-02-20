#Lab 05

#Program Description:	Arrays and loops
#Author:		Octavio Cea
#Creation Date:		02/15/16

.data
arr1:	.word	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
str01:	.asciiz "Enter the number of elements: "
str02:	.asciiz "Enter number "
str04:	.asciiz "The element must be positive and greater than 10.\n"
str03:	.asciiz ":\t\t"
nextLine:	.asciiz "\n"
str05:	.asciiz "The content of the array in reverse order is:\n"

.text
main:	
	la	$s0, arr1		#load addres of arr1 into s0
	
	la $a0, str01			#Print directions
	li $v0, 4
	syscall
	
	li $v0, 5			#store input into v0
	syscall
	
	add $s1, $0, $v0		#move v0 to s1

	li $t0, 10			#store 10 into t0
	li $t1, 0			#store 0 into t1
	
	bgt $s1, $t0, error		#if s1 is greater than t0 go to error
	blt $s1, $0, error		#if s1 is less than t1 go to error
	
	li	$t4, 0			#$a1 is the counter
	
storeloop:	beq $t4, $s1, proceed	#when the loop is done jump to displayloop
		
		la $a0, str02		#Print directions
		li $v0, 4
		syscall

		addi $a0, $t4, 1

		li $v0, 1		#print counter to the screen
		syscall

		la $a0, str03		#Print : and tab
		li $v0, 4
		syscall
			
		li $v0, 5		#store input into v0
		syscall

		add $t2, $0, $v0	#store value into t2

		sw $t2, 0($s0)		#store values into array

		addi $t4, $t4, 1	#increment counter

		addi $s0, $s0, 4	#increment pointer

		j storeloop

proceed:
		la $a0, str05		#Print directions
		li $v0, 4
		syscall
		
		li $t4, 0

displayloop:	beq $t4, $s1, Proceed  	#when the loop is done jump to exit
		
		add $s0, $s0, -4	#decrement $s0 (the array pointer) by 4 to point to the next position
		
		lw $t3, 0($s0)		#store the next element of the array into $t3

		add $a0,$0,$t3		#move t3 to a0
		
		li $v0,1		#output the content of one element of array
		syscall

		la $a0, nextLine
		li $v0, 4		#go to next line
		syscall

		add $t4, $t4, 1		#decrement $a0 (the counter) by 1
		
		j displayloop		

Proceed:
	li $v0, 10			#end the program
	syscall

error:
	la $a0, str04			#Print error
	li $v0, 4
	syscall

	j main