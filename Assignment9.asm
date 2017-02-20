#Lab 07b

#Program Description:	floating point
#Author:		Octavio Cea
#Creation Date:		02/29/16

.data
str01:	.asciiz "Please enter the message: "
str02:	.asciiz "\n\nThe encrypted message is: "
str03:	.asciiz "\n\nThe original message is: "
input:	.byte '-', '-', '-', '-', '-', '-', '-', '-', '-', ' '
encrypt: .byte '-', '-', '-', '-', '-', '-', '-', '-', '-', ' '	
decrypt: .byte '-', '-', '-', '-', '-', '-', '-', '-', '-', ' '


.text			
main:	la $s0, input		#store the address of array input into s0
	la $s1, encrypt		#store the address of array encrypt into s1
	la $s2, decrypt		#store the address of array decrypt into s2
	li $t0, 9		#load counter into t0
	li $t2, 7		#load encrypt key into t2

	la $a0, str01			#Print directions
	li $v0, 4
	syscall

	la $a0, input		#store the address of array input into a0
	li $v0, 8       	#code number of system program that connects keyboard to processor
				
        li $a1, 10		# allow user to enter 9 character
	syscall

loop:	beq $t0,$0, printEncr		#go to printEncr when t0 is equal to 0 
	lb $t1, 0($s0)		#load byte into t1 from array input possition 1
	xor $t1, $t1, $t2	#xor value entered by user with encrypt key
	sb $t1, 0($s1)		#store byte from t1 to array encrypt possition 1
	li $t1, 0		#clear t1
	addi $s0, $s0,1		#move pointer of array input 
	addi $s1,$s1,1		#move pointer of array encrypt
	sub $t0,$t0,1		#update loop counter
	j loop			# jump to loop

printEncr:	la $a0, str02			#Print directions
		li $v0, 4
		syscall
	
		la $a0,encrypt		#store the address of array encrypt into a0
		li $v0,4
		syscall

		li $t0, 9		#reload 9 into t0
		li $t1, 0		#clear t1
		la $s1, encrypt		#store the address of array encrypt into s1
		
loop2:	beq $t0,$0, printDecr		#go to printDecr when t0 is equal to 0
	lb $t1, 0($s1)			#load byte into t1 from array encrypt possition 1
	xor $t1, $t1, $t2		#xor value entered by user with encrypt key
	sb $t1, 0($s2)			#store byte from t1 to array decrypt possition 1
	li $t1, 0			#clear t1
	addi $s1, $s1,1			#move pointer of array encrypt
	addi $s2,$s2,1			#move pointer of array decrypt
	sub $t0,$t0,1		#update loop counter
	j loop2			# jump to loop

printDecr:	la $a0, str03			#Print directions
		li $v0, 4
		syscall
	
		la $a0, decrypt			#store the address of array decrypt into a0
		li $v0,4
		syscall

		li $v0, 10			#end program
		syscall
