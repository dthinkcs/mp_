DATA SEGMENT
        PROMPT DB 'ENTER STRING: ', 10, 13, '$'

        max_len db 20
        actlen db ?
        str db 20 dup('$')

        NXTLINE DB 10, 13, '$'
DATA ENDS

CODE SEGMENT
        ASSUME CS: CODE, DS: DATA
DISP_STR MACRO MSG
        PUSH DX

        LEA DX, MSG
        MOV AH, 09
        INT 21H

        POP DX
ENDM

DISP_DL MACRO

        MOV AH, 02H
        INT 21H

ENDM

INPUT_AL MACRO

        MOV AH, 01
        INT 21H

ENDM

INPUT_STR MACRO MAX_LEN

        PUSH DX

        LEA DX, MAX_LEN
        MOV AH, 0AH
        INT 21H


        POP DX

ENDM





START:

        MOV AX, DATA
        MOV DS, AX


        DISP_STR PROMPT

        ; take input from user into str
        INPUT_STR MAX_LEN
        ; must print a new line
        DISP_STR NXTLINE
        ; display str
        DISP_STR STR

        ; BUG WAS HERE always DISP_STR NXTLINE
        DISP_STR NXTLINE

        mov dl, 30h;
        DISP_DL
      ;  mov ah, 02h;
      ;  int 21h;

        mov dl, 30h;
        DISP_DL
      ;  mov ah, 02h;
      ;  int 21h;

        mov dl, 37h;

        DISP_DL
      ;  mov ah, 02h;
      ;  int 21h;

        MOV AH, 4CH
        INT 21H

CODE ENDS
END START
