	org 0x0000

	j PROG

	MMM:
	sub $1,$0,$0
	sub $1,$0,$0
	sub $1,$0,$0
	sub $1,$0,$0
	sub $1,$0,$0
	jr $31

PROG:
	jal MMM

	HALT
