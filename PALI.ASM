data segment
  str1 db 'zxyw$'
  str2 db 5 dup('$')

  yespal db 'yes! palindrome$'
  nopal db 'not palindrome$'
data ends


code segment
  assume cs: code, ds: data
start:
  mov ax, data
  mov ds, ax
  mov es, ax

  lea si, str1
  lea di, str2 + 3

  mov cx, 4
  back:
    cld
    lodsb
    std
    stosb
  loop back

  ; check if reverse and s
  ; ds
  ; si
  ; cx
  ; cld

  cld
  lea si, str1
  lea di, str2
  mov cx, 0004h
  repe cmpsb
  je yes
  lea dx, nopal
  mov ah, 09
  int 21h
  jmp exit
  yes:
  lea dx, yespal
  mov ah, 09
  int 21h



  exit:
  ; sort the strings
  mov ch, 03h;
  bkk:
    mov cl, 03;
    lea si, str1
    ckk:
      mov al, [si]
      mov ah, [si + 1]
      cmp al, ah
      jc skipp
        ; xchange
        mov [si], ah;
        mov [si + 1], al;
      skipp:
      inc si
      dec cl
      jnz ckk

  lea dx, str1
  mov ah, 09
  int 21h

  mov ah, 4ch
  int 21h

code ends
end start
