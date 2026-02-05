; LE31.ASM      LAURONje        DATE: 2025.09.11
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

ORG 100H  

MOV AL, 0F0H    
MOV BL, 20H 
ADC AX, BX  
MOV CL, AL  
SBB CL, BL  
ADC CL, BL  
MUL BL 
MUL CX 
IMUL BX 
MOV AX,BX 
DIV DL 
 
RET




