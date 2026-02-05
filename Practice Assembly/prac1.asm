name "odd-even"

; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
  
  MOV AX, 0B800H
  MOV ES, AX
  
  XOR DI, DI
  
  LEA SI, msgStored
  CALL print_string
  
  MOV AL, [stored_value]
  ADD AL, '0'
  MOV ES:[DI], AL
  ADD DI, 2
  
  MOV DI, 160
  
  MOV AL, [stored_value]
  AND AL, 1
  JZ print_even
  
  LEA SI, msgOdd
  CALL print_string
  JMP done
  
  print_even:
  LEA SI, msgEven
  call print_string
  
  done:
  ret
  
  print_string:
    LODSB
    CMP AL, 0
    JE print_done
    MOV ES:[DI], AL
    ADD DI, 2
    JMP print_string
    
  print_done:
  ret
  
  stored_value DB   8
  msgStored    DB   "The stored value is : ", 0
  msgOdd       DB   "The given value is Odd!", 0
  msgEven      DB   "The given value is Even!", 0

;MOV AX, 0B800H
    ;MOV DS, AX
    ;MOV CL, 'A'
    ;MOV CH, 1101_1111b
    ;MOV BX, 15EH
    ;MOV [BX], CX
        
    ;-----------------------------    
        
    ;MOV AH, 0EH
    
    ;INT 10H / OEH SUB-FUNCTION
    ;receives an ASCII code of the
    ;character that will be printed
    ;in AL register
    
    ;MOV AL, 'H' ;ASCII CODE: 72
    ;INT 10H     ;PRINT IT!
    
    ;MOV AL, 'e' ;ASCII CODE: 101
    ;INT 10H     ;PRINT IT!
    
    ;MOV AL, 'l' ;ASCII CODE: 108
    ;INT 10H     ;PRINT IT!
    
    ;MOV AL, 'l' ;ASCII CODE: 108
    ;INT 10H     ;PRINT IT!
    
    ;MOV AL, 'o' ;ASCII CODE: 111
    ;INT 10H     ;PRINT IT!
    
    ;MOV AL, '!' ;ASCII CODE: 33
    ;INT 10H    ;PRINT IT!
    
    ;-----------------------------
    
    ;LEA SI, msg     ;load address of msg to SI.
    
    ;CALL print_me
    
    ;print_me PROC
    
    ;next_char:
    ;CMP b.[SI], 0
    ;JE stop
    
    ;MOV AL, [SI]
    
    ;MOV AH, 0EH
    ;INT 10H
    
    ;ADD SI, 1
    
    ;JMP next_char
    
  ;stop:
  ;RET
  ;print_me ENDP

    ;msg DB 'Hello World!', 0
    
  ;END
  
  ;-----------------------------