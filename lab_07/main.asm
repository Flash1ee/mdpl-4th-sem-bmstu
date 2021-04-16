; Написать резидентную программу под DOS, которая будет каждую секунду менять
; скорость автоповтора ввода символов в циклическом режиме, от самой медленной до
; самой быстрой.
.model tiny
.code
.186

org 100h   

MAIN:
    cur DB 0
    speed DB 01fh
    SAVEPROC DD ?
    is_installed DB 'X'

    JMP INIT


MY_FUNC:
    pusha
    pushf
    push es
    push ds

    mov ah, 02h
    int 1ah

    cmp dh, cur
    mov cur, dh
    je end_loop

    mov al, 0F3h
    out 60h, al
    mov al, speed
    out 60h, al

    dec speed
    test speed, 01fh
    jz reset
    jmp end_loop
    reset:
        mov speed, 01fh

    end_loop:
        pop ds
        pop es

        popf
        popa

        jmp CS:SAVEPROC

INIT:
    MOV AX, 351ch
    INT 21H

    cmp es:is_installed, 'X'
    JE EXIT

    MOV WORD PTR SAVEPROC, BX
    MOV WORD PTR SAVEPROC+2, ES

    MOV AX, 251ch
    MOV DX, OFFSET MY_FUNC
    INT 21H

    MOV DX, OFFSET INIT
    INT 27H

EXIT:
    pusha

    push es
    push DS

    pushf

    mov dx, word ptr es:SAVEPROC
    mov ds, word ptr es:SAVEPROC+2

    mov ax, 251ch
    int 21H
  
    popf

    pop ds
    pop ES
    popa
    
    mov ah, 49H
    int 21h

    mov ax, 4C00h
    int 21h

END MAIN