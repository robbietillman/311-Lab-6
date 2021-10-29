.data 0x0
  
  nPrompt:	.asciiz "Enter the size (N) of the array:\n"
  newline:	.asciiz "\n"
  displayChar:  .asciiz "*"
  lineChar:  .asciiz "|"
  a:	.space 400
  i:	.space 4
  output: .space 256
  

.text 0x3000
main:
				# Print the prompt for reading N
	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, nPrompt  			# address of nPrompt is in $a0
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
	sw	$8, a($10)			# stores a[i]
	
	#addi	$v0, $0, 1								
	#add	$10, $8, $0			# a[i] = $8 integer value + 0
	#add	$a0, $0, $10			# bring the value from $10 into $a0
	#syscall
	
	addi 	$9, $9, 1			# for (...; ...; i++)
	slt	$11, $9, $s0			# for (...; i < N;)
	bne	$11, $0, loop			# loop if $10 is not not equal to 0
	
##################################################################################
	
	
##################################################################################
##   Insert code here for reversing the elements in memory                      ##


	reverse_loop:
		
		addi	$v0, $0, 1		#temp
		lw	$a0, a($10)		#temp
		
		syscall

		
		addi	$9, $9, -1		#decrementing the counter
		#
		addi	$v0, $0, 4		# preparing to print newline
		la	$a0, newline		# printnig newline
		syscall
		
		beq	$10, $0, exit		# We found the null-byte
		addi	$10, $10, -4		# subracring 4 to get to previous index
		
		j	reverse_loop		# Loop until we reach our condition
	
	# addi	$7, $7, -1				# for(...; ...; i--)
	# slt 	$10, $7, 
##################################################################################	


##################################################################################
##   Insert code here for printing the reversed array                           ##
##################################################################################


# Exit from the program
exit:
 
 	ori $v0, $0, 10       		# system call code 10 for exit
  	syscall               		# exit the program
