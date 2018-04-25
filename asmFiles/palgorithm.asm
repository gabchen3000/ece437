#------------------------------------------
# palgorithm by Gabriel Chen and Deeptanshu Malik
#------------------------------------------
#being used: a0, a1, t0-4, v0, v1
#available to me: 
#REGISTERS
#at $1 at
#v $2-3 function returns
#a $4-7 function args
#t $8-15 temps
#s $16-23 saved temps (callee preserved)
#t $24-25 temps
#k $26-27 kernel
#gp $28 gp (callee preserved)
#sp $29 sp (callee preserved)
#fp $30 fp (callee preserved)
#ra $31 return address
#----------------------------------------------------------
# First Processor
#----------------------------------------------------------
  org   0x0000              # first processor p0
  ori   $sp, $zero, 0x3ffc  # stack
  ori   $s5, $zero, 0   # count of words generated
  ori   $s6, $zero, 0   # count of stack elems
  ori   $s4, $zero, 0      # sum
	ori   $k0, $zero, 5      # seed
  ori   $s1, $zero, 0
  ori   $s2, $zero, 0
  ori   $s3, $zero, 0
  jal   mainp0              # go to program
  halt

# pass in an address to lock function in argument register 0
# returns when lock is available
lock:
aquire:
  ll    $t0, 0($a0)         # load lock location
  bne   $t0, $0, aquire     # wait on lock to be open
  addiu $t0, $t0, 1
  sc    $t0, 0($a0)
  beq   $t0, $0, lock       # if sc failed retry
  jr    $ra

# pass in an address to unlock function in argument register 0
# returns when lock is free
unlock:
  sw    $0, 0($a0)
  jr    $ra

mainp0:
    push $ra

    generate:
    
		# generate a random number
		or $a0, $zero, $k0    
		jal crc32
    or $k0, $zero, $v0

    # update running sum
		addu $s4, $s4, $k0
    # update generate number counter
    addiu $s5, $s5, 1
    # update stack counter
    addiu $s6, $s6, 1
		
		addiu $s3, $zero, 1
		ori $t0, $zero, 1
		beq $s3, $t0, not_one
		or $28, $zero, $k0
		or $29, $zero, $k0

		not_one:

		##################
    # CRITICAL BEGIN
		##################
		# push generated number to stack
		ori $a0, $zero, ll1
    jal lock

		push $k0

		ori $a0, $zero, ll1
    jal unlock 
    
		##################
    # CRITICAL END
		##################
    
    # if counter is equal to 10 (A) then flush stack
    check1:
		ori $t0, $zero, 10
    bne $s6, $t0, check2

		##################
    # CRITICAL BEGIN
		##################
		ori $a0, $zero, ll1
    jal lock
    pop $sp
    pop $sp
    pop $sp
    pop $sp
    pop $sp
    pop $sp
    pop $sp
    pop $sp
    pop $sp
    pop $sp
		ori $a0, $zero, ll1
    jal unlock 
		##################
    # CRITICAL END
		##################
    
		#reset stack element counter
   	or $s6, $zero, $zero  

    # if generate number counter is less than 256 then jump to generate number
    check2:
		ori $t0, $zero, 256  
    bne $s5, $t0, generate

		#calculate average  
	  or $a0, $zero, $s4
		ori $a1, $zero, 256 
    jal divide
		or $s0, $zero, $v0    # store avg in s16

		pop $ra
		jr $ra

    ll1:
    cfw 0x0
    
#----------------------------------------------------------
# Second Processor
#----------------------------------------------------------
  org   0x200               # second processor p1
  jal   mainp1              # go to program
  halt

mainp1:
     ori $a0, $zero, ll1 #31 -> halt
     jal lock						 #31 -> pop
     pop $s7
		 ori $a0, $zero, ll1
 	   jal unlock
		 
     or $a0, $zero, $28
		 or $a1, $zero, $s7 
     jal min
		 or $28, $zero, $v0   # store avg in s17
     or $a0, $zero, $29
		 or $a1, $zero, $s7 
  	 jal max							# 31 -> or
     or $29, $zero, $v0   # store avg in s18

     jr $ra
#----------------------------------------------------------
# copied and pasted subroutines
#----------------------------------------------------------
crc32:
  lui $t1, 0x04C1
  ori $t1, $t1, 0x1DB7
  or $t2, $0, $0
  ori $t3, $0, 32

l1:
  slt $t4, $t2, $t3
  beq $t4, $zero, l2

  srl $t4, $a0, 31
  sll $a0, $a0, 1
  beq $t4, $0, l3
  xor $a0, $a0, $t1
l3:
  addiu $t2, $t2, 1
  j l1
l2:
  or $v0, $a0, $0
  jr $ra

divide:               # setup frame
  push  $ra           # saved return address
  push  $a0           # saved register
  push  $a1           # saved register
  or    $v0, $0, $0   # Quotient v0=0
  or    $v1, $0, $a0  # Remainder t2=N=a0
  beq   $0, $a1, divrtn # test zero D
  slt   $t0, $a1, $0  # test neg D
  bne   $t0, $0, divdneg
  slt   $t0, $a0, $0  # test neg N
  bne   $t0, $0, divnneg
divloop:
  slt   $t0, $v1, $a1 # while R >= D
  bne   $t0, $0, divrtn
  addiu $v0, $v0, 1   # Q = Q + 1
  subu  $v1, $v1, $a1 # R = R - D
  j     divloop
divnneg:
  subu  $a0, $0, $a0  # negate N
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
  beq   $v1, $0, divrtn
  addiu $v0, $v0, -1  # return -Q-1
  j     divrtn
divdneg:
  subu  $a0, $0, $a1  # negate D
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
divrtn:
  pop $a1
  pop $a0
  pop $ra
  jr  $ra

#-max (a0=a,a1=b) returns v0=max(a,b)--------------
max:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a0, $a1
  beq   $t0, $0, maxrtn
  or    $v0, $0, $a1
maxrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------

#-min (a0=a,a1=b) returns v0=min(a,b)--------------
min:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a1, $a0
  beq   $t0, $0, minrtn
  or    $v0, $0, $a1
minrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------




