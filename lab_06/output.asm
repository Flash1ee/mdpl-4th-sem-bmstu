public print_bin_sign
public print_oct_unsign

EXTRN sign:BYTE
EXTRN SBHVALUE:BYTE

EXTRN SBLVALUE:BYTE
EXTRN UNSIGNEDOCT: BYTE
EXTRN SIGNEDHEX: BYTE

EXTRN to_oct:near
EXTRN to_hex:near

SEGDATA SEGMENT PARA PUBLIC 'DATA'
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE

print_oct_unsign proc near
    call to_oct
    MOV AH, 2
    MOV DL, 10
    INT 21h
    MOV DL, 13
    INT 21H
    MOV AH, 2
    MOV DL, SIGN
    INT 21H
    MOV AH, 9
    MOV DX, OFFSET UNSIGNEDOCT
    INT 21h

    MOV AH, 2
    MOV DL, 10
    INT 21h
    MOV DL, 13
    INT 21H
    RET

    ; cmp sign, "-"
    ; je reverse
    ; call to_oct
    ; jmp output
    ; RET
    ; reverse:
    ;     NOT SBHVALUE
    ;     NOT SBLVALUE
    ;     ADD SBLVALUE, 1
    ;     CMP SBLVALUE, 00000000B
    ;     JE ADD_BH
    ;     CALL to_oct
    ;     SUB SBLVALUE, 1
    ;     NOT SBLVALUE
    ;     NOT SBHVALUE
    ;     jmp output
    ;     ADD_BH:
    ;         ADD SBHVALUE, 1
    ;         CALL to_oct
    ;         SUB SBHVALUE, 1
    ;         SUB SBLVALUE, 1
    ;         NOT SBHVALUE
    ;     output:
    ;         MOV AH, 2
    ;         MOV DL, 10
    ;         INT 21h
    ;         MOV DL, 13
    ;         INT 21H
    ;         MOV AH, 2
    ;         MOV DL, SIGN
    ;         INT 21H
    ;         MOV AH, 9
    ;         MOV DX, OFFSET UNSIGNEDOCT
    ;         INT 21h

    ;         MOV AH, 2
    ;         MOV DL, 10
    ;         INT 21h
    ;         MOV DL, 13
    ;         INT 21H
    ;         RET
print_oct_unsign endp

print_hex proc near 
    MOV AH, 2
    MOV DL, SIGN
    INT 21h
    CALL TO_HEX
    MOV AH, 9
    MOV DX, OFFSET SIGNEDHEX
    INT 21H
    MOV AH, 2
    MOV DL, 10
    INT 21h
    MOV DL, 13
    INT 21H
    RET
print_hex endp

print_bin_sign proc near 
    MOV AH, 2
    MOV DL, SIGN
    INT 21H
    MOV CX, 8
    MOV SI, 0
    MOV AH, 2
    PRINT_SH_B:
        MOV BL, SBHVALUE
        AND BL, 10000000B
        MOV CL,7
        SHR BL, CL
        ADD BL, "0"
        MOV DL, BL
        INT 21h
        MOV BL, SBHVALUE
        AND BL, 01000000B
        MOV CL,6
        SHR BL, CL
        ADD BL, "0"
        MOV DL, BL
        INT 21h
        MOV BL, SBHVALUE
        AND BL, 00100000B
        MOV CL,5
        SHR BL, CL
        ADD BL, "0"
        MOV DL, BL
        INT 21h
        MOV BL, SBHVALUE
        AND BL, 00010000B
        MOV CL,4
        SHR BL, CL
        ADD BL, "0"
        MOV DL, BL
        INT 21h
        MOV BL, SBHVALUE
        AND BL, 00001000B
        MOV CL,3
        SHR BL, CL
        ADD BL, "0"
        MOV DL, BL
        INT 21h
        MOV BL, SBHVALUE
        AND BL, 00000100B
        MOV CL,2
        SHR BL, CL
        ADD BL, "0"
        MOV DL, BL
        INT 21h
        MOV BL, SBHVALUE
        AND BL, 00000010B
        MOV CL,1
        SHR BL, CL
        ADD BL, "0"
        MOV DL, BL
        INT 21h
        MOV BL, SBHVALUE
        AND BL, 00000001B
        ADD BL, "0"
        MOV DL, BL
        INT 21h
    PRINT_SH_L:
        MOV BL, SBLVALUE
        AND BL, 10000000B
        MOV CL,7
        SHR BL, CL
        ADD BL, "0"
        MOV DL, BL
        INT 21h
        MOV BL, SBLVALUE
        AND BL, 01000000B
        MOV CL,6
        SHR BL, CL
        ADD BL, "0"
        MOV DL, BL
        INT 21h
        MOV BL, SBLVALUE
        AND BL, 00100000B
        MOV CL,5
        SHR BL, CL
        ADD BL, "0"
        MOV DL, BL
        INT 21h
        MOV BL, SBLVALUE
        AND BL, 00010000B
        MOV CL,4
        SHR BL, CL
        ADD BL, "0"
        MOV DL, BL
        INT 21h
        MOV BL, SBLVALUE
        AND BL, 00001000B
        MOV CL,3
        SHR BL, CL
        ADD BL, "0"
        MOV DL, BL
        INT 21h
        MOV BL, SBLVALUE
        AND BL, 00000100B
        MOV CL,2
        SHR BL, CL
        ADD BL, "0"
        MOV DL, BL
        INT 21h
        MOV BL, SBLVALUE
        AND BL, 00000010B
        MOV CL,1
        SHR BL, CL
        ADD BL, "0"
        MOV DL, BL
        INT 21h
        MOV BL, SBLVALUE
        AND BL, 00000001B
        ADD BL, "0"
        MOV DL, BL
        INT 21h
    MOV DL, 10
    INT 21h
    MOV DL, 13
    INT 21H
    RET
print_bin_sign endp

SEGCODE ENDS
END