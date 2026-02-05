org 100h         

mov ax, 0B800h   
mov es, ax

mov di, (12 * 160) + (29 * 2) 


mov si, offset name_str

print_loop:
    lodsb                  
    cmp al, 0             
    je done
    mov es:[di], al        
    mov es:[di+1], 1Eh     
    add di, 2              
    jmp print_loop

done:
    ret

name_str db 'JOHN ENRICO DESALAGO LAURON', 0