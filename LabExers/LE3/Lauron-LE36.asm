; LE36.ASM      LAURONje        DATE: 2025.09.11
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

ORG 100H 
 
  LEA DX, STRING  
  MOV AH, 09H  
  INT 21H 
 
 CALL REVERSE 
 
  LEA DX, STRING 
  MOV AX, 09H  
  INT 21H 
 
RET    
    
REVERSE: 
 MOV CX, 0000H  
  
LOOP1: 
  XOR AX, AX 
  MOV AL, [SI]  
  CMP AL, '$'  
  JE LABEL1  
  PUSH AX  
  INC SI 
  LOOP LOOP1 
 
LABEL1: 
  MOV SI, OFFSET STRING 
  MOV CX, 23 
            
LOOP2: 
  POP DX 
  MOV [SI], DL  
  INC SI 
  LOOP LOOP2 
 
EXIT: 
   MOV [SI], '$'  
RET 
         
STRING DB 'THIS IS A SAMPLE STRING$' 
