;************************************************
;LEKCJA   9	- WYŒWIETLACZ ALFANUMERYCZNY LCD
;PRZYK£AD 3	- DEFINIOWANIE ZNAKU
;************************************************

	LJMP	START
	ORG	100H
START:

	MOV	R0,#LCDWC	;adres wpisu instrukcji
	MOV	R1,#LCDRC	;adres odczytu stanu

	MOV	A,#48H		;ustaw adres generatora
	LCALL	WRITE		;znaków dla znaku 1


	INC	R0		;adres wpisu danych
	MOV	DPTR,#LITERA ;adres definicji litery
	MOV	R3,#8		;licznik bajtów definicji

	
LOOP:				;wpisz definicjê litery
				;do generatora znaków LCD
	CLR	A
	MOVC	A,@A+DPTR	;odczyt kolejnego bajtu
	LCALL	WRITE		;zapis do generatora zn.
	INC	DPTR		;modyfikacja adresu
	DJNZ	R3,LOOP		;przepisanie 8 bajtów

	DEC	R0		;adres wpisu instrukcji

	MOV	A,#1		;kasuj dane wyœwietlacza
	LCALL	WRITE

	MOV	A,#0FH		;w³¹cz wyœwietlacz,kursor
	LCALL	WRITE		;i mruganie kursora

	MOV	A,#06H		;ustaw kierunek przesuwu
	LCALL	WRITE		;kursora

	INC	R0		;adres wpisu danych
	MOV	DPTR,#TEXT	;adres tekstu do
				;wyœwietlenia na LCD

	MOV	A,#50H		;ustaw adres generatora
	LCALL	WRITE

	INC	R0		;adres wpisu danych
	MOV	DPTR,#LITERA2 ;adres definicji litery
	MOV	R3,#8

LOOP2:				;wpisz definicjê litery
				;do generatora znaków LCD
	CLR	A
	MOVC	A,@A+DPTR	;odczyt kolejnego bajtu
	LCALL	WRITE		;zapis do generatora zn.
	INC	DPTR		;modyfikacja adresu
	DJNZ	R3,LOOP2		;przepisanie 8 bajtów

	DEC	R0		;adres wpisu instrukcji

	MOV	A,#1		;kasuj dane wyœwietlacza
	LCALL	WRITE

	MOV	A,#0FH		;w³¹cz wyœwietlacz,kursor
	LCALL	WRITE		;i mruganie kursora

	MOV	A,#06H		;ustaw kierunek przesuwu
	LCALL	WRITE		;kursora

	INC	R0		;adres wpisu danych
	MOV	DPTR,#TEXT	;adres tekstu do
				;wyœwietlenia na LCD



WRITE_TXT:			;wpisz tekst na LCD
	CLR	A
	MOVC	A,@A+DPTR	;pobranie znaku tekstu
	JZ	TEXT_END	;bajt=0 - koniec tekstu
	LCALL	WRITE		;wpis na wyœwietlacz
	INC	DPTR		;modyfikacja adresu
	SJMP	WRITE_TXT	;wpisz kolejny znak

TEXT_END:
	SJMP	$		;koniec programu

;**************************************
;Podprogram wpisu danych lub instrukcji
;na wyœwietlacz LCD
;Zak³ada prawid³owe adresy w R0 i R1

WRITE:
	MOV	R2,A		;przechowanie danych
BUSY:
	MOVX	A,@R1		;odczytanie stanu
	JB	ACC.7,BUSY	;oczekiwanie na BUSY=0
	MOV	A,R2		;odtworzenie danych
	MOVX	@R0,A		;wys³anie danych
	RET

;**************************************
;Tabela bajtów definiuj¹cych literê 'ñ'
LITERA:
	DB	00011111B
	DB	00011000B
	DB	00011111B
	DB	00011111B
	DB	00011000B
	DB	00011111B
	DB	00011111B
	DB	00000000B

LITERA2:
	DB	00000100B
	DB	00000100B
	DB	00011111B
	DB	00000100B
	DB	00000100B
	DB	00000100B
	DB	00000000B
	DB	00000000B

;**************************************
TEXT:
	DB	'Gdansk  '
	DB	1,2,0

