.data 0x0
  display:	.asciiz "****************************************************************"
  columnPrompt:	.asciiz "Enter the column to print a line at (must be an integer in the range 0-7):\n"
  newline:	.ascii "\n"
  displayChar:  .ascii "*"
  lineChar:  .ascii "|" # Note, we don't need to use asciiz here, since we're storing a single character! (using asciiz would also store\0, which would be two characters)
  
  


.text 0x3000
main:
 					# Print the prompt for reading the column
   addi	$v0, $0, 4  			# system call 4 is for printing a string
   la 	$a0, columnPrompt 		# address of columnPrompt is in $a0
   syscall           			# print the string


   addi	$v0, $0, 5			# system call 5 is for reading an integer
   syscall 				# integer value read is in $v0
   add	$s0, $0, $v0			# copy the column number into $s0
   
   li $s1 64				# $s1 will store the size of the array
   
  addi 	$t2, $0, 8			# set register t2 to 8
  addi 	$t3, $0, 8			# set register t3 to 8
  addi	$t4, $0, 0			# counter var 1
  addi	$t5, $0, 0			# counter var 2
  li	$t6, 0				# counter var 3
  j	innerLoop
  
##################################################################################
##   Insert code here for changing appropriate * characters to |                ##
##################################################################################


  
innerLoop:

  beq	$t4, $s1, exit
  beq	$t5, $s0, charIndicator
  beq	$t1, $t2, print_new_line	# preparing to load a char
  
  addi	$v0, $0, 11
  lb	$a0, display($t4)
  syscall
  
  addi	$t5, $t5, 1
  addi	$t4, $t4, 1
  j	innerLoop
  
charIndicator:
 
  lb	$a1, lineChar			# set register t2 to 8
  sb 	$a1, display($t4)		# set register t3 to 64
  
  addi	$v0, $0, 11			# syscall for adding to memory
  lb	$a0, display($t4)		# loading byte to memory
  syscall				# print *
  
  addi	$t5, $t5, 1
  addi	$t4, $t4, 1
  j	innerLoop

##################################################################################
##   Insert code here for printing thre resulting display.                      ##
##   The code for printing a new line character is given to you.		##
##################################################################################  

print_new_line:
	addi	$v0, $0, 11
	lb	$a0, newline
	syscall
	beq	$t4, $s1, exit
	add	$t1, $0, $0

	j innerLoop

# Exit from the program
exit:
  ori $v0, $0, 10       		# system call code 10 for exit
  syscall               		# exit the program
