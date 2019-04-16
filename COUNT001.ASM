data segment
  num db 00
  n db 00
  carriage db 13, '$'
  n_input db 00h
  keypress db 00h;

data ends
code segment
  assume cs: code, ds: data;
start:
  mov ax, data;
  mov ds, ax;

  mov bl, 01h;

  mov cx, 10h;
  back:

    lea dx, carriage
    mov ah, 09;
    ;push ax
    int 21h; apparantly in some sys al changes to 24
    ;pop ax
    call hex_ascii
    call delay
    push ax


    mov ah, 08;
    int 21h

    cmp al, 'D'
    jnz skip1
    dec num
    loop back
    skip1:
    inc num

  loop back

  mov ah, 4ch;
  int 21h;m


delay:
  mov si, 0FFh
  bk1:
    mov di, 0FFfh;
    bk2:
      dec di
      jnz bk2
    dec si
    jnz bk1
  exit:
ret


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

; bl
asciibl_hex:
  push dx
  push cx
  push bx
  push ax

  cmp bl, 40h
  jc sub30h
    sub bl, 07h
  sub30h:
  sub bl, 30h

  pop ax
  pop bx
  pop cx
  pop dx

ret





code ends
end start
