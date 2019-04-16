; display 1 digit hex to screen

data SEGMENT

  num db 08FH;
  n db 02h;
data ENDS


code SEGMENT
  assume cs: code, ds: data

; 1 digit to screen



start:
  mov ax, data;
  mov ds, ax;

  call hex_ascii;

  mov ah, 4ch;
  int 21h


; from global variable n without any mutation
hex_disp:
  push dx
  push cx
  push bx
  push ax

  mov dl, n
  cmp n, 0AH;
  jc add30
  add dl, 07h;
  add30:
  add dl, 30h;

  ; disp dl
  mov ah, 02h;
  int 21h;

  pop ax
  pop bx
  pop cx
  pop dx
ret

  ; 2 digit DB to screen TAKEN FROM NUM
hex_ascii:
push dx
push cx
push bx
push ax



    mov ah, 0
    mov al, num
    mov bl, 10h;
    div bl;
    ; divide by 10H to get the last digit
    ; R Q
    ; displ Q first
    mov n, al
    call hex_disp

    mov n, ah
    call hex_disp

    pop ax
    pop bx
    pop cx
    pop dx
ret




code ends
end start
