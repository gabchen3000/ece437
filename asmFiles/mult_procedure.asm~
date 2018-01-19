#---------------------------------------
# multiply procedure asm file for Lab 2 (ISA)
#---------------------------------------

# set the address where you want this
# code segment
  org 0x0000

	##initialize stack to address 0xFFFC
	ori $29, $0, 0xFFFC
	##initialize the values in the stack by pushing
	ori $28, $0, 9
	ori $27, $0, 9
	push $28
	push $27
	ori $28, $0, 2
	ori $27, $0, 4
	push $28
	push $27
	ori $28, $0, 2
	ori $27, $0, 1
	push $28
	push $27
	## $11 will hold the stack location of the first operand, and will know when to stop the loop
	ori $11, $0, 0xFFF8

MULT_PROC:
	beq $11, $29, EXIT

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
	beq $6, $0, EXIT_LOOP

LOOP:
	##add value from first multiplicant
	addu $10, $10, $8
	addi $7, $7, 1
	j TEST

	##exit, push result on stack
EXIT_LOOP:
	push $10
	j MULT_PROC

EXIT:

	halt
