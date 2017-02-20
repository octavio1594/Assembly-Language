#Assignment 2 Programing question

#Program Description:	Arrays
#Author:		Octavio Cea
#Creation Date:		02/29/16

.data
arr1:	.word	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
str01:	.asciiz "Enter the value for the array size, value must be between 0 and 20: "
str02:	.asciiz "Enter number divisible by 3, ->"
str04:	.asciiz "That element is not positive.\n"
str03:	.asciiz ":\t\t"
nextLine: .asciiz "\n"
str05:	.asciiz "The content of the array in reverse order is:\n"
str06:	.asciiz "The value entered is not between 0 and 20.\n"
str07:	.asciiz "The value entered is not divisible by 3.\n"

.text

begin:		la $s0, arr1		#load addres of arr1 into s0
	
		la $a0, str01		#Print directions
		li $v0, 4
		syscall

		jal readNum		#call the function readNum
		add $s1, $0, $v0	#move v0 to s1
		
		add $a1 ,$s1, $0	#move s1 to an argument register
		jal verifySize		#call the function verifySize
		add $s3, $0 $v1		#move v1 to a safer register
		beq $s3, $0, error	#if s3 is equal to 0 go to error (if users input is not divisible by 3)
		add $s3, $0 $v0		#move v0 to a safer register
		beq $s3, $0, error	#if s3 is equal to 0 go to error (if users input is not possitive)
		
		add $a1 ,$s1, $0	#move s1 to an argument register
		jal createArray		#call the function createArray
		
		add $a1 ,$s1, $0	#move s1 to an argument register
		jal reverseArray	#call the function reverseArray
		
		add $a1 ,$s1, $0	#move s1 to an argument register
		jal printArray		#call the function printArray
		
		j exit			#jump to exit
#----------------------------------------------------------------------------------------------------------------------
readNum:	li $v0, 5		#store input into v0
		syscall
		
		jr $ra			#jump to the address stored in ra
#----------------------------------------------------------------------------------------------------------------------
verifySize:	li $s1, 0		#clear register s1
		add $s1, $0, $a1	#move users input to a safer register before working with it

		li $t0, 21			#store 21 into t0

		slt $v1, $0, $s1, 		#if 0 is less than users input set t1 to 1
		slt $v0, $s1, $t0, 		#if users input is less than 21 set t1 to 1
	
		jr $ra		#jump to the address stored in ra
#----------------------------------------------------------------------------------------------------------------------
createArray:	li $s1, 0		#clear register s1
		add $s1, $0, $a1	#move users input to a safer register before working with it

		addi $sp, $sp, -4	#allocate space in the stack
		sw $ra 0($sp)		#store address into the stack

		li $t2, 0		#store 0 into t2, t2 is the counter

	loop:	beq $t2, $s1, proceed	#when the loop is done jump to proceed
		
		la $a0, str02		#Print directions
		li $v0, 4
		syscall

		addi $a0, $t2, 1	#add one to counter and store result into a0 (for display purposes only)

		li $v0, 1		#print counter to the screen
		syscall

		la $a0, str03		#Print : and tab
		li $v0, 4
		syscall
			
		jal readNum		#call the function readNum
		add $s2, $0, $v0	#move value from v0 value into s2
		
		add $a2, $0, $s2	#move s2 to an argument register
		jal checkNumPositive	#call the function checkNumPositive
		add $t6, $0, $v1	#move v1 to a safer register before working with it
		beq $0, $t6, error01	#if t6 equals 0 go to error
		
		add $a2, $0, $s2	#move s2 to an argument register
		jal divisibleBy3	#call the function divisibleBy3
		add $t7, $0 $v1		#move v1 to a safer register before working with it
		bne $t7, $0, error02	#if t7 does not equal 0 go to error

		sw $s2, 0($s0)		#store values into array

		addi $t2, $t2, 1	#increment counter

		addi $s0, $s0, 4	#increment pointer

		j loop		#jump back to loop

     proceed:	lw $ra 0($sp)		#load address into ra from the stack
		addi $sp, $sp, 4	#deallocate space in the stack
		jr $ra			#jump back to new address stored in ra
#----------------------------------------------------------------------------------------------------------------------
divisibleBy3:	li $s2, 0		#clear register s2
		add $s2, $0, $a2	#move users input to a safer register before working with it

		li $t3, 3		#store 3 into t3
		div $s2, $t3		#divide users input by 3
		mfhi $t5		#store remainder into t5
		
		slt $v1, $0, $t5	#if 0 is less than remainder set t7 to 1

		jr $ra			#jump back to address stored in ra
#----------------------------------------------------------------------------------------------------------------------
checkNumPositive:	li $s2, 0		#clear register s2
			add $s2, $0, $a2	#move users input to a safer register before working with it

			slt $v1, $0, $s2	#if 0 is less than users input set v1 to 1

			jr $ra		#jump back to address stored in ra
#----------------------------------------------------------------------------------------------------------------------
reverseArray:	la $a0, str05		#Print message
		li $v0, 4
		syscall

		jr $ra		#jump back to address stored in ra
#----------------------------------------------------------------------------------------------------------------------
printArray:	li $s1, 0		#clear register s1
		add $s1, $0, $a1	#move users input to a safer register before working with it

		li $t1, 0	#clear register t1

        loop2:  beq $t1, $s1, proceed01  	#when the loop is done jump to proceed01
		
		add $s0, $s0, -4	#decrement $s0 (the array pointer) by 4 to point to the next position

		li $t6, 0		#clear register t6
		lw $t6, 0($s0)		#store the next element of the array into $t3

		add $a0,$0,$t6		#move t6 to a0
		
		li $v0,1		#output the content of one element of array
		syscall

		la $a0, nextLine
		li $v0, 4		#go to next line
		syscall

		add $t1, $t1, 1		#increment $t1 (the counter) by 1

		j loop2		#jump back to loop2

    proceed01:	jr $ra		#jump back to address stored in ra
#----------------------------------------------------------------------------------------------------------------------
exit:	li $v0, 10		#end the program
	syscall

#----------------------------------------------------------------------------------------------------------------------
error:	la $a0, str06		#print error message
	li $v0, 4
	syscall

	j begin			#jump to begin
#----------------------------------------------------------------------------------------------------------------------
error01:	la $a0, str04		#print error message
		li $v0, 4
		syscall
		
		j loop			#jump to loop
#----------------------------------------------------------------------------------------------------------------------
error02:	la $a0, str07		#print error message
		li $v0, 4
		syscall

		j loop			#jump to loop
	
