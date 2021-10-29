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
  
##################################################################################
##   Insert code here for changing appropriate * characters to |                ##
##################################################################################
  
  addi 	$t2, $0, 8			# set register t2 to 8
  addi 	$t3, $0, 8			# set register t3 to 8
  addi	$t4, $0, 0			# counter var 1
  addi	$t5, $0, 0			# counter var 2
  li	$t6, 0				# counter var 3
  
innerLoop:
  beq	$t6, $s0, charIndicator		# conditional to break to the | char
  addi	$v0, $0, 4			# preparing to load a char
  la	$a0, displayChar		# loading a char's address
  syscall				# printing a char
  addi	$t6, $t6, 1			# adding 1 to counter var
  beq	$t6, $t3, outerLoop		# conditional to break loop and go to outer loop
 
  j	innerLoop			# looping mechanism
  
charIndicator:
  addi	$v0, $0, 4			# preparing to print new char
  la	$a0, lineChar			# loading lineChar into memory
  syscall				# printing lineChar
  addi	$t6, $t6, 1			# adding 1 to counter variable
  beq	$t6, $t3, outerLoop		# condiitonal to break loop and start printing *
  
  j innerLoop				# jumps to innerLoop
  
outerLoop:
  addi	$v0, $0, 4			# preparing to print new char
  la	$a0, newline			# loading newline into memory
  syscall				# printing newline
  addi	$t5, $t5, 1			# adding 1 to counter var
  li	$t6, 0				# loading an immediate value of 0 in $t6 reg
  beq	$t5, $t2, exit			# conditional to break loop if $t5 (0) gets tp $t2 (10)
  
  j	innerLoop			# looping mechanism
##################################################################################
##   Insert code here for printing thre resulting display.                      ##
##   The code for printing a new line character is given to you.		##
##################################################################################  

  
print_new_line:
	addi $v0, $0, 11
	lb $a0, newline
	syscall
	
	j innerLoop

# Exit from the program
exit:
  ori $v0, $0, 10       		# system call code 10 for exit
  syscall               		# exit the program
