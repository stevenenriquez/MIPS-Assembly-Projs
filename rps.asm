# Rock-Paper-Scissors:
# Ask player 1 for their choice (r/p/s)
# Ask player 2
# Determine the winner
# Notify the players of who won

# TOOLS: beq, beqz

	.data 		# this is for static data
start: .asciiz "\nWELCOME TO THE BEST ROCK/PAPER/SCISSORS GAME OF ALL TIME"
prompt: .asciiz "\nPlease enter your choice (r/p/s): "
p1_win: .asciiz "\nPlayer 1 wins!"
p2_win: .asciiz "\nPlayer 2 wins!"
tie: .asciiz "\nThere was a tie!"

	.text		# everything that follows is actually code
	.globl main 	# this is where execution begins

main:
	## Welcome Screen
	
	li $v0, 4
	la $a0, start
	syscall
	
	## Get player choices
	
	# Print prompt for player 1
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Read player 1's choice
	li $v0, 12
	syscall # $v0 has p1's choice
	move $s0, $v0
	
	# Print prompt for player 2
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Read player 2's choice
	li $v0, 12
	syscall # $v0 has p1's choice
	move $s1, $v0
	
	## Find the winner
	
	# Check for a tie
	bne $s0, $s1, skip_tie
	# If you're here, there was a tie
	# Print tie message
	li $v0, 4
	la $a0, tie
	syscall
	
	j exit
		
skip_tie:

	## Start doing victory checking
	li $t0, 'r'
	li $t1, 'p'
	li $t2, 's'
	
	##bne $s0, $t0, skip_rock
	## Continue code for victory checking

exit:
	li $v0, 10
	syscall
