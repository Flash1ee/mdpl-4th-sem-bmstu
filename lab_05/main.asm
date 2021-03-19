EXTRN newline: near
EXTRN print_space: near
EXTRN print_matrix: near

PUBLIC m
PUBLIC n
PUBLIC matrix

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
    call print_space

    mov ah, 1
    int 21H
    mov n, al
    sub n, '0'

    ; вывод новой строки
    call newline

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

        call print_space

        ; проверка на перевод на новую строку
        mov AX, si
        mov bl, m
        div bl
        cmp ah, 0
        je call_newline
        go_back:

        loop read_matrix

    ; newline
    call newline

    call print_matrix
    
    mov ax, 4c00H
    int 21H
    
call_newline:
    call newline
    jmp go_back


SEGCODE ENDS
END main






