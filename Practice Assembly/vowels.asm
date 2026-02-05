org 100h

push cs
pop ds

mov ax, 0B800h
mov es, ax
xor di, di           

lea si, msgStored
call print_string

lea si, stored_string
call print_string

mov di, 160
lea si, msgCount
call print_string

xor cx, cx           
lea si, stored_string

next_char:
    lodsb
    cmp al, 0
    je done_count     

    cmp al, 'a'
    je is_vowel
    cmp al, 'e'
    je is_vowel
    cmp al, 'i'
    je is_vowel
    cmp al, 'o'
    je is_vowel
    cmp al, 'u'
    je is_vowel
    jmp next_char

is_vowel:
    inc cx
    jmp next_char

done_count:
    ; ---- Convert CX to 2-digit ASCII ----
    mov ax, cx        ; put count in AX
    aam               ; AH = tens, AL = ones
    add ax, 3030h     ; convert to ASCII

    mov es:[di], ah   ; print tens digit
    add di, 2
    mov es:[di], al   ; print ones digit
    add di, 2

    lea si, msgVowels
    call print_string

ret

; ===== Subroutine: print string =====
print_string:
    lodsb
    cmp al, 0
    je ps_done
    mov es:[di], al
    add di, 2
    jmp print_string
ps_done:
    ret

; ===== Data =====
msgStored     db "Stored string = ",0
stored_string db "john enrico desalago lauron",0
msgCount      db "String contains ",0
msgVowels     db " vowels!",0
