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
  j	innerLoop			# START PROGRAM
  
##################################################################################
##   Insert code here for changing appropriate * characters to |                ##
##################################################################################


  
innerLoop:

  beq	$t4, $s1, exit			# exit if counter = end of array
  beq	$t5, $s0, charIndicator		# print char if coutner = indicated column number
  beq	$t5, $t2, print_new_line	# preparing to load a char
  
  addi	$v0, $0, 11			# prep to print char
  lb	$a0, display($t4)		# load char
  syscall				# print char
  
  addi	$t5, $t5, 1			# advance counter
  addi	$t4, $t4, 1			# advance counter
  j	innerLoop			# looping mechanism
  
charIndicator:
 
  lb	$a1, lineChar			# load lineChar
  sb 	$a1, display($t4)		# store the lineChar in the indicated position of the 64-bit output string
  
  addi	$v0, $0, 11			# syscall for adding to memory
  lb	$a0, display($t4)		# loading byte to memory
  syscall				# print *
  
  addi	$t5, $t5, 1			# incremement counter
  addi	$t4, $t4, 1			# increment counter
  j	innerLoop			# looping mechanism

##################################################################################
##   Insert code here for printing thre resulting display.                      ##
##   The code for printing a new line character is given to you.		##
##################################################################################  

print_new_line:
	addi	$v0, $0, 11		# prep to print newLine char
	lb	$a0, newline		# load newLine char
	syscall				# print newLine char
	beq	$t6, $s1, exit		# exit if counter = 64
	add	$t5, $0, $0		# set t5 counter back to 0

	j innerLoop			# looping mechanism

# Exit from the program
exit:
  ori $v0, $0, 10       		# system call code 10 for exit
  syscall               		# exit the program
