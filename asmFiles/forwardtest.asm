
  #------------------------------------------------------------------
  # Lecture notes program
  #------------------------------------------------------------------

  org 0x0000
  ori   $1,$zero,0xD269
  ori   $2,$zero,0x37F1

  ori   $21,$zero,0x80
  ori   $1,$zero,31
  ori   $2,$zero,23
  ori   $3,$zero,23
  ori   $4,$zero,12
  ori   $5,$zero,55

  sub $2, $1, $3
  and $4, $2, $5
  #or  $4, $4, $2
  #add $9, $4, $2
# Store them to verify the results
  sw    $4,0($22)
  #sw    $3,0($21)
  #sw    $4,4($21)
  #sw    $5,8($21)
  #sw    $6,12($21)
  halt  # that's all
