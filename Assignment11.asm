#Lab 08b

#Program Description:	Arrays and subrutines
#Author:		Octavio Cea
#Creation Date:		03/09/16

.data
arr1:	.word	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
str01:	.asciiz "Number "
str03:	.asciiz ":\t\t"
nextLine:	.asciiz "\n"
str05:	.asciiz "The content of the array in order is:\n"
str02:	.asciiz "Enter values to fill an array of 10 elements:\n"

.text
main:		la	$s0, arr1	#load addres of arr1 into s0
		li $t1, 0		#$t1 is the counter
		li $t2, 10		#$t2 is the number of elements in the array

		la $a0, str02		#Print directions
		li $v0, 4
		syscall

     storeloop:	beq $t1, $t2, continue	#when t1 equals t2, go to continue
		
		la $a0, str01		#Print directions
		li $v0, 4
		syscall

		addi $a0, $t1, 1	#add 1 to the counter for display purposes

		li $v0, 1		#print counter to the screen
		syscall

		la $a0, str03		#Print : and tab
		li $v0, 4
		syscall
			
		li $v0, 5		#store input into v0
		syscall

		add $t3, $0, $v0	#store value into t3
		
		sw $t3, 0($s0)		#store values into array

		addi $t1, $t1, 1	#increment counter t1 by 1

		addi $s0, $s0, 4	#increment $s0 (the array pointer) by 4 to point to the next position

		j storeloop

      continue:	la $s0, arr1		#reload address of the first element of arr1 into s0
		
		add $a0, $s0, $0	#move address of array to an argument register	
		jal sortArray		#call function sortArray
		add $s0, $v0, $0	#move the address of the array to a save register before working with it

		la $a0, str05		#Print directions
		li $v0, 4
		syscall
		
		li $t1, 0		#reseting the counter t1 to 0

		la $s0, arr1		#reload address of the first element of arr1 into s0

   displayloop:	beq $t1, $t2 Proceed  	#when counter equals 10 go to proceed
		
		lw $t3, 0($s0)		#store the first element of the array into $t3
		addi $s0, $s0, 4	#increment $s0 (the array pointer) by 4 to point to the next position

		la $a0, str01		#Print directions
		li $v0, 4
		syscall

		addi $a0, $t1, 1	#add 1 to the counter for display purposes

		li $v0, 1		#print counter to the screen
		syscall

		la $a0, str03		#Print : and tab
		li $v0, 4
		syscall
		
		add $a0,$0,$t3		#move t3 to a0 for display purposes
		
		li $v0,1		#output the content of one element of array
		syscall

		la $a0, nextLine
		li $v0, 4		#go to next line
		syscall

		addi $t1, $t1, 1	#increment $t1 (the counter) by 1
		
		j displayloop		#jump back to displyloop

       Proceed: li $v0, 10		#end the program
		syscall

#--------------------------------------------------------------------------------------------------------------------------------------

sortArray:	add $s0, $a0, $0		#move the address of the array to a save register before working with it
		li $t6, 10			#load 10 into t6, 10 is the number of elements	
		li $t7, 0			#load 0 into t7, t7 is a counter for sortloop

      sortloop:	beq $t7, $t6, continue3		#when the counter t7 equals 10 go to continue3
		la $s0, arr1			#reload address of the first element of arr1 into s0	
		li $t5, 0			#load 0 into t5, t5 is a counter for sortloop2
		
     sortloop2:	beq $t5, $t6, continue2		##when the counter t5 equals 10 go to continue2
		lw $t3, 0($s0)			#load the first element of the array into $t3
		lw $t4, 4($s0)			#load the next element of the array into $t4

		addi $s0, $s0, 4		#increment $s0 (the array pointer) by 4 to point to the next position

		addi $t5, $t5, 1		#increment counter t5 by 1
		
		bgt $t3, $t4, sort		#if an element is greater than its next element go to sort
		j sortloop2			#jump back to sortloop2

          sort:	sw $t3 0($s0)			#place the greater element in the possition of the smaller element
		sw $t4 -4($s0)			#place the smaller element in the possition of the greater element
		j sortloop2			#jump back to sortloop2
		
     continue2: addi $t7, $t7, 1		#increment counter t7 by 1
		j sortloop			#jump back to sortloop

     continue3:	add $v0, $s0, $0		#move the address of the array to a return register
		j $ra				#jump back the address stored into ra