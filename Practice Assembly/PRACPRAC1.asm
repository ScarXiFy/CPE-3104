
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

ORG 100H

LEA DX, MSG_PROMPT
MOV AH, 09H
INT 21H

CALL GET_INPUT
CALL CLEAR_SCREEN

XOR CX, CX
MOV DH, 24

DISPLAY:
    MOV AL, 1
    MOV BL, 07H
    MOV CL, INPUT[1]
    
    MOV BH, INPUT[1]
    CMP BH, 5
    JE LEN5
    CMP BH, 7
    JE LEN7
    
    MOV BH, 0
    MOV DL ,41
    SUB DL, INPUT[1]
    
START:
    LEA BP, INPUT + 2
    MOV AH, 13H
    INT 10H
    
    CMP DH, 0
    JE AT_TOP
    LEA BP, BLANK
    INT 10H
    
    DEC DH
    JMP DISPLAY
    
RET

AT_TOP PROC
    MOV AX, 0B800H
    MOV ES, AX
    
    XOR BX, BX
    XOR DX, DX
    
    MOV BL, INPUT[1]
    CMP BX, 5
    JE MOVE_2OUTWARDS

SET_CURSOR_POS:
    MOV DL, 40
    SUB DL, INPUT[1]
    ADD DL, 1
    MOV AH, 02H
    INT 10H
    RET
    
GET_INPUT:
    LEA DX, INPUT
    MOV AH, 0AH
    INT 21H
    RET
    
CLEAR_SCREEN:
    MOV DL, 03H
    MOV AH, 00H
    INT 10H
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



MSG_PROMPT DB "Enter an Odd string: ", '$'
INPUT DB 20, ?, 20 DUP(?)
BLANK DB '        '

LEN5_L4_HOLDER1 DW 82
LEN5_L5_HOLDER1 DW 84
LEN5_L4_HOLDER2 DW 3996
LEN5_L5_HOLDER2 DW 3998

LEN7_L5_HOLDER1 DW 82
LEN7_L6_HOLDER1 DW 84
LEN7_L7_HOLDER1 DW 86
LEN7_L5_HOLDER2 DW 3994
LEN7_L6_HOLDER2 DW 3996
LEN7_L7_HOLDER2 DW 3998