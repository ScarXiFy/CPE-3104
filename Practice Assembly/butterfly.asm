.model small
.stack 100h
.data
    ; Separate components
    left_wing  db 'W$'
    body       db ' BODY $'
    right_wing db 'W$'

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; Set video mode to 80x25
    mov ah, 0
    mov al, 3
    int 10h
    
    ; Position cursor at the center bottom (row 24, column 34)
    mov ah, 2
    mov dh, 23  ; row 24 (bottom row of 25-row screen)
    mov dl, 35  ; column 34 (center of 80-column screen, considering total width)
    int 10h
    
    ; Display left wing
    mov ah, 9
    lea dx, left_wing
    int 21h
    
    ; Display body
    lea dx, body
    int 21h
    
    ; Display right wing
    lea dx, right_wing
    int 21h
    
    ; Wait for a key press
    mov ah, 1
    int 21h
    
    ; Clear screen
    mov ah, 0
    mov al, 3
    int 10h
    
    ; Position cursor at the center (row 12, column 34)
    mov ah, 2
    mov dh, 12  ; middle row
    mov dl, 35  ; center column
    int 10h
    
    ; Display left wing
    mov ah, 9
    lea dx, left_wing
    int 21h
    
    ; Display body
    lea dx, body
    int 21h
    
    ; Display right wing
    lea dx, right_wing
    int 21h
    
    ; Wait for a key press
    mov ah, 1
    int 21h
    
    ; Clear screen again
    mov ah, 0
    mov al, 3
    int 10h
    
    ; Display body in center
    mov ah, 2
    mov dh, 12  ; middle row
    mov dl, 37  ; center column for body
    int 10h
    
    mov ah, 9
    lea dx, body
    int 21h
    
    ; Display left wing up left (row 5, column 20)
    mov ah, 2
    mov dh, 5   ; upper row
    mov dl, 20  ; left column
    int 10h
    
    mov ah, 9
    lea dx, left_wing
    int 21h
    
    ; Display right wing down right (row 19, column 55)
    mov ah, 2
    mov dh, 19  ; lower row
    mov dl, 57  ; right column
    int 10h
    
    mov ah, 9
    lea dx, right_wing
    int 21h
    
    ; Wait for a key press
    mov ah, 1
    int 21h
    
    ; Clear screen again
    mov ah, 0
    mov al, 3
    int 10h
    
    ; Display body in center
    mov ah, 2
    mov dh, 12  ; middle row
    mov dl, 37  ; center column for body
    int 10h
    
    mov ah, 9
    lea dx, body
    int 21h
    
    ; Display left wing bottom left of body (row 13, column 31)
    mov ah, 2
    mov dh, 19  ; row just below body
    mov dl, 20  ; column left of body
    int 10h
    
    mov ah, 9
    lea dx, left_wing
    int 21h
    
    ; Display right wing top right of body (row 11, column 43)
    mov ah, 2
    mov dh, 5  ; row just above body
    mov dl, 57  ; column right of body
    int 10h
    
    mov ah, 9
    lea dx, right_wing
    int 21h
    
    ; Wait for a key press
    mov ah, 1
    int 21h
    
    ; Clear screen again
    mov ah, 0
    mov al, 3
    int 10h
    
    ; Position cursor at the center (row 12, column 34)
    mov ah, 2
    mov dh, 12  ; middle row
    mov dl, 35  ; center column
    int 10h
    
    ; Display left wing
    mov ah, 9
    lea dx, left_wing
    int 21h
    
    ; Display body
    lea dx, body
    int 21h
    
    ; Display right wing
    lea dx, right_wing
    int 21h
    
    ; Wait for a key press
    mov ah, 1
    int 21h
    
    ; Exit program
    mov ah, 4Ch
    int 21h
main endp

end main