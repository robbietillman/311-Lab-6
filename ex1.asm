.data 0x0
  
  nPrompt:	.asciiz "Enter the size (N) of the array:\n"
  newline:	.asciiz "\n"
  displayChar:  .asciiz "*"
  lineChar:  .asciiz "|"
  a:	.word
  i:	.space 4
  output: .space 256
  

.text 0x3000
main:
				# Print the prompt for reading N
	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, nPrompt 			# address of nPrompt is in $a0
	syscall           			# print the string
	
	# read in the N (number of elements)
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$s0, $0, $v0			# copy N into $s0
	
	add	$7, $s0, $0			# second loop for (i = N; ... 
	add 	$9, $0, $0			# first loop for (i = 0; ...
##################################################################################
##   Insert code here for reading N array elements into memory                  ##
loop:
	
	addi	$v0, $0, 5			# system call 5 for reading an integer
	syscall					# integer value read in is in $v0
	add 	$8, $0, $v0			# copy the integer value into $8
	
	sll 	$10, $9, 2			# convert "i" to word offset by multiplying by 4
	lw	$10, a($10)			# load a[i]
	add	$10, $8, $0			# a[i] = $8 integer value + 0
	syscall
	addi 	$9, $9, 1			# for (...; ...; i++)
	slt	$10, $9, $s0			# for (...; i < N;)
	bne	$10, $0, loop			# loop if $10 is not not equal to 0
	
##################################################################################
	
	
##################################################################################
##   Insert code here for reversing the elements in memory                      ##


printLoop:
	
	li	$t0, 0
	li 	$t3, 0
	
	reverse_loop:
		add	$t3, $s0, $t0		# $t2 is the base address for our 'input' array, add loop index
		lb	$t4, 0($t3)		# load a byte at a time according to counter
		beqz	$t4, exit		# We found the null-byte
		sb	$t4, output($t1)		# Overwrite this byte address in memory	
		subi	$t1, $t1, 1		# Subtract our overall string length by 1 (j--)
		addi	$t0, $t0, 1		# Advance our counter (i++)
		j	reverse_loop		# Loop until we reach our condition
	
	# addi	$7, $7, -1				# for(...; ...; i--)
	# slt 	$10, $7, 
##################################################################################	


##################################################################################
##   Insert code here for printing the reversed array                           ##
##################################################################################


# Exit from the program
exit:

	li	$v0, 4			# Print
	la	$s0, output		# the string!
	syscall
 
   ori $v0, $0, 10       		# system call code 10 for exit
  syscall               		# exit the program
