	LJMP	START
	ORG	100H
START:
	LCALL	WAIT_KEY	;POBIERZ KOD 1 KLAWISZA
	MOV	R0,A		;ZAPISZ KOD W R0
	LCALL	WAIT_KEY	;POBIERZ KOD 2 KLAWISZA
	MOV	R1,A		;ZAPISZ KOD W R1
	LCALL	WAIT_KEY	;POBIERZ KOD 3 KLAWISZA
	CJNE	R0,R1,L1	;POR�WNAJ KODY KLAWISZY 1 z 2, JE�LI 2 JEST WI�KSZY USTAW C=1, JE�LI NIE C=0, PO USTAWIENIU KONTYNUUJ
L1:
	JC	L2		;JE�LI KOD 2 BY� WI�KSZY TO SKOCZ DO L2, JE�LI NIE TO KONTYNUUJ
	CJNE	R0,A,L5		;POR�WNAJ KODY KLAWISZY 1 z 3, JE�LI 3 JEST WI�KSZY USTAW C=1, JE�LI NIE C=0, PO USTAWIENIU KONTYNUUJ

L5:
	JC	L4		;JE�LI KOD 3 BY� WI�KSZY TO SKOCZ DO L4, JE�LI NIE TO KONTYNUUJ
	MOV	R3,#1		;KOD 1 BY� NAJWI�KSZY ZATEM USTAW R3=1
	SJMP	L6		;SKOCZ DO L6

L2:
	CJNE	R1,A,L3		;POR�WNAJ KODY KLAWISZY 2 z 3, JE�LI 3 JEST WI�KSZY USTAW C=1, JE�LI NIE C=0, PO USTAWIENIU KONTYNUUJ

L3:
	JC	L4		;JE�LI KOD 3 BY� WI�KSZY TO SKOCZ DO L4, JE�LI NIE KONTYNUUJ
	MOV	R3,#2		;KOD 2 BY� NAJWI�KSZY ZATEM USTAW R3=2
	SJMP	L6		;SKOCZ DO L6

L4:
	MOV	R3,#3		;KOD 3 BY� NAJWI�KSZY ZATEM USTAW R3=3

L6:
	CPL	P1.7		;ZAPAL DIODE
	MOV	A,#10		;CZEKAJ
	LCALL	DELAY_100MS	;WCI��
	CPL	P1.7		;ZGA� DIOD�
	MOV	A,#10		;CZEKAJ
	LCALL	DELAY_100MS	;WCI��
	DEC	R3		;ZMNIEJSZ WARTO�� R3
	CJNE	R3,#0,L6	;JE�LI S� R�WNE KONTYNUUJ, JE�LI NIE P�TLA WYWO�A SAM� SIEBIE
	SJMP	START		;POWR�T DO POCZ�TKU

