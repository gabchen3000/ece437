#--------------------------------------
# Test branch and jumps
#--------------------------------------
  org 0x0000
  ori   $1, $0, 0xBA5C
  beq   $0, $0, braZ
  sw    $1, 0($2)
braZ:
  halt
  jal   braR
	nop
  sw    $1, 4($2)
end:
  sw    $ra, 16($2)
  HALT
braR:
  or    $3, $zero, $ra
  sw    $ra, 8($2)
  jal   jmpR
	nop
  sw    $1, 12($2)
jmpR:
  bne   $ra, $3, end
nop
  halt
