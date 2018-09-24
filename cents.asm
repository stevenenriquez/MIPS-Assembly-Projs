# Make change:
# Prompt the user for a number of cents
# Process the nubmer of cents into a minimal configuration
# 		  of quarters, dimes, nickels, and pennies
# Print out how many coins
	
# Tools: syscall (code #4 to print a string)
#		 (code #5 to read an integer)
#		 (code #1 to print an integer)
#	 div a, b(a div b into lo, a mod b into hi)
#	 mflo
#	 mfhi
	
	.data
prompt: .asciiz "Enter a number of cents: "
quarters: .asciiz "Quarters: "
dimes: .asciiz "Dimes "
nickels: .asciiz "Nickels "
pennies: .asciiz "Pennies "
	
	.text
	
	.globl main
	
main:	
	# $s0 = remaining # of cents after each div
	# $s1 = # of quarters
	# $s2 = # of dimes
	# $s3 = # of nickels
	# $s4 = # of pennies
	# $t0 = Value of the current point type
	
	li $v0, 4	# prints out the prompt
	la $a0, prompt
	syscall
	
	li $v0, 5	# 5 - takes in an integer
	syscall		# cents now in $a0
	move $s0, $v0	# moves the integer from v0 to s0, a temp reg
	
	## Find number of quarters
	li $t0, 25
	div $s0, $t0
	mflo $s1 	# move number of quarters to $s1
	mfhi $s0	# update remaining cents
	
	## Find number of dimes
	li $t0, 10
	div $s0, $t0
	mflo $s2 	# move number of dimes to $s1
	mfhi $s0	# update remaining cents
	
	## Find number of nickels
	li $t0, 5
	div $s0, $t0
	mflo $s3 	# move number of nickels to $s1
	mfhi $s0	# update remaining cents
	
	## Find number of pennies
	li $t0, 1
	div $s0, $t0
	mflo $s4 	# move number of nickels to $s1
	mfhi $s0	# update remaining cents
	
	li $v0, 4	# prints out string quarters
	la $a0, quarters
	syscall
	
	li $v0, 1	# prints out value of quarters
	move $a0, $s1
	syscall
	
	li $v0, 11	# goes to a new line		
	la $a0, '\n'
	syscall
	
	li $v0, 4	# prints out string dimes
	la $a0, dimes
	syscall
	
	li $v0, 1	# prints out value of dimes
	move $a0, $s2
	syscall
	
	li $v0, 11	# goes to a new line
	la $a0, '\n'
	syscall
	
	li $v0, 4	# prints out string nickels
	la $a0, nickels
	syscall
	
	li $v0, 1	# prints out value of nickels
	move $a0, $s3
	syscall
	
	li $v0, 11	# goes to a new line
	la $a0, '\n'
	syscall
	
	li $v0, 4	# prints out string pennies
	la $a0, pennies
	syscall
	
	li $v0, 1	# prints out value of pennies
	move $a0, $s4
	syscall
	
	li $v0, 11	# goes to a new line
	la $a0, '\n'
	syscall
	
	## Exits
	li $v0, 10
	syscall
