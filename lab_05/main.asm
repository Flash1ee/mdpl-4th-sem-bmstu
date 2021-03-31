; чётные элементы увеличить на 1, нечётные -
; уменьшить на 1. Вывести только последние цифры
; новых значений

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

    in_rows_msg db "Input count of rows([1:9]) $"
    in_cols_msg db "Input count of cols([1:9]) $"
    result_msg db "Result matrix $"
    err db "Error$"
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:SEGDATA, SS:STK

main:
    mov AX, SEGDATA

    ; кол-во строк
    mov DS, AX

    mov dx, offset in_rows_msg
    mov ah, 9
    int 21h
    ; считывание n
    mov ah, 1
    int 21H
    mov n, al
    ; проверка валидности n
    cmp al, '0'
    jbe exit_err
    cmp al, '9'
    ja exit_err

    sub n, '0'

    ; новая строка
    call newline

    ; сообщение считывания m 
    mov dx, offset in_cols_msg
    mov ah, 9
    int 21h

    mov ah, 1
    int 21H
    mov m, al

    cmp al, '0'
    ; проверки валидности
    jbe exit_err
    cmp al, '9'
    ja exit_err

    sub m, '0'

    ; вывод новой строки
    call newline

    mov al, m
    mul n
    mov CX, AX ; CX -  количество элементов в матрице
    mov si, 0

    read_matrix:
        mov ah, 1
        int 21H
        cmp al, '0'
        jb exit_err
        cmp al, '9'
        ja exit_err
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

    mov al, m
    mul n
    mov cx, AX
    mov si, 0
    mov BP, 0
    new_matrix:
        xor AX, AX
        xor bx, bx
        mov bl, matrix[BP]
        mov ax, bx
        mov bl, 2
        div bl
        cmp ah, 0
        je incr
        jne decr
        go_next:

        inc BP
        loop new_matrix


    mov dx, offset result_msg
    mov ah, 9
    int 21h
    call newline

    call print_matrix
    
    exit:
    mov ax, 4c00H
    int 21H

exit_err:
    mov dl, 10
    mov ah, 2
    int 21H
    mov dl, 13 
    int 21h
    mov dx, offset err
    mov ah, 9
    int 21h
    jmp exit

call_newline:
    call newline
    jmp go_back

decr:
    dec matrix[BP]
    jmp go_next
incr:
    inc matrix[BP]
    jmp go_next

SEGCODE ENDS
END main






