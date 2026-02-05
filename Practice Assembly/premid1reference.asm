
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

MOV AX, 0B800H
MOV ES, AX 

    CALL INPUT_DISPLAY
    
    
    HLT

ret

USER_INPUT DB 10,?,10 DUP(' ')
INPUT_MSG DB "INPUT ODD-NUMBERED STRING: $"

INPUT_DISPLAY:
    MOV AH, 9
    LEA DX, INPUT_MSG
    INT 21H
    
    MOV AH, 0AH
    LEA DX, USER_INPUT
    INT 21H
    
        MOV CL, [USER_INPUT+1]
    
        
        CMP CL, 3
        JE MODULE_3
       
        
        MODULE_3:
            XOR BX, BX
            CALL CLEAR_SCREEN3
            CALL DISPLAY_bottom_CENTER3
            CALL MOVING_DIAGONAL3
            CALL MOVING_UP_DOWN3
            CALL MOVING_DIAGONAL_BACK
            ;CALL CLEARING2
            ;CALL MOVING_UP3
            
            
        
        RET
        
       
        
    
RET

CLEAR_SCREEN:
    MOV CX, 40 
    MOV DI, 0
    
    CLEARING:
    
    MOV DH, 00001111B
    MOV DL, ' '   
    MOV ES:[DI], DX
    ADD DI, 2
    LOOP CLEARING
RET

CLEAR_SCREEN3:
   MOV CX, 38
   MOV DI, 0
   
   CLEARING3:
   MOV DH, 00001111B
   MOV DL, ' '   
   MOV ES:[DI], DX
   ADD DI, 2
   LOOP CLEARING3
   
RET


DISPLAY_bottom_CENTER3:  

    MOV CL, [USER_INPUT+1]  ; number of characters entered


    
    PRINT_bottom3M:
        MOV DI, 3918          ; starting column
        MOV SI, 2           ; offset to first character
        
        MOV AL, [USER_INPUT+2]  
        MOV AH, 07h
        MOV ES:[DI], AX
        ADD DI, 2 
        
        MOV AL, [USER_INPUT+3]  
        MOV ES:[DI], AX
        ADD DI, 2
        
        MOV AL, [USER_INPUT+4]  
        MOV ES:[DI], AX
        SUB DI, 4
        
        CALL DELAY
        
        
        MOV AL, ' '
        MOV ES:[DI], AX
        ADD DI, 2
        
        MOV ES:[DI], AX
        ADD DI, 2
        
        
        MOV ES:[DI], AX 
        
        MOV DI, 3758       ; starting position for left letters
        MOV CX, 11           ; number of steps upward 
    


    UP_LOOP3M:
     
        MOV AL, [USER_INPUT+2]  
        MOV AH, 07h
        MOV ES:[DI], AX
        ADD DI, 2
    
        MOV AL, [USER_INPUT+3]   
        MOV ES:[DI], AX
        ADD DI, 2
        
        MOV AL, [USER_INPUT+4]  
        MOV ES:[DI], AX
        SUB DI, 4

        
        CALL DELAY2
        
        MOV AL, ' '   
        MOV ES:[DI], AX
        ADD DI, 2
    
        MOV AH, 07h 
        MOV ES:[DI], AX
        ADD DI, 2
        
        MOV ES:[DI], AX
        SUB DI, 4
    
        SUB DI, 160   
    
    
        LOOP UP_LOOP3M 
RET  
   
   
CLEAR_STRING:
    PUSH CX
    PUSH DI
    MOV AH, 07h        ; same attribute as printing
    MOV AL, ' '        ; space
CLEAR_LOOP:
    MOV ES:[DI], AX
    ADD DI, 2
    LOOP CLEAR_LOOP
    POP DI
    POP CX
RET


   
DELAY:
    MOV CX, 01Fh       ; adjust this number to make it slower/faster
DELAY_LOOP:
    NOP                ; do nothing, just waste time
    LOOP DELAY_LOOP
    
RET


MOVING_DIAGONAL3:
    MOV DI, 2000  
    MOV SI, 2162  
    
    MOV DH, 07H
    MOV DL, [USER_INPUT+3]
    MOV ES:[DI], DX
    SUB DI, 162
    
    MOV CX, 9  
    
    HORIZONTAL3:
    MOV DL, [USER_INPUT+2]  
    MOV ES:[DI], DX
    
    MOV DL, [USER_INPUT+4] 
    MOV ES:[SI], DX
    
    
    CALL DELAY2
    
    MOV DL, ' '
    MOV ES:[DI], DX
    SUB DI, 168  
    
    MOV DL, ' '
    MOV ES:[SI], DX
    ADD SI, 168
    

    LOOP HORIZONTAL3
  
RET

MOVING_UP_DOWN3: 
    
    MOV CX, 18

    LOOPC:

        ADD DI, 160 
        MOV DH, 07H
        MOV DL, [USER_INPUT+2]
        MOV ES:[DI], DX
        
        SUB SI, 160
        MOV DL, [USER_INPUT+4]
        MOV ES:[SI], DX
        
        
        
        CALL DELAY2
        
        MOV DL, ' '
        MOV ES:[DI], DX
        
        MOV DL, ' '
        MOV ES:[SI], DX
        
                        
    LOOP LOOPC
    


RET

MOVING_DIAGONAL_BACK: 
    

    
    MOV DI, 3684  
    MOV SI, 318  
    
    MOV CX, 9  
    
    DIAGONALS:
    MOV DL, [USER_INPUT+2]  
    MOV ES:[DI], DX
    
    MOV DL, [USER_INPUT+4] 
    MOV ES:[SI], DX
    
    
    CALL DELAY2
    
    MOV DL, ' '
    MOV ES:[DI], DX
    SUB DI, 152  
    
    MOV DL, ' '
    MOV ES:[SI], DX
    ADD SI, 152
    

    LOOP DIAGONALS 
    
    
    MOV DI, 2000  
    MOV SI, 2162  
    
    MOV DH, 07H
    MOV DL, [USER_INPUT+3]
    MOV ES:[DI], DX
    SUB DI, 162
    


RET    


DELAY2:
    MOV BX, 01Fh       
DELAY2_LOOP:
    NOP               
    DEC BX
    JNZ DELAY2_LOOP
RET




