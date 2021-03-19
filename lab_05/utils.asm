PUBLIC newline
PUBLIC print_space
PUBLIC print_matrix

EXTRN n: byte
EXTRN m: byte
EXTRN matrix: byte

SEGDATA SEGMENT PARA COMMON 'DATA'
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:SEGDATA

newline proc near
    mov ah, 2
    mov dl, 10
    int 21H
    mov dl, 13
    int 21H

    ret
newline endp

print_space proc near
    mov ah, 2
    mov dl, " "
    int 21H

    ret
print_space endp

print_matrix proc near
    ; в si пишу количество символов
    mov al, m
    mul n
    mov CX, AX
    mov si, 0

    print:
        mov ah, 2
        mov dl, matrix[si]
        add dl, '0'
        int 21H

        call print_space

        inc si

        ; проверка на перевод на новую строку
        mov AX, si
        mov bl, m
        div bl
        cmp ah, 0
        je call_newline_print
        go_back_out:

        loop print
    ret

print_matrix endp

call_newline_print proc near
    call newline
    jmp go_back_out
    ret
call_newline_print endp


SEGCODE ENDS
END
