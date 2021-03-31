PUBLIC read_bin_sign

PUBLIC sign
PUBLIC UNSIGNEDOCT
PUBLIC SBHVALUE
PUBLIC SBLVALUE
PUBLIC SIGNEDHEX
PUBLIC HEXTABLE

SEGDATA SEGMENT PARA PUBLIC 'DATA'
    sign    DB '+'
    SBHVALUE DB 00000000B
    SBLVALUE DB 00000000B

    UNSIGNEDOCT DB 5 dup (0), "$"
    SIGNEDHEX DB 4 dup (0), "$"

    HEXTABLE DB "0123456789ABCDEF$"

    msg_in db "Enter binary digit with sign(max 16 digits): $"
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:SEGDATA

read_bin_sign proc near
    mov ah, 9
    mov dx, offset msg_in
    int 21h

    mov ah, 1
    int 21H
    MOV SIGN, AL
    MOV SBHVALUE, 00000000B
    MOV SBLVALUE, 00000000B

    mov cx, 8
    READ_SYMB:
        MOV AH, 1
        INT 21H
        CMP AL, 13
        JE FINISHSWITCH
        SUB AL, "0"
        SHL SBHVALUE, 1
        ADD SBHVALUE, AL
        LOOP READ_SYMB
    READ_SYMBL:
        MOV AH, 1
        INT 21H
        CMP AL, 13
        JE FINISH
        SUB AL, "0"
        SHL SBLVALUE, 1
        ADD SBLVALUE, AL
        JMP READ_SYMBL
FINISHSWITCH:
        MOV BL, SBHVALUE
        MOV SBLVALUE, BL
        MOV SBHVALUE, 0
    FINISH:
    RET
read_bin_sign ENDP


SEGCODE ENDS
END