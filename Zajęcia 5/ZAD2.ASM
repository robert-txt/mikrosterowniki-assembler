
	LJMP	START
	ORG	100H

START:
	LCALL LCD_CLR
	LCALL SKANUJ
	JZ START
	LCALL WRITE_HEX

STOP:
	SJMP	STOP

SKANUJ:

	MOV R0, #CSDS

	MOV R1, #00000001B
	MOV R2, #00000000B
	MOV R3, #6
	

LOOP:	MOV A, R1
	MOVX @R0, A
	JNB P3.5, L1
	ORL A, R2
	MOV R2, A

L1:	MOV A, R1
	RL A
	MOV R1, A
	
	DJNZ R3, LOOP
	MOV A, R2
	RET