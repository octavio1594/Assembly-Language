#Lab 06

#Program Description:	Subrutines
#Author:		Octavio Cea
#Creation Date:		02/22/16

.data
str01:	.asciiz "Please enter the number of items you are purchasing (Should be less than or equal to 20): "
str02:	.asciiz "Sorry too many items to purchase!\n"
str03:	.asciiz "PLease enter the price for item "
str04:	.asciiz "Please enter the number of coupons that you want to use
(should be less than or equal to the number of items you are to purchase)
cuppon is not valid for more than $10: "
str05:	.asciiz "Too many cupons\n"
str06:	.asciiz "Please enter the amount for cuppon "
str07:	.asciiz "Cuppon is not acceptable, cuppon value has been set to 0\n"
str08:	.asciiz "Your total charge is: "
str09:	.asciiz "\nThank you for shopping with us."
str10:	.asciiz ":\t\t"

.text
main:
	la $a0, str01			#Print directions
	li $v0, 4
	syscall

	li $v0, 5			#store input into v0
	syscall		
			
	add $s0, $0, $v0		#move v0 to s0

	li $t0, 20			#store integer 20 into t0
		
	bgt $s0, $t0, error01		#if s0 is greater than t0 go to error
	
	jal, FillPriceArray		#call FillPriceArray function
	add $t3, $v1, $0		#move return value from function to t3

cuppons:la $a0, str04			#Print directions
	li $v0, 4
	syscall

	li $v0, 5			#store input into v0
	syscall		
			
	add $s1, $0, $v0		#move v0 to s1
		
	bgt $s1, $s0, error02		#if s1 is greater than s0 go to error
	
	jal, FillCupponArray		#call FillCupponArray function
	add $t4, $v1, $0		#move return value from function to t4
	
	la $a0, str08			#Print directions
	li $v0, 4
	syscall

	sub $a0, $t3, $t4		#subtract cuppon total minus price total 

	li $v0, 1			#print out total
	syscall

	la $a0, str09			#Print directions
	li $v0, 4
	syscall

	li $v0, 10			#end program
	syscall


error01:
	la $a0, str02			#Print directions
	li $v0, 4
	syscall

	j main				#jump to main

error02:
	la $a0, str05			#Print directions
	li $v0, 4
	syscall

	j cuppons			#jump to cuppons

error03:
	la $a0, str07			#Print directions
	li $v0, 4
	syscall

	slt $v0, $t5, $v0		#set v0 to 0 if cuppon value is greater than 10

	j proceed			#jump to proceed


FillPriceArray:
			li $t1, 0			#store integer 0 into t1

	storeloop:	beq $t1, $s0, continue		#when the loop is done jump to continue
				
			la $a0, str03			#Print directions
			li $v0, 4
			syscall
				
			addi $a0, $t1, 1		#move t1 to a0 to display
			li $v0, 1			#print counter to the screen
			syscall
				
			la $a0, str10			#Print : and spaces
			li $v0, 4
			syscall

			li $v0, 5			#store input into v0
			syscall
		
			add $v1, $v1, $v0		#accumulate prices
			addi $t1, $t1, 1		#increment pointer
		
			j storeloop			#jump back to store loop

			continue:
				 jr $ra			#return to address stored in ra


FillCupponArray:
			li $t2, 0			#store integer 0 into t2
			li $v1, 0			#store integer 0 into v1
			li $t5, 10			#store integer 10 into t5

	storeloop2:	beq $t2, $s1, continue2		#when the loop is done jump to continue
				
			la $a0, str06			#Print directions
			li $v0, 4
			syscall
				
			addi $a0, $t2, 1		#move t1 to a0 to display
			li $v0, 1			#print counter to the screen
			syscall
				
			la $a0, str10			#Print : and spaces
			li $v0, 4
			syscall

			li $v0, 5			#store input into v0
			syscall

			bgt $v0, $t5, error03		#if cuppon value is greater than 10 go to error03
		
	proceed:	add $v1, $v1, $v0		#accumulate prices
			addi $t2, $t2, 1		#increment pointer
		
			j storeloop2			#jump back to storeloop02

			continue2:
				 jr $ra			#return to address stored in ra