STA SEGMENT STACK
	DB 100H DUP(0)
STA ENDS
CODE SEGMENT 
	ASSUME CS:CODE,DS:CODE,SS:STA
MAIN:
	MOV AX,CODE
	MOV DS,AX
	MOV DH,0;LINE UP TO 24
	MOV DL,0;COLUMN UP TO 79
	MOV BH,0
	MOV CX,0
	MOV AH,2
	INT 10H
	MOV DL,'O'
	INT 21H
	MOV DL,0
	MOV AL,50H
	WAITING_:
	MOV BL,0FFFFH
	WAITING:
		DEC BL
	JNZ WAITING
	DEC AL
	JNZ WAITING_
	MOV AH,2
	INT 10H
	MOV BL,DL
	MOV DL,' '
	INT 21H
	MOV DL,BL
	RUN:
		CMP CL,0
		JNE NEXT
		INC DL
		JMP NEXT2
		NEXT:
		DEC DL
		NEXT2:
		CMP CH,0
		JNE NEXT3
		INC DH
		JMP NEXT4
		NEXT3:
		DEC DH
		NEXT4:
		MOV AH,2
		INT 10H
		MOV BL,DL
		MOV DL,'O'
		INT 21H
		MOV DL,BL
		MOV AL,50H
		WAITING2_:
		MOV BL,0FFFFH
		WAITING2:
			DEC BL
		JNZ WAITING2
		DEC AL
		JNZ WAITING2_
		MOV BL,DL
		MOV AH,2
		INT 10H
		MOV DL,' '
		INT 21H
		MOV DL,BL
		CMP DL,79
		JNE NEXT5
		MOV CL,1
		NEXT5:
		CMP DH,24
		JNE NEXT6
		MOV CH,1
		NEXT6:
		CMP DL,0
		JNE NEXT7
		MOV CL,0
		NEXT7:
		CMP DH,0
		JNE NEXT8
		MOV CH,0
		NEXT8:
		MOV AH,0BH
		INT 21H
		CMP AL,0FFH
		JNE RUN
	MOV AX,4C00H
	INT 21H
CODE ENDS
END MAIN