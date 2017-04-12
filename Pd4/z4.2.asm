	LJMP	START
	ORG	100H
START:
	LCALL	LCD_CLR
	MOV	A, #111
	MOV	B, #16 
	DIV	AB	;dzielenie przez 16
	CLR	C	
	MOV	A,B	
	JNZ	STOP	;jeœli reszta jest ró¿na od 0 to koniec
	SETB	C	;jeœli równa 0 to ustaw bit C
STOP:
	SJMP	STOP