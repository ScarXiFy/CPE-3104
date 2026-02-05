name "vowel-determinator"
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

    MOV DX, OFFSET MSG1
    MOV AH, 09H
    INT 21H
    
    MOV BX, OFFSET USER_INPUT
    CALL ASK_PER_CHAR
    CALL NEW_LINE
    XOR CX, CX
    MOV BX, OFFSET USER_INPUT
    CALL CHECK_VOWELS
    
ret

ASK_PER_CHAR:
    MOV AH, 00H
    INT 16H
    MOV [BX], AL
    CMP AL, '$'
    JE EXIT
    MOV AH, 02H
    MOV DL, AL
    INT 21H
    INC BX
    JMP ASK_PER_CHAR
    
CHECK_VOWELS:
    CMP [BX], '$'
    JE PRINT_VOWELS
    CMP [BX], 'a'
    JE ADD_VOWEL
    CMP [BX], 'e'
    JE ADD_VOWEL
    CMP [BX], 'i'
    JE ADD_VOWEL
    CMP [BX], 'o'
    JE ADD_VOWEL
    CMP [BX], 'u'
    JE ADD_VOWEL
    INC BX          ; Increments current string index
    JMP CHECK_VOWELS
    
PRINT_VOWELS:
    PUSHA
    MOV DX, OFFSET MSG2
    MOV AH, 09H
    INT 21H
    POPA
    
    PUSHA
    MOV AL, CL
    AAM
    ADD AX, 3030H
    MOV DL, AH
    MOV DH, AL
    CMP DL, 30H
    JE SECOND_DIGIT
    MOV AH, 02H
    INT 21H
    
    SECOND_DIGIT:
    MOV DL, DH
    MOV AH, 02H
    INT 21H
    POPA
    
    PUSHA
    MOV DX, OFFSET MSG3
    MOV AH, 09H
    INT 21H
    POPA
    RET
    
    
ADD_VOWEL:
    INC CX      ; Increments count of vowels
    INC BX      ; Increments current string index
    JMP CHECK_VOWELS
    
NEW_LINE:
    PUSH AX
    MOV DX, OFFSET NL
    MOV AH, 09H
    INT 21H
    POP AX
    RET
    
    
EXIT:
    RET
    
    
MSG1 DB 'Input a String: ', '$'
MSG2 DB 'The string contains ', '$'
MSG3 DB ' vowels!', '$'
NL   DB 13, 10, '$'
USER_INPUT DB 50 DUP(?)
    

    

