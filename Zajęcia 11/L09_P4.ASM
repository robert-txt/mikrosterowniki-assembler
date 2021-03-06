;************************************************
;LEKCJA   9	- WY�WIETLACZ ALFANUMERYCZNY LCD
;PRZYK�AD 4	- ANIMACJA
;************************************************

	LJMP	START
	ORG	100H
START:

	MOV	R0,#LCDWC	;adres wpisu instrukcji
	MOV	R1,#LCDRC	;adres odczytu stanu

	MOV	A,#1		;kasuj dane wy�wietlacza
	LCALL	WRITE

	MOV	A,#0FH		;w��cz wy�wietlacz,kursor
	LCALL	WRITE		;i mruganie kursora

	INC	R0		;adres wpisu danych
	MOV	DPTR,#TEXT	;adres tekstu

WRITE_TXT:
	CLR	A		;pobranie kolejnego
	MOVC	A,@A+DPTR	;znaku tekstu
	JZ	TEXT_END	;bajt=0 - koniec tekstu

	ACALL	WRITE		;wpisanie na wy�wietlacz
	INC	DPTR		;modyfikacja adresu
				;pobrania kolejnego znaku
	SJMP	WRITE_TXT	;pobierz kolejny znak

TEXT_END:
	DEC	R0		;adres wpisu instrukcji

LOOP:				;p�tla animacji
	MOV	A,#4
	LCALL	DELAY_100MS	;co 0.4 sek
	
	MOV	A,#00011100B	;obr�t danych w lewo
	LCALL	WRITE		;na wy�wietlaczu LCD

	SJMP	LOOP

;**************************************
;Podprogram wpisu danych lub instrukcji
;na wy�wietlacz LCD
;Zak�ada prawid�owe adresy w R0 i R1

WRITE:
	MOV	R2,A		;przechowanie danych
BUSY:
	MOVX	A,@R1		;odczytanie stanu
	JB	ACC.7,BUSY	;oczekiwanie na BUSY=0
	MOV	A,R2		;odtworzenie danych
	MOVX	@R0,A		;wys�anie danych
	RET

;**************************************
TEXT:
	DB	'ASIA ;>',0
