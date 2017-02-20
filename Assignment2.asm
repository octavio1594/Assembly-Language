#lab 02

#Program Description:		 Mathematical Operations
#Author:                         Octavio Cea
#Creation Date:                  02/03/2016

.data
str01:	.asciiz	"Please imput the two numbers?:\n\n"
str02:	.asciiz	"\nSum is\t\t"
str03:	.asciiz	"\n\nDifference is\t"
str04:	.asciiz	"\n\nProduct is\t\t"
str05:	.asciiz	"\n\nQuotient is\t\t"
str06:	.asciiz	"\n\nremainder is\t"

.text
main:
	la     $a0, str01
        li      $v0, 4		# print the content of $a0 which is string
        syscall

	li      $v0, 5 		#read an integer from user into $v0
	syscall

        add  $t0,$0,$v0 	#store $vo to $t0 

	li      $v0, 5 		#read an integer from user into $v0
	syscall

        add  $t1,$0,$v0 	#store $vo to $t1

	la     $a0, str02
        li      $v0, 4		# print the content of $a0 which is string
        syscall

	add $a0, $t0, $t1

	li      $v0, 1 		#print the content of a0 which is the sum
	syscall

	la     $a0, str03
        li      $v0, 4		# print the content of $a0 which is string
        syscall
		
	sub $a0, $t0, $t1

	li      $v0, 1 		#print the content of a0 which is the difference
	syscall

	la     $a0, str04
        li      $v0, 4		# print the content of $a0 which is string
        syscall
		
	mult $t0, $t1

	mflo $a0		#move from low to a0
	
	li      $v0, 1 		#print the content of a0 which is the product
	syscall

	la     $a0, str05
        li      $v0, 4		# print the content of $a0 which is string
        syscall
		
	div $t0, $t1

	mflo $a0		#move from low to a0
	
	li      $v0, 1 		#print the content of a0 which is the quotient
	syscall

	la     $a0, str06
        li      $v0, 4		# print the content of $a0 which is string
        syscall
		
	div $t0, $t1

	mfhi $a0		#move from hi to a0
	
	li      $v0, 1 		#print the content of a0 which is the remainder
	syscall



