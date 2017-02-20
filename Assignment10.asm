#Lab 08

#Program Description:	More on loops and subrutines
#Author:		Octavio Cea
#Creation Date:		03/07/16

.data
str01:	.asciiz "Enter an integer between 0-10: "
str02:	.asciiz "Invalid number.\n"
str03:	.asciiz "! = "

.text
main:
	la $a0, str01		#Print directions
	li $v0, 4
	syscall

	li $v0, 5		#store input into v0
	syscall

	add $s0, $0, $v0	#move input to s0
	li $t1, 10		#load 10 into t1

	blt $s0, $0, error	#go to error if a0 is less than 0
	bgt $s0, $t1, error	#go to error if a0 is greater than 10

	add $a0, $0, $s0	#move result into a0 to pass as parameter
	jal factorial		#go to function "Factorial"
	add $s1, $0, $v1	#move result into a0 to print

	li $v0,1		#output the number
	syscall

	la $a0, str03		#Print directions
	li $v0, 4
	syscall
	
	add $a0, $0, $s1	#move result into a0 to print
	li $v0,1		#output the result
	syscall

	li $v0, 10		#end the program
	syscall

factorial:
	beq $a0, $0, result2	#go to result2 if users input is 0
	
	addi $a1, $a0, -1	#subtract 1 from users input
	mult $a0, $a1		#multiply users input times users input -1
	mflo $v1		#move result to v1
	li $t0, 1		#load integer 1 into t0

loop:	beq $t0, $a1, result
	mult $v1, $t0
	mflo $v1
	addi $t0, $t0, 1
	j loop

result:	j $ra			#jump to address stored in ra

result2: li $v1, 1		#load integer 1 into v1
	j $ra			#jump to address stored in ra

error:
	la $a0, str02		#Print directions
	li $v0, 4
	syscall

	j main

