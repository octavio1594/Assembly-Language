# lab 01

#Program Description:		 Output
#Author:                         Octavio Cea
#Creation Date:                  02/01/2016

.data
str:	.asciiz	"Here is the Report of Top 5 employees in Erickson Company:"
str01:	.asciiz	"\n=========================================================="
str02:	.asciiz	"\nLast Name\tFirst Name\tPosition\tSalary"
str03:	.asciiz	"\n~~~~~~~~~\t~~~~~~~~~~\t~~~~~~~~~\t~~~~~~~~"
str04:	.asciiz	"\nSmith\t\tAdam\t\tDirector\t"
str05:	.asciiz	"\nHadden\tMary\t\tDirector\t"
str06:	.asciiz	"\nSimpson\tMike\t\tManager\t"
str07:	.asciiz	"\nWilliams\tAndrea\tDesigner\t"
str08:	.asciiz	"\nAmer\t\tAli\t\tDesigner\t"
str09:	.asciiz	"\n========================================================="

.text
main:
				
		li	$v0, 4			# printing a string
		la	$a0, str
		syscall	
				
		li	$v0, 4			# printing a string
		la	$a0, str01
		syscall
				
		li	$v0, 4			# printing a string
		la	$a0, str02
		syscall
				
		li	$v0, 4			# printing a string
		la	$a0, str03
		syscall
				
		li	$v0, 4			# printing a string
		la	$a0, str04
		syscall
						# printing an integer
		li	$v0, 1
		li       	$a0, 99010
		syscall
				
		li	$v0, 4			# printing a string
		la	$a0, str05
		syscall
						# printing an integer
		li	$v0, 1
		li       	$a0, 95220
		syscall	
				
		li	$v0, 4			# printing a string
		la	$a0, str06
		syscall
						# printing an integer
		li	$v0, 1
		li       	$a0, 80000
		syscall
		
		li	$v0, 4			# printing a string
		la	$a0, str07
		syscall
						# printing an integer
		li	$v0, 1
		li       	$a0, 70000
		syscall
				
		li	$v0, 4			# printing a string
		la	$a0, str08
		syscall
						# printing an integer
		li	$v0, 1
		li       	$a0, 55000
		syscall			
				
		li	$v0, 4			# printing a string
		la	$a0, str09
		syscall
		
		li        $v0 , 10		#the code for termination of program 
		syscall			
