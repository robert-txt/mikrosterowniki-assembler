	LJMP START

	ORG 100H

START:	

	LCALL LCD_CLR

	MOV DPTR, #TXT

	LCALL WRITE_TEXT


STOP:

	SJMP STOP

TXT:

	DB 'DZIEN DOBRY', 0