	LJMP	START
	ORG	100H

START:
	LCALL LCD_CLR

	CLR P1.7

	MOV A, #100	
	LCALL PRAWIEJAKDELAY
	
	SETB P1.7
	

STOP:
	SJMP	STOP

PRAWIEJAKDELAY:

	JZ L12
	
	
	MOV TMOD, #00000001B	;GATE 0, CZAS WEWNĘTRZNY, TRYB 1

	MOV TH0, #76
	MOV TL0, #0

LOOP2:
	MOV R1, #2

LOOP1:	
	SETB TR0
L11:	
	JNB TF0, L11
	CLR TR0
	CLR TF0
	MOV TH0, #76

	DJNZ R1, LOOP1
	
	DJNZ ACC, LOOP2

L12:
	RET