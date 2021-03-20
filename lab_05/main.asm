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
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:SEGDATA, SS:STK

main:
    mov AX, SEGDATA
    mov DS, AX

    mov ah, 1
    int 21H
    mov m, al

    cmp al, '0'
    jb exit
    cmp al, '9'
    ja exit

    sub m, '0'

    ; вывод пробела
    call print_space

    mov ah, 1
    int 21H
    mov n, al
    
    cmp al, '0'
    jb exit
    cmp al, '9'
    ja exit

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
        cmp al, '0'
        jb exit
        cmp al, '9'
        ja exit
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



    call print_matrix
    
    exit:
    mov ax, 4c00H
    int 21H
    
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






