; Ввод: 
; знаковое в 2 с/с
; Вывод: 
; беззнаковое в 8 с/с
; знаковое в 16 с/с
EXTRN read_bin_sign: near
EXTRN print_bin_sign: near
EXTRN print_oct_unsign: near
EXTRN print_hex: near


STK SEGMENT PARA STACK 'STACK'
	    DB 200 dup (0)
STK ENDS

SEGDATA SEGMENT PARA PUBLIC 'DATA'
	menu_print  DB "1. Input sign num in binary format"
	        DB 10
	        DB 13
	        DB "2. Output num in binary format"
	        DB 10
	        DB 13
	        DB "3. Output num in unsigned oct format"
	        DB 10
	        DB 13
	        DB "4. Output num in signed hex format"
	        DB 10
	        DB 13
	        DB "5. Exit"
	        DB 10
	        DB 13
	        DB "Enter mode: $"
	actions DW read_bin_sign, print_bin_sign, print_oct_unsign, print_hex, exit
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC "CODE"
	ASSUME CS:SEGCODE, DS:SEGDATA, SS:STK
    

main:   
    mov    AX, SEGDATA
    mov    DS, AX
    ; mov actions[0], read_bin_sign
    ; mov actions[2], print_bin_sign
    ; mov actions[4], print_oct_unsign
    ; mov actions[10], exit

    menu:
        mov    ah, 9
        mov    dx, offset menu_print
        int    21h

        mov     ah, 1
        int     21h

        mov ah, 0
        sub al, "1"
        mov dl, 2
        mul dl
        mov bx, ax

        ;newline
        mov ah, 2
        mov dl, 10
        int 21H
        mov dl, 13
        int 21H

        call actions[bx]

    jmp menu

newline:
    mov ah, 2
    mov dl, 10
    int 21H
    mov dl, 13
    int 21H

exit:
    mov ax, 4c00h
    int 21h

SEGCODE ENDS
END main


