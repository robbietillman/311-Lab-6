.data 0x0
  array:	.word 20, 39, 20, 31, 40, 21, 31, 25, 20, 35, 27, 33, 39, 32, 33, 28
  readIntPrompt: .asciiz "Enter next integer (in range 20-40):\n"
  minPrompt:	.asciiz "Enter the new min value (an integer in the range 0-19):\n"
  maxPrompt:	.asciiz "Enter the new max value (an integer in the range 41-255):\n"
  newline:	.ascii "\n"
  .align 4 # This ensures that the space character is in the lowest order byte of its word
  spaceChar:    .asciiz " "
  
  


.text 0x3000
main:
    
 					
   addi	$v0, $0, 4  			
   la 	$a0, minPrompt
   syscall           


   addi	$v0, $0, 5
   syscall 	
   add	$s0, $0, $v0 # NewMin is stored in $s0
   
   					
   addi	$v0, $0, 4  			
   la 	$a0, maxPrompt 		
   syscall           			


   addi	$v0, $0, 5			
   syscall 				
   add	$s1, $0, $v0 # NewMax is stored in $s1
   
  addi 	$s2, $0, 16			# set register t2 to 16
  addi 	$t3, $0, 4			# set register t3 to 4
  addi	$t4, $0, 0			# counter var 1
  addi	$t5, $0, 0			# counter var 2
  addi	$t6, $0, 0			# counter var 3
  addi	$t7, $0, 0			# counter var 4
  addi	$t8, $0, 0			# counter var 5
  addi 	$t9, $0, 20			# temp
  addi	$t2, $0, 1			# register set to 1
   
   
##################################################################################
##   Insert code here for performing normalization of data                      ##
##################################################################################
   
setRange:

  add	$t7, $s1, $0			# setting t7 to new maximum value
  sub	$t7, $t7, $s0			# setting t7 to new max - min vals
  add	$t8, $t9, $0			# setting t8 to max - min
  div	$t7, $t7, $t9			# dividing old vals by new vals
  lw	$t1, array($t4)			# loading word from memory
  sub	$t1, $t1, $t9			# setting t1 to loaded word - min
  mul	$t1, $t7, $t1			# multiplying old values by new ones 
  add	$t1, $t1, $s0			# adding new min to old values
  sw	$t1, array($t4)			# storing new value
  
  j	output				# looping mechanism
  
output:
  addi	$v0, $0, 1			# prep to print int
  lw	$a0, array($t4)			# load int
  syscall				# ptint int
  
  addi	$v0, $0, 11			# prep to print spec char
  lb	$a0, spaceChar			# load char
  syscall				# print char
  
  add	$t5, $t2, $t5			# temp
  add	$t6, $t6, $t2			# temp
  add	$t4, $t4, $t3			# temp
  j converge				# looping mechanism
  
converge:
  beq	$t6, $s2, exit			# exit if loop is done
  beq	$t5, $t3, print_new_line	# print new line if t5 = 4
  j setRange
  
print_new_line:
  addi 	$v0, $0, 11			# prep to print char
  lb	$a0, newline			# load char
  syscall				# print char
  beq	$t6, $s1, exit			# condition to break loop
  add	$t5, $0, $0			# set counter to 0
  j converge				# looping mechanism
  		
  
  
  
   
##################################################################################
##   Insert code here for printing the normalized data. 			##
##   Separate each number with a space character.                               ##
##   You can adapt your ex2 printing for this part.				##
##################################################################################

# Exit from the program
exit:
  ori $v0, $0, 10       		# system call code 10 for exit
  syscall               		# exit the program
