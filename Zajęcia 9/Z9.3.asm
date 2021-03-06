	LJMP	START
	ORG	100H

START:
	LCALL LCD_CLR

	MOV SCON, #3*64+0*16
	ORL PCON, #80H
	MOV TMOD, #(0+0*4+0*8)+(2+0*4+0*8)*16
	MOV TH1, #256-192
	MOV TL1, #256-192
	SETB TR1
	
	SETB TI
	LCALL LCD_CLR
	
LOOP:
	LCALL WAIT_KEY
	JNB TI, $
	CLR TI
	ADD A, #CSDS
	MOV SBUF, A
	LCALL WRITE_DATA
		
	SJMP	LOOP


