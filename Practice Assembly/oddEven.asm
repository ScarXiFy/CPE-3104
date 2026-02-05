org 100h


push cs
pop ds


mov ax, 0B800h
mov es, ax
xor di, di            


lea si, msgStored
call print_string


mov al, [stored_value]
add al, '0'
mov es:[di], al
add di, 2


mov di, 160


mov al, [stored_value]
and al, 1
jz print_even


lea si, msgOdd
call print_string
jmp done

print_even:
lea si, msgEven
call print_string

done:
ret


print_string:
    lodsb
    cmp al, 0
    je print_done
    mov es:[di], al
    add di, 2
    jmp print_string
print_done:
    ret

stored_value db 8
msgStored    db "The stored value is : ",0
msgOdd       db "The given value is odd",0
msgEven      db "The given value is even",0