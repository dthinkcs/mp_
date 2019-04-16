data SEGMENT
  n_facto dw 03
  ans db 00
  n db 00;
  num db 00;
data ENDS

code SEGMENT
  assume cs: code, ds: data
start:
  mov ax, data;
  mov ds, ax;

  call fact

  mov al, ans;
  mov num, al;

  call hex_ascii;

  mov ah, 4ch
  int 21H

; stack is there for function call play with glo;bal variables (PUSH POP any registers used)
; facto
fact:
  cmp n_facto, 00h
  jne skip
    mov ans, 01h;
    ret;

  skip:
  push n_facto; IMPORTANT before calling FACT with a different value of n
  dec n_facto;
  call fact
  mov al, ans;
  pop n_facto; IMPORTANT you need current value after fact returns
  mov bl, n_facto
  mul bl;
  mov ans, al
  ; n * fact(n - 1)
ret;

;from global variable n without any mutation
hex_disp:
  push dx

  mov dl, n
  cmp n, 0AH;
  jc add30
  add dl, 07h;
  add30:
  add dl, 30h;

  ; disp dl
  mov ah, 02h;
  int 21h;

  pop dx
ret

; 2 digit DB to screen TAKEN FROM @num
hex_ascii:

    mov ah, 0
    mov al, byte ptr num
    mov bl, 10h;
    div bl;
    ; divide by 10H to get the last digit
    ; R Q
    ; displ Q first
    mov n, al
    call hex_disp

    mov n, ah
    call hex_disp
ret


code ends
end start
