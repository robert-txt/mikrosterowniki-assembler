
	LJMP	START
	ORG	100H

START:

	LCALL LCD_CLR
	MOV A, #00111111B
	MOV R0, #CSDS
	MOVX @R0, A

LOOP:	
	MOV C, P3.5
	CPL C
	MOV P1.7, C 

	SJMP	LOOP