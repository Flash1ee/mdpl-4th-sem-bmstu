STK SEGMENT PARA STACK 'STACK'
    DB 200 dup (0)
STK ENDS

SEGDATA SEGMENT PARA COMMON 'DATA'
    m   db 1;
    n   db 1;
    matrix  db 81 dup('0')
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:SEGDATA, SS:STK

main:
    mov AX, SEGDATA
    mov DS, AX

    mov ah, 1
    int 21H
    mov m, al
    sub m, '0'

    ; вывод пробела
    mov dl, 32
    mov ah, 2
    int 21H

    mov ah, 1
    int 21H
    mov n, al
    sub n, '0'

    ; вывод новой строки
    mov ah, 2
    mov dl, 10 ; LF
    int 21H
    mov dl, 13 ; CR
    int 21H

    mov al, m
    mul n
    mov CX, AX ; CX -  количество элементов в матрице
    mov si, 0

    read_matrix:
        mov ah, 1
        int 21H
        sub al, '0'
        mov matrix[si], al
        inc si

        mov dl, " "
        mov ah, 2
        int 21H

        ; проверка на перевод на новую строку
        mov AX, si
        mov bl, m
        div bl
        cmp ah, 0
        je call_newline
        go_back:

        loop read_matrix

    ; newline

    mov ah, 2
    mov dl, 10 ; LF
    int 21H
    mov dl, 13 ; CR
    int 21H

    ; в si пишу количество символов
    mov al, m
    mul n
    mov CX, AX
    mov si, 0

    print_matrix:
        mov ah, 2
        mov dl, matrix[si]
        add dl, '0'
        int 21H

        mov dl, " "
        int 21H

        inc si

        ; проверка на перевод на новую строку
        mov AX, si
        mov bl, m
        div bl
        cmp ah, 0
        je call_newline_print
        go_back_out:

        loop print_matrix
    
    mov ax, 4c00H
    int 21H
    
call_newline:
    mov ah, 2
    mov dl, 10 ; LF
    int 21H
    mov dl, 13 ; CR
    int 21H
    jmp go_back

call_newline_print:
    mov ah, 2
    mov dl, 10 ; LF
    int 21H
    mov dl, 13 ; CR
    int 21H
    jmp go_back_out

SEGCODE ENDS
END main






