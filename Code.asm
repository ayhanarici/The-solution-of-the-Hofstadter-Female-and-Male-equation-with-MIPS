####################################################################
# In this MIPS example,                                           #
# the solution of the Hofstadter Female and Male equation is done. #
# Codes were written by Ayhan ARICI.                               #
####################################################################
.data
	newline: .asciiz "\n" 	#String values are defined.
	FString: .asciiz "The first few terms of the  \"Female\" sequence: "
	MString: .asciiz "The first few terms of the  \"Male\" sequence  : "
.text
	addi $v0, $zero, 4    	#Print string syscall
    	la $a0, FString       	#Load address of the Female string
    	syscall               	#Printing to the screen has been done  
	addi $s5,$0,0         	#$s5 and $s6 addresses are setted for loops
	addi $s6,$0,20 
	
ForI:                         	#The beginning of the I loop 
	beq $s5,$s6,EndI      	#If $s5 equals $s6, go to the end of the I loop	
	move $a0,$s5	      	#$s5 value transferred to $a0
	jal FunctionF         	#FunctionM function is called
	move $t0, $v0         	#$v0 value transferred to $t0
	li $v0,1              	#$v0 is set for printing integer value
	move $a0, $t0	      	#$t0 value transferred to $a0
	syscall               	#Printing to the screen has been done
	addi $s5,$s5,1        	#$s5 value increased by 1
	jal ForI              	#Go to the beginning of loop I
EndI:                         	#End of I loop

	addi $v0, $zero, 4    	#Print string syscall
    	la $a0, newline       	#Load address of the newline string
    	syscall               	#Printing to the screen has been done  
    	la $a0, MString       	#Load address of the Male string
    	syscall               	#Printing to the screen has been done
	addi $s5,$0,0         	#The initial values ??of $s5 and $s6 are reassigned
	addi $s6,$0,20
ForJ:			      	#The beginning of the J loop	
	beq $s5,$s6,EndJ      	#If $s5 equals $s6, go to the end of the J loop	
	move $a0,$s5          	#$s5 value transferred to $a0
	jal FunctionM         	#FunctionF function is called
	move $t0, $v0         	#$v0 value transferred to $t0
	li $v0,1              	#$v0 is set for printing integer value
	move $a0, $t0         	#$t0 value transferred to $a0
	syscall               	#Printing to the screen has been done
	addi $s5,$s5,1        	#$s5 value increased by 1
	jal ForJ              	#Go to the beginning of loop J
EndJ:                         	#End of J loop
	li $v0,10             	#Value of 10 is assigned to $v0 for end the program
	syscall	              	#End of this program
#-------------------------------------------------------------------------------------
FunctionF:			#The beginning of the FunctionF function
    addi    $sp, $sp, -8	#Adjust stack pointer to store return address and argument.
    sw      $s0, 4($sp)		#Save $s0
    sw      $ra, 0($sp)		#Save $ra
    bne     $a0, 0, Else1	#If $a0 is not equal 0 go to Else1
    addi    $v0, $0, 1 		#Set $v0 to 1  
    jal FunctionFReturn         #Go to FunctionFReturn address
Else1:
    move    $s0, $a0		#$a0 value transferred to $s0
    addi    $a0, $a0, -1 	#$a0 value decreased by 1
    jal     FunctionF		#The FunctionF function was called as recursive
    move    $a0,$v0		#$v0 value transferred to $a0
    jal     FunctionM		#The FunctionM function was called
    sub     $v0,$s0,$v0		#$v0 subtracted from $s0 and transferred to $v0
FunctionFReturn:		#Return of the FunctionF function
    lw      $s0, 4($sp)		#Load $s0
    lw      $ra, 0($sp)		#Load $ra
    addi    $sp, $sp, 8		#Restore stack pointer
    jr      $ra			#Return to $ra address
#-------------------------------------------------------------------------------------
FunctionM:			#The beginning of the FunctionM function
    addi    $sp, $sp, -8	#Adjust stack pointer to store return address and argument.
    sw      $s0, 4($sp)		#Save $s0
    sw      $ra, 0($sp)		#Save $ra
    bne     $a0, 0, Else2	#If $a0 is not equal 0 go to Else2
    addi    $v0, $0, 0   	#Set $v0 to 0
    jal FunctionMReturn		#Go to FunctionFReturn address
Else2:
    move    $s0, $a0		#$a0 value transferred to $s0
    addi    $a0, $a0, -1 	#$a0 value decreased by 1
    jal     FunctionM		#The FunctionM function was called as recursive
    move    $a0,$v0		#$v0 value transferred to $a0
    jal     FunctionF		#The FunctionF function was called
    sub     $v0,$s0,$v0		#$v0 subtracted from $s0 and transferred to $v0
FunctionMReturn:		#Return of the FunctionM function
    lw      $s0, 4($sp)		#Load $s0
    lw      $ra, 0($sp)		#Load $ra
    addi    $sp, $sp, 8		#Restore stack pointer
    jr      $ra			#Return to $ra address
#-------------------------------------------------------------------------------------
