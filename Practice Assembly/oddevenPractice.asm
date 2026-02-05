name "odd-even"

org 100h 

    PUSH CS
    POP DS
    
    ; To Print "The stored value is : "
    MOV DX, OFFSET msgStored
    MOV AH, 09H
    INT 21H
    
    ; To Print the stored digit
    MOV AL, [stored_value]
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    
    ; To Print a newline
    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    MOV AH, 02H
    INT 21H
    
    ; To Check if Stored Value is Odd or Even
    MOV AL, [stored_value]
    AND AL, 1
    JZ print_even
    
    ; If Stored Value is Odd
    MOV DX, OFFSET msgOdd
    MOV AH, 09H
    INT 21H
    JMP done
    
    ; If Stored Value is Even
    print_even:
    MOV DX, OFFSET msgEven
    MOV AH, 09H
    INT 21H
    
    done:
    ret
    
    
    ; - data -
    
    stored_value    DB 8
    msgStored       DB "The Stored value is : $"
    msgOdd          DB "The given value is Odd!$"
    msgEven         DB "The given value is Even!$"    
    
    
    


ret