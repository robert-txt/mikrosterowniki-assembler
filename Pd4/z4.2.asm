	LJMP	START
	ORG	100H
START:
	LCALL	LCD_CLR
	MOV	A, #111
	MOV	B, #16 
	DIV	AB	;dzielenie przez 16
	CLR	C	
	MOV	A,B	
	JNZ	STOP	;je�li reszta jest r�na od 0 to koniec
	SETB	C	;je�li r�wna 0 to ustaw bit C
STOP:
	SJMP	STOP