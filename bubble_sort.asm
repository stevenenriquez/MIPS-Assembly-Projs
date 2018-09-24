############################################
#  Steven Enriquez - Proj1: Bubble Sort
############################################

## Register Map ##
# $s0 = address past the end of the array
# $t0 = address of the current element of the array

	.data
array:		.word 4, 3, 7, 8, 1, 6, 2, 9, 5, 10
unsorted:	.asciiz "Unordered list: \n\n"
sorted:		.asciiz "\nSorted list: \n\n"

	.text
	.globl main
 
main:	
	# print out .asciiz string 'sorted'
	li $v0, 4		# instruction to print a string
	la $a0, unsorted
	syscall
	
	# print_loop initialization
	la $s0, array
	addi $s0, $s0, 40	# 40 is the length of the 10 4-byte numbers
	la $t0, array

print_loop:
	# termination condition
	beq $t0, $s0, quit_print
	
	# load the current integer into $a0 for printing
	lw $a0, 0($t0)
	li $v0, 1		# instruction to print an integer
	syscall

	# print a new line, puts each number on its own line
	li $v0, 11
	li $a0, '\n'
	syscall

	# increment the address to the next word
	addi $t0, $t0, 4	# each word (number in array) is 4 bytes
	
	# branch back to the beginning of the loop
	b print_loop
quit_print:

	# loop initialization
	li $t2, 0 		# throw 0 into $t0
	
while_loop: 
	# termination condition
	beq $t2, 10, end_while	# loop until the counter == 10
	
	la $t0, array
	addi $s2, $t0, 36
	
sort_loop:
	# termination condition
	beq $t0, $s2, quit_sort

	# load the data for a possible swap
	lw $s0, 0($t0) 		# load into $s0, the address that $t0 has
	lw $s1, 4($t0)		# load the number in front of $t0 into $s1
	
	# condition to either continue or skip the swap
	ble $s0, $s1, skip_if
	
	# swap the two values
	sw $s0, 4($t0)
	sw $s1, 0($t0)
	
skip_if:
	# update to the next word (number) in the array
	addi $t0, $t0, 4
	b sort_loop
quit_sort:
	# update the counter by 1
	addi $t2, $t2, 1
	b while_loop
end_while:

	# print_sorted loop initialization
	la $s0, array
	addi $s0, $s0, 40
	la $t0, array

	# print out .asciiz string 'unsorted'
	li $v0, 4
	la $a0, sorted
	syscall

print_sorted:
	# termination condition
	beq $t0, $s0, quit_sorted
	
	# load the current integer into $a0 for printing
	lw $a0, 0($t0)
	li $v0, 1
	syscall

	# print a new line, puts each number on its own line
	li $v0, 11
	li $a0, '\n'
	syscall

	# increment the address to the next word (number)
	addi $t0, $t0, 4
	
	# branch back to the beginning of the loop
	b print_sorted
quit_sorted:
	
	# exit
	li $v0, 10
	syscall
