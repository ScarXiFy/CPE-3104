
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

ORG 100H

LEA DX, MSG1
MOV AH, 09H
INT 21H

LEA DX, INPUT
MOV AH, 0AH
INT 21H

CALL NEW_LINE
CALL NEW_LINE
CALL NEW_LINE

CALL COUNT_VOWELS

MOV AL, VOWEL_A
ADD TOTAL_VOWEL, AL

MOV AL, VOWEL_E
ADD TOTAL_VOWEL, AL

MOV AL, VOWEL_I
ADD TOTAL_VOWEL, AL

MOV AL, VOWEL_O
ADD TOTAL_VOWEL, AL

MOV AL, VOWEL_U
ADD TOTAL_VOWEL, AL

    ; ----- DISPLAY CHARS INPUTTED
        
MOV BL, INPUT[1]
MOV LEN , BL
XOR BX, BX

LEA SI, LEN
MOV CX, 1
CALL DISPLAY_2DIGIT
LEA DX, MSG2
MOV AH, 09H
INT 21H

    ; ----- DISPLAY # OF VOWEL A
CALL NEW_LINE
CALL NEW_LINE
LEA SI, VOWEL_A
MOV CX, 1
CALL DISPLAY_2DIGIT
LEA DX, MSG3
MOV AH, 09H
INT 21H
CALL DISPLAY_APS

    ; ----- DISPLAY # OF VOWEL E
CALL NEW_LINE
CALL NEW_LINE
LEA SI, VOWEL_E
MOV CX, 1
CALL DISPLAY_2DIGIT
LEA DX, MSG4
MOV AH, 09H
INT 21H
CALL DISPLAY_APS

    ; ----- DISPLAY # OF VOWEL I
CALL NEW_LINE
CALL NEW_LINE
LEA SI, VOWEL_I
MOV CX, 1
CALL DISPLAY_2DIGIT
LEA DX, MSG5
MOV AH, 09H
INT 21H
CALL DISPLAY_APS

    ; ----- DISPLAY # OF VOWEL O
CALL NEW_LINE
CALL NEW_LINE
LEA SI, VOWEL_O
MOV CX, 1
CALL DISPLAY_2DIGIT
LEA DX, MSG6
MOV AH, 09H
INT 21H
CALL DISPLAY_APS

    ; ----- DISPLAY # OF VOWEL U
CALL NEW_LINE
CALL NEW_LINE
LEA SI, VOWEL_U
MOV CX, 1
CALL DISPLAY_2DIGIT
LEA DX, MSG7
MOV AH, 09H
INT 21H
CALL DISPLAY_APS

    ; ----- DISPLAY TOTAL VOWELS
CALL NEW_LINE
CALL NEW_LINE
LEA SI, TOTAL_VOWEL
MOV CX, 1
CALL DISPLAY_2DIGIT
LEA DX, MSG8
MOV AH, 09H
INT 21H

    ; ----- DISPLAY TOTAL CONSONANTS
CALL NEW_LINE
CALL NEW_LINE
LEA SI, TOTAL_CONSONANT
MOV CX, 1
CALL DISPLAY_2DIGIT
LEA DX, MSG9
MOV AH, 09H
INT 21H

RET

COUNT_VOWELS:
     LEA SI, INPUT[2]
     XOR CX, CX
     MOV CL, INPUT[1]
     
START:
    CMP [SI], ' '
    JE NOCOUNT
    
    CMP [SI], '0'
    JB CHECK_VOWELS
    
    CMP [SI], '9'
    JA CHECK_VOWELS
    
    INC SI
    
    JMP GO_LS
    
    CHECK_VOWELS:
        CMP [SI], 'A'
        JE COUNTA
        CMP [SI], 'a'
        JE COUNTA
        
        CMP [SI], 'E'
        JE COUNTE
        CMP [SI], 'e'
        JE COUNTE
        
        CMP [SI], 'I'
        JE COUNTI
        CMP [SI], 'i'
        JE COUNTI
        
        CMP [SI], 'O'
        JE COUNTO
        CMP [SI], 'o'
        JE COUNTO
        
        CMP [SI], 'U'
        JE COUNTU
        CMP [SI], 'u'
        JE COUNTU
        
        INC TOTAL_CONSONANT
        INC SI
        
GO_LS:
    LOOP START

RET

NOCOUNT:
    INC SI
    JMP GO_LS
    
COUNTA:
    INC VOWEL_A
    INC SI
    JMP GO_LS
    
COUNTE:
    INC VOWEL_E
    INC SI
    JMP GO_LS
    
COUNTI:
    INC VOWEL_I
    INC SI
    JMP GO_LS
    
COUNTO:
    INC VOWEL_O
    INC SI
    JMP GO_LS
    
COUNTU:
    INC VOWEL_U
    INC SI
    JMP GO_LS
    
DISPLAY_2DIGIT:
    MOV AX, 00H
    MOV AL, [SI]
    MOV BL, 10
    DIV BL
    
    ; ----- TENS DIGIT
    MOV BH, AH
    MOV DL, AL
    ADD DL, '0'
    CALL DISPLAY_CHAR
    
    ; ----- ONES DIGIT
    MOV DL, BH
    ADD DL, '0'
    CALL DISPLAY_CHAR
    
    MOV DL, ' '
    MOV DH, 00001011B
    CALL DISPLAY_CHAR
    
    INC SI
    LOOP DISPLAY_2DIGIT
    RET
    
DISPLAY_APS:
    MOV DL, 39
    CALL DISPLAY_CHAR
    MOV DL, 's'
    CALL DISPLAY_CHAR
    RET
    
DISPLAY_CHAR:
    MOV AH, 02H
    INT 21H
    RET
    
NEW_LINE:
    MOV DX, 13
    MOV AH, 02H
    INT 21H
    MOV DX, 10
    MOV AH, 02H
    INT 21H
    RET
    
EXIT:
    MOV AH, 4CH
    INT 21H

MSG1 DB "Input string [max. 20]: ", '$'
INPUT DB 20, ?, 20 DUP(?)
LEN DB ?
MSG2 DB "- chars inputted", '$'
MSG3 DB "- a", '$'
MSG4 DB "- e", '$'
MSG5 DB "- i", '$'
MSG6 DB "- o", '$'
MSG7 DB "- u", '$'
MSG8 DB "- total vowels", '$'
MSG9 DB "- total consonants", '$'

VOWEL_A DB 0
VOWEL_E DB 0
VOWEL_I DB 0
VOWEL_O DB 0
VOWEL_U DB 0

TOTAL_VOWEL DB 0
TOTAL_CONSONANT DB 0