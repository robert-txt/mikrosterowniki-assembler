LJMP START

	ORG 100H

START:	

	LCALL LCD_CLR

	mov A, #10110110B

	MOV B, A

	MOV R1, #8

LOOP:

	MOV A, B

	RLC A

	MOV B, A

	JC L1

	MOV A, #'0'

	SJMP L2

L1:

	MOV A, #'1'

L2:

	LCALL WRITE_DATA

	DJNZ R1, LOOP

STOP:

	SJMP STOP