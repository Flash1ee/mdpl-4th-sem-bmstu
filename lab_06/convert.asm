PUBLIC to_oct
PUBLIC to_hex

EXTRN SBHVALUE:BYTE
EXTRN SBLVALUE:BYTE
EXTRN HEXTABLE:BYTE
EXTRN sign:BYTE

EXTRN UNSIGNEDOCT:BYTE
EXTRN SIGNEDHEX:BYTE


SEGDATA SEGMENT PUBLIC 'DATA'
SEGDATA ENDS

SEGCODE SEGMENT PUBLIC 'CODE'
    ASSUME CS:SEGCODE

to_oct proc near
    cmp sign, "-"
    je reverse
    call convert_to_oct
    RET
    reverse:
        NOT SBHVALUE
        NOT SBLVALUE
        ADD SBLVALUE, 1
        CMP SBLVALUE, 00000000B
        JE ADD_BH
        call convert_to_oct
        SUB SBLVALUE, 1
        NOT SBLVALUE
        NOT SBHVALUE
        RET
        ADD_BH:
            ADD SBHVALUE, 1
            CALL convert_to_oct
            SUB SBHVALUE, 1
            SUB SBLVALUE, 1
            NOT SBHVALUE
            RET
to_oct endp
convert_to_oct proc near
        MOV AL, SBHVALUE
        AND AL, 01110000B
        mov cl, 4
        SHR AL, cl
        ADD AL, "0"
        MOV UNSIGNEDOCT[0], AL
        MOV AL, SBHVALUE
        AND AL, 00001110B
        SHR AL, 1
        ADD AL, "0"
        MOV UNSIGNEDOCT[1], AL
        MOV AL, SBHVALUE
        AND AL, 00000001B
        MOV DL, 4
        MUL DL
        MOV DL, AL
        MOV AL, SBLVALUE
        AND AL, 11000000B
        MOV CL, 2
        ROL AL, CL
        ADD AL, DL
        ADD AL, "0"
        MOV UNSIGNEDOCT[2], AL
        MOV AL, SBLVALUE
        AND AL, 00111000B
        mov cl, 3
        SHR AL, cl
        ADD AL, "0"
        MOV UNSIGNEDOCT[3], AL
        MOV AL, SBLVALUE
        AND AL, 00000111B
        ADD AL, "0"
        MOV UNSIGNEDOCT[4], AL
        RET
convert_to_oct endp
to_hex proc near
    MOV BX, OFFSET HEXTABLE
    MOV AL, SBHVALUE
    MOV CL, 4
    SHR AL, CL
    XLAT ; СМЕЩЕНИЕ ДЛЯ HEXTABLE БЕРЁТСЯ ИЗ AL И КОНВЕРТИРУЕТСЯ AL->HEXTABLE[AL]
    MOV SIGNEDHEX[0], al
    MOV AL, SBHVALUE
    AND AL, 00001111B
    XLAT
    MOV SIGNEDHEX[1], al
    MOV AL, SBLVALUE
    SHR AL, CL
    XLAT
    MOV SIGNEDHEX[2], al
    MOV AL, SBLVALUE
    AND AL, 00001111B
    XLAT
    MOV SIGNEDHEX[3], al
    RET
to_hex endp


SEGCODE ENDS
END