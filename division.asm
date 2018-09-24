# Integer division
# Take in two numbers a, b
# Tell the user how many times b evenly divides a
# and also how many are left over

	.data 	        # this is for static data
prompt: .asciiz "Please enter an integer: "
newline: .asciiz "\n"   # may not need this, we used '\n' instead
div_Result: .asciiz "A div B: "
mod_result: .asciiz "\nA mod B: "

		
	.text		# everything that follows is actually code
	.globl main 	# this is where execution begins

main:
	li $v0, 4	# print prompt
	la $a0, prompt
	syscall
	
	li $v0, 5	# read int
	syscall		# user's integer in $v0
	move $s0, $v0	# move into $s0 from $v0 ($s0 is a temp register, doesnt get affected by syscalls)
			# now $s0 holds integer 'a'
	
	li $v0, 4	# print prompt
	la $a0, prompt
	syscall
	
	li $v0, 5	# read int
	syscall		# user's integer in $v0
	move $s1, $v0 	# $s1 holds integer 'b'
	
	## Divide a by b
	div $s0, $s1	
	
	## Print results
	li $v0, 4
	la $a0, div_Result
	syscall
	
	li $v0, 1
	mflo $a0	# move from lo to $a0
	syscall
	
	li $v0, 4
	la $a0, mod_result
	syscall
	
	li $v0, 1
	mfhi $a0
	syscall
	
	## Exit specific to qtSpim
	
	li $v0, 10
	syscall
	
	

