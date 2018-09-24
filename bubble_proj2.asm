##########################################
## Steven Enriquez - Proj2: Bubble Sort ##
### Register Map ###
# $s0: address past end of array
# $t0: address of current element of array
##########################################

	.data
array:		.word 4, 3, 7, 8, 1, 6, 2, 9, 5, 10
unsorted:	.asciiz "Unordered list: \n\n"
sorted:		.asciiz "\nSorted list: \n\n"

	.text
	.globl main

main:	
	li $v0, 4
	la $a0, unsorted	# print .asciiz string 'unsorted'
	syscall
	
	jal print
	#jal sort
	
	li $v0, 4
	la $a0, sorted		# print .asciiz string 'sorted'
	syscall
	
	jal sort
	jal print
	
	li $v0, 10		# exit
	syscall
##### PRINT #########################################################################
print:	
	la $s0, array		# initialization
	addi $s0, $s0, 40	# 40 - length of the 10 4-byte numbers
	la $t0, array

print_loop:
	beq $t0, $s0, quit_print# termination condition
	
	lw $a0, 0($t0)		# load current integer into $a0 for printing
	li $v0, 1		# instruction to print an integer
	syscall

	li $v0, 11
	li $a0, '\n'		# print a new line, puts each number on its own line
	syscall

	addi $t0, $t0, 4	# increment the address to the next word
	
	b print_loop		# branch back to the beginning of the loop
quit_print:
	jr $ra
##### SORT ##########################################################################	
sort:
	li $t2, 0 		# initialization: throw 0 into $t0
	
while_loop: 
	beq $t2, 10, end_while	# termination: loop until the counter == 10
	
	la $t0, array
	addi $s2, $t0, 36
	
sort_loop:
	beq $t0, $s2, quit_sort # termination condition

	lw $s0, 0($t0) 		# load into $s0, the address that $t0 has
	lw $s1, 4($t0)		# load the number in front of $t0 into $s1
	
	ble $s0, $s1, skip_if	# condition to continue or skip swap
	
	sw $s0, 4($t0)		# swap
	sw $s1, 0($t0)		# swap
	
skip_if:
	addi $t0, $t0, 4	# update to the next word
	b sort_loop
quit_sort:
	addi $t2, $t2, 1	# update counter by 1
	b while_loop
end_while:
	jr $ra
