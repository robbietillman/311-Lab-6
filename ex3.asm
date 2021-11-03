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
  addi	$t7, $0, 0
  addi	$t8, $0, 0
  addi $t9, $0, 20			# temp
   
   
##################################################################################
##   Insert code here for performing normalization of data                      ##
##################################################################################
   
setRange:

  add	$t7, $s1, $0
  sub	$t7, $t7, $s0
  add	$t8, $t9, $0
  div	$t7, $t7, $t8
  lw	$t1, array($t4)
  sub	$t1, $t1, $t9
  mul	$t1, $t7, $t1
  add	$t1, $t1, $s0
  sw	$t1, array($t4)
  
  
  
   
##################################################################################
##   Insert code here for printing the normalized data. 			##
##   Separate each number with a space character.                               ##
##   You can adapt your ex2 printing for this part.				##
##################################################################################

# Exit from the program
exit:
  ori $v0, $0, 10       		# system call code 10 for exit
  syscall               		# exit the program
