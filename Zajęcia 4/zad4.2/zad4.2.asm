MEM	EQU	100
;--------------------------------------
	LJMP	START
	ORG	100H
START:


	LCALL	LCD_CLR

	MOV	R0,#MEM

L1:
	LCALL	WAIT_KEY
	JZ	L1
	CJNE	A,#10,L2
L2:
	JNC	L1

	MOV	DPTR,#CENY
	LCALL	POBIERZ_DANE
	MOV	R5,A
	MOV	MEM,A
	MOV	MEM+1,#0
	LCALL	HEX_BCD
	MOV	A,@R0
	LCALL	WRITE_HEX

	MOV	A,#'|'
	LCALL	WRITE_DATA

	MOV	R1,#1
	MOV	DPTR,#MONETY
	MOV	MEM,#0
	MOV	MEM+1,#0

LOOP1:	

	MOV	A,R1
	LCALL	POBIERZ_DANE
	MOV	R2,A
L3:	
	LCALL	WAIT_KEY
	MOV	R3,A
	CJNE	A,#10,L4
L4:
	JNC	L3
	ADD	A,#'0'
	LCALL	WRITE_DATA
	
	MOV	A,R2
	MOV	B,R3
	MUL	AB

	ADD	A,@R0
	MOV	@R0,A
	MOV	A,B
	INC	R0
	ADDC	A,@R0
	MOV	@R0,A
	DEC	R0

	INC	R1
	CJNE	R1,#7,LOOP1


	MOV	A,#'|'
	LCALL	WRITE_DATA



	CLR	C
	MOV	A,@R0
	SUBB	A,R5
	MOV	@R0,A
	INC	R0
	MOV	A,@R0
	SUBB	A,#0
	MOV	@R0,A
	DEC	R0


	LCALL	HEX_BCD
	INC	R0
	MOV	A,@R0
	LCALL	WRITE_HEX
	DEC	R0
	MOV	A,@R0
	LCALL	WRITE_HEX

	MOV	A,#'|'
	LCALL	WRITE_DATA
	MOV	A,#' '
	LCALL	WRITE_DATA

	LCALL	BCD_HEX



	MOV B,#50
	LCALL	DIV_2_1
	MOV R6, A
	MOV A,@R0
	LCALL WRITE_HEX
	MOV DPTR,#MONETY
	MOV R1, #2

LOOP2:	
	MOV A, R1
	LCALL POBIERZ_DANE
	MOV B, A
	MOV A, R6
	DIV AB
	MOV R6, B
	LCALL WRITE_HEX
	INC R1
	CJNE R1, #7, LOOP2
	
		

STOP:
	SJMP	STOP


;----------------------------------

CENY:
	DB	23, 21, 11, 16, 16, 18, 12, 33, 36, 28

MONETY:	DB	50, 20, 10, 5, 2, 1

;----------------------------------


POBIERZ_DANE:
	DEC	A
	MOVC	A,@A+DPTR
	RET

;----------------------------------

