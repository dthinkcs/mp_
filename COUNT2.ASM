CODE SEGMENT
ASSUME CS:CODE
START: MOV BH,33H
BACK:
; Extract MS digit of count
 MOV BL, BH
 AND BL, 0F0H
; Convert to decimal value
 MOV CL,4
 ROR BL,CL
 ADD BL,30H
 MOV DL,BL
 CALL DISP

; Extract the LS digit and convert to decimal value
 MOV BL,BH
 AND BL,0FH
 ADD BL,30H
 MOV DL,BL
 CALL DISP
 MOV AL,BH
 ADD AL,01H
 DAA
 MOV BH,AL
; Provide delay to display the next count value
 CALL DELAY
; Set the cursor to starting location of the same line
 MOV DL,13 ; \r
 CALL DISP
 MOV DL,0FFH
 MOV AH,06
 INT 21H
 JNZ DOWN
UPP: JMP BACK
DOWN: CMP AL,13; for any key
 JNZ BACK
 MOV AH,4CH
 INT 21H
; Procedure to display the value
DISP PROC
 MOV AH,02
 INT 21H
 RET
DISP ENDP
; Delay function
DELAY PROC
MOV SI,0FFH
 UP1: MOV DI,0FFFH
 UP: DEC DI
 JNZ UP
 DEC SI
 JNZ UP1
 RET
DELAY ENDP
 CODE ENDS
 END START
