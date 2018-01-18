#---------------------------------------
# Calculate days asm file for Lab 2 (ISA)
#---------------------------------------

# set the address where you want this
# code segment
  org 0x0000

	##initialize stack to address 0xFFFC
	ori $29, $0, 0xFFFC

	##Days = CurrentDay + (30*(CurrentMonth-1)) + 365*(CurrentYear-2000)
	## $11 will be Days (the final answer)
	## $12 will be CurrentDay
	## $13 will be CurrentMonth
	## $14 will be CurrentYear
	ori $12, $0, 6
	ori $13, $0, 1
	ori $14, $0, 2018
	
	## $13 will be [CurrentMonth - 1] -> MonthDiff
	## $14 will be [CurrentYear - 2000] -> YearDiff
	addi $13, $13, -1
	addi $14, $14, -2000

	##initialize the values in the stack by pushing MonthDiff($13) and 30
	ori $28, $0, 30
	push $28
	push $13
	jal MULT	##calls to mult function, #31 stores the return address, use jr $31 to return
	pop $13 ##$13 is now (30*(CurrentMonth-1))
	
	##second multiplication
	ori $28, $0, 365
	push $28
	push $14
	jal MULT
	pop $14 ##$14 is now (365*(CurrentYear - 2000))
	
	##calculate days and store address at $11
	add $11, $13, $14
	add $11, $11, $12
	push $11
	j ENDPROGRAM

## $6 is SLT status: 1 for less than, 0 for more than or equal
## $7 is temp
## $8 is first multiplicant
## $9 is second multiplicant
## $10 is the product

MULT:
	##store first operand in register by popping from stack
	pop $8
	##store second operand in register by popping from stack
	pop $9
	##store 0 in a temporary register, this will be used as a counter for the loop
	ori $7, $0, 0
	##store value of 0 in $10
	ori $10, $0, 0

	##start for loop, if temp is not less than multiplicant B, then exit loop
TEST:
	slt $6, $7, $9
	beq $6, $0, EXIT

LOOP:
	##add value from first multiplicant
	addu $10, $10, $8
	addi $7, $7, 1
	j TEST

	##exit, push result on stack
EXIT:
	push $10
	jr $31 #return using the stored return address at $31

ENDPROGRAM:

	halt
