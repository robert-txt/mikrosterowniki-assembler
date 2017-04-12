LJMP START

	ORG 100H

START:	

	LCALL LCD_CLR

	mov A, #10110110B

	MOV B, #11111100B

	ANL A, B

	MOV B, #00001100b

	XLR A, B

	MOV B, #00110000B

	ORL A, B

	LCALL WRITE_HEX

	MOV R1, #8

L1:

	RL

	JC L2

	MOV A. #'0'

	LCALL WRITE_DATA

	
L2:	
	
	MOV A, #'1'

	LCALL WRITE_DATA

	DJNZ R1, L1


STOP:

	SJMP STOP