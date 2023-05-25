Include Irvine32.inc

.DATA
    msgBinaryToDecimal  BYTE " Hamza Haroon's Binary to (Hexa)Decimal Convertor", 0
    msgBinary           BYTE " Enter a Binary Number = ", 0   
    msgDecimalNumber    BYTE " Decimal     (Base 10) = ", 0
    msgHexNumber        BYTE " Hexadecimal (Base 16) = ", 0
    msgNotBinary        BYTE " Invalid Binary! Only 0's and 1's are allowed.", 0
    msgInputError       BYTE " Invalid input! Please enter a binary number.", 0
    msgLengthError      BYTE " Invalid input length! The maximum length is 32 characters.", 0

    binaryNumber        BYTE 33 DUP(?)    ; 32 characters for 32-bit Binary
    DecimalNumber       DWORD ?

    NumberLength        DWORD 0
    base                DWORD 2           ; Base of Binary Number
    OuterLoopCount      DWORD 0

.CODE
main PROC
    mov edx, OFFSET msgBinaryToDecimal
    call WriteString
    call Crlf

    mov edx, OFFSET msgBinary
    call WriteString

    mov edx, OFFSET binaryNumber
    mov ecx, SIZEOF binaryNumber    ; Length of binaryNumber
    call ReadString                 ; Reads a string
    mov NumberLength, eax           ; Number of characters read

    ; Validate input length
    cmp NumberLength, 1              ; Check if the length is less than 1
    jl InputError
    cmp NumberLength, 33             ; Check if the length exceeds the maximum allowed length
    jg LengthError

    ; Find Decimal Number
    mov eax, 0
    mov esi, 0                      ; ESI initialize with zero
    mov ecx, NumberLength           ; ECX initialize with length of Number

whilePart:
    cmp ecx, 0                      ; Compare ECX and 0
    je displayNumbers               ; Jump if number is 0
    mov OuterLoopCount, ecx

ifPart:
    cmp binaryNumber[esi], '0'      ; Compare binaryNumber[esi] and '0'
    je IncEsi                      ; Jump if equal (==)

    cmp binaryNumber[esi], '1'      ; Compare binaryNumber[esi] and '1'
    jne elsePart                   ; If not equal, it is an invalid binary digit

    ; Calculate pow(base, NumberLength - ESI - 1) and add them to eax
    mov ecx, NumberLength
    sub ecx, esi
    dec ecx

    ; Calculate Power
    mov eax, 1                      ; EAX initialize with 1

whilePart2:
    cmp ecx, 0                      ; Compare ECX and 0
    je stop                         ; Jump if equal (==)

    ; Multiply EAX and EBX and save the result in EAX
    mov ebx, base
    mul ebx
    dec ecx
    jmp whilePart2
    ; Calculate Power finish

stop:
    add DecimalNumber, eax
    jmp IncEsi

elsePart:
    mov edx, OFFSET msgNotBinary    ; "Invalid Binary Number! Binary Number Contains only 0's or 1's"
    call WriteString
    call Crlf
    call WaitMsg                    ; Display a message and wait for a key to be pressed
    exit                            ; Exit program

InputError:
    mov edx, OFFSET msgInputError   ; "Invalid input! Please enter a binary number."
    call WriteString
    call Crlf
    call WaitMsg                    ; Display a message and wait for a key to be pressed
    exit                            ; Exit program

LengthError:
    mov edx, OFFSET msgLengthError  ; "Invalid input length! The maximum length is 32 characters."
    call WriteString
    call Crlf
    call WaitMsg                    ; Display a message and wait for a key to be pressed
    exit                            ; Exit program

IncEsi:
    inc esi
    mov ecx, OuterLoopCount
    dec ecx
    jmp whilePart

displayNumbers:
    mov edx, OFFSET msgDecimalNumber
    call WriteString

    mov edx, 0
    mov eax, DecimalNumber
    call WriteDec

    call Crlf

    mov edx, OFFSET msgHexNumber
    call WriteString

    mov edx, 0
    mov eax, DecimalNumber
    call WriteHex

    call Crlf
    call WaitMsg
    exit

main ENDP
END main
