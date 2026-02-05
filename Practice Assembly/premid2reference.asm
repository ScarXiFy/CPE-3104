
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

; Program: X = A - (B * C) / D
; Input: A, B, C, D (2-digit values)
; Output: Inputs, equation, result in base 10 and base 5

org 100h
jmp start

; =======================
; DATA
; =======================
A       dw 0
B       dw 0
C       dw 0
D       dw 0
X       dw 0

msgA    db "Enter A (2-digit): $"
msgB    db 0Dh,0Ah,"Enter B (2-digit): $"
msgC    db 0Dh,0Ah,"Enter C (2-digit): $"
msgD    db 0Dh,0Ah,"Enter D (2-digit): $"

msgIn   db 0Dh,0Ah,"Inputs: A=",0
msgInB  db ", B=",0
msgInC  db ", C=",0
msgInD  db ", D=",0

msgEq   db 0Dh,0Ah,"Equation: X = A - (B * C) / D",0Dh,0Ah,"$"
msgRes  db 0Dh,0Ah,"Result (Base 10): $"
msgRes5 db 0Dh,0Ah,"Result (Base 5): $"

; =======================
; CODE
; =======================
start:

    ; === Input A ===
    lea dx, msgA
    mov ah, 9
    int 21h
    call READ_DEC
    mov A, ax

    ; === Input B ===
    lea dx, msgB
    mov ah, 9
    int 21h
    call READ_DEC
    mov B, ax

    ; === Input C ===
    lea dx, msgC
    mov ah, 9
    int 21h
    call READ_DEC
    mov C, ax

    ; === Input D ===
    lea dx, msgD
    mov ah, 9
    int 21h
    call READ_DEC
    mov D, ax

    ; === Show inputs back ===
    lea dx, msgIn
    mov ah, 9
    int 21h
    mov ax, A
    call PRINT_DEC

    lea dx, msgInB
    mov ah, 9
    int 21h
    mov ax, B
    call PRINT_DEC

    lea dx, msgInC
    mov ah, 9
    int 21h
    mov ax, C
    call PRINT_DEC

    lea dx, msgInD
    mov ah, 9
    int 21h
    mov ax, D
    call PRINT_DEC

    ; === Show equation text ===
    lea dx, msgEq
    mov ah, 9
    int 21h

    ; === Compute X = A - (B * C) / D ===
    mov ax, B
    mov bx, C
    mul bx         ; AX = B * C
    cwd
    idiv D         ; AX = (B*C)/D
    mov bx, ax     ; store (B*C)/D in BX

    mov ax, A      ; AX = A
    sub ax, bx     ; A - (B*C)/D
    mov X, ax

    ; === Show result in base 10 ===
    lea dx, msgRes
    mov ah, 9
    int 21h
    mov ax, X
    call PRINT_DEC

    ; === Show result in base 5 ===
    lea dx, msgRes5
    mov ah, 9
    int 21h
    mov ax, X
    mov bx, 5
    call PRINT_BASE

    ; Exit program
    mov ah, 4Ch
    int 21h

; =======================
; SUBROUTINES
; =======================

; --- Read decimal input ---
READ_DEC proc
    xor cx, cx
    xor ax, ax
next_digit:
    mov ah, 1
    int 21h
    cmp al, 0Dh
    je finish_input
    sub al, '0'
    mov bl, al
    mov ax, cx
    mov dx, 10
    mul dx
    add ax, bx
    mov cx, ax
    jmp next_digit
finish_input:
    mov ax, cx
    ret
READ_DEC endp

; --- Print decimal number in AX ---
PRINT_DEC proc
    pusha
    cmp ax, 0
    jge skip_neg
    mov ah, 2
    mov dl, '-'
    int 21h
    neg ax
skip_neg:
    mov cx, 0
    mov bx, 10
repeat_div:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne repeat_div
print_loop:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop print_loop
    popa
    ret
PRINT_DEC endp

; --- Print number in base BX (AX input) ---
PRINT_BASE proc
    pusha
    cmp ax, 0
    jge skip_neg_b
    mov ah, 2
    mov dl, '-'
    int 21h
    neg ax
skip_neg_b:
    xor cx, cx
repeat_divb:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne repeat_divb
print_loopb:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop print_loopb
    popa
    ret
PRINT_BASE endp

end start