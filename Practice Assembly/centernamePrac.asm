name "center-name"
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

MOV AX, 0B800H
MOV ES, AX

MOV DI, (12 * 160) + (26 * 2)

MOV SI, OFFSET MSG_NAME

PRINT_LOOP:
    LODSB
    CMP AL, 0
    JE EXIT
    MOV ES:[DI], AL
    MOV ES:[DI + 1], 1EH
    ADD DI, 2
    JMP PRINT_LOOP
    
EXIT:
ret

MSG_NAME DB "JOHN ENRICO DESALAGO LAURON", 0




