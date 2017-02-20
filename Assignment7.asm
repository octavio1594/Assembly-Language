#Lab 06b

#Program Description:	More on Subrutines
#Author:		Octavio Cea
#Creation Date:		02/24/16

.data
str01:	.asciiz "Please enter the number in decimal form: "
str02:	.asciiz "That number in binary is: "

.text
main:
	la $a0, str01			#Print directions
	li $v0, 4
	syscall

	li $v0, 5			#store input into v0
	syscall		
			
	add $s0, $0, $v0		#move v0 to s0
	add $a1 ,$s0, $0		#move users input to an argument registeter before passing it to the function
	jal, baseChange			#call baseChange function

	la $a0, str02			#Print directions
	li $v0, 4
	syscall

	addi $t5, $t4, -32

loop3:	beq $t5, $0, proceed
	
	add $a0, $0, $0

	li $v0, 1			#print bit to the screen
	syscall
	
	addi $t5, $t5, 1

	j loop3

proceed:
	loop:	beq $t4, $0, exit	#when t4 is equal to 0 go to exit
	
	lw $a0, 0($sp)			#load word into t3
	addi $sp, $sp, 4		#move stack pointer to next index

	addi $t4, $t4, -1		#go arround loop the same number of times number was divided

	li $v0, 1			#print bit to the screen
	syscall

	j loop

exit:
	li $v0, 10			#end program
	syscall
	
baseChange:
		li $t0, 2		#load 2 into t0
		li $t4, 0		#load 0 into t4
		li $s0, 0

		add $s0, $0, $a1	#move users input to a safer register before working with it
	loop2:	beq $s0, $0, continue	#go to continue when s0 is equal to 0
		
		div $s0 $t0		#divide input by 2
		mfhi $t1		#store remainder into t1
		mflo $s0		#store divident into s0
		
		addi $sp, $sp, -4	#move stack pointer up one index
		sw $t1, 0($sp)		#store remainder into stack
		
		addi $t4, $t4, 1	#keep track of how many times the number was divided

		j loop2

		continue:
			jr $ra