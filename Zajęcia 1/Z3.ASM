	LJMP START

	ORG 100H

START:	

	LCALL WAIT_KEY

	MOV B,A

	LCALL WAIT_KEY

	CLR P1.7

	CJNE A, B, L3 ;która liczba wiêksza

L3:	

	JC L1

	MOV A,#10

	SJMP L2

L1:	

	MOV A,#1

L2:

	LCALL DELAY_100MS

	SETB P1.7

	SJMP START