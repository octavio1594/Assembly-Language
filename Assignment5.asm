#Lab 05b

#Program Description:	Arrays and medians
#Author:		Octavio Cea
#Creation Date:		02/17/16

.data
arr1:	.word	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
str01:	.asciiz "Enter the number of elements: "
str02:	.asciiz "Enter number "
str04:	.asciiz "The element must be positive and greater than 10.\n"
str03:	.asciiz ":\t\t"
nextLine:	.asciiz "\n"
str05:	.asciiz "The median is: "

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
	
	li	$t4, 0			#$t4 is the counter
	
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
		li $t5, 2		#store 2 into t5
		
		div $s1, $t5		#divide users input by 2
		
		mfhi $t6		#move remainder to t6
		mflo $t8		#move divident to t8

		sgt $t7, $t6, $0	#t7 is 0 if input is even, if input is odd t7 is 1
		
		li $s3, 4		#load integer 4 into s3
		
		addi $t9, $t8, 1	#add 1 to users input/2 and store it in t9
		
		mult $t9, $s3		#multiply t9 by 4 to get address of median
		
		mflo $t0		#address of median is in t0

		sub $s0, $s0, $t0	#sub address of median from base address to access address of median
		lw $s4, 0($s0)		#load median into s4
		
		beq $t7, $0, evenNo	#if t7 is equal to 0 go to even number

		la $a0, str05		#Print "median is"
		li $v0, 4
		syscall
		
		add $a0, $0, $s4	#move median to a0
		
		li $v0, 1		#print median
		syscall

		li $v0, 10		#end program
		syscall

evenNo:
		lw $s5, 4($s0)		#load median into s4
		
		add $s6, $s5, $s4	#calculate the median

		div $s6, $t5		#calculate the median

		la $a0, str05		#Print "median is"
		li $v0, 4
		syscall
		
		mflo $a0		#move median to a0
		
		li $v0, 1		#print median
		syscall

		li $v0, 10		#end program
		syscall
		

error:
		la $a0, str04			#Print error
		li $v0, 4
		syscall

		j main		