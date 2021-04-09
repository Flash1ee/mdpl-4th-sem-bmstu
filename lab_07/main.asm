; Написать резидентную программу под DOS, которая будет каждую секунду менять
; скорость автоповтора ввода символов в циклическом режиме, от самой медленной до
; самой быстрой.
.model tiny
.code
.186

org 100h   

MAIN proc near 
    cur DB 0
    speed DB 01fh
    SAVEPROCINT9 DD ?
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
    test speed, 0h
    jz reset
    jmp end_loop
    reset:
        mov speed, 01fh

    end_loop:
        pop ds
        pop es

        popf
        popa

        jmp CS:SAVEPROCINT9
EXIT:
    push es
    push DS
    mov ah, 2
    mov dl, 30
    int 21h

    mov ax,2509H
    mov dx, word ptr SAVEPROCINT9+2
    mov ds, dx
    mov dx, word ptr SAVEPROCINT9
    int 21H

    pop DS
    pop ES  

    mov ah, 49H
    int 21h

    mov ax, 4C00h
    int 21h

INIT:
    MOV AX, 351ch
    INT 21H
    MOV WORD PTR SAVEPROCINT9, BX
    MOV WORD PTR SAVEPROCINT9+2, ES

    MOV AX, 251ch
    MOV DX, OFFSET MY_FUNC
    INT 21H

    MOV DX, OFFSET INIT
    INT 27H

MAIN ENDP
END MAIN