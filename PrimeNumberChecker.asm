.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
Include Irvine32.inc

.data
 ;Declaring Data to print

 main_message db "Prime Number Checker in x86 Assembly", 0
 input_message db "Please enter a number: ", 0
 prime_message db "The number is `PRIME`.", 0
 not_prime_message db "The number is `NOT PRIME`.", 0
 exit_message db "Exiting...", 0

.code
main PROC
    ; Main Runner Code

    ; Print the input message
    mov edx, OFFSET main_message
    call WriteString

    ; new line
    call Crlf

    ; Print the input message
    mov edx, OFFSET input_message
    call WriteString

    ; Read the input number from user and store it in EAX
    call ReadInt

    ; new line
    call Crlf

    ; If number is equal to 1 then jump to not_prime function
    cmp eax, 1
    jle not_prime

    ; If number is equal to 2 then jump to is_prime function
    cmp eax, 2
    je is_prime

    ; If number is even then jumpzero to not_prime
    test eax, 1
    jz not_prime

    ; Initialize counter in the ECX register
    mov ecx, 3

check_divisor:
    ; Check if the counter is greater than the square root of the number
    mov edx, ecx
    imul edx, edx
    cmp edx, eax
    jg is_prime

    ; Check if the number is divisible by the counter
    xor edx, edx
    idiv ecx
    cmp edx, 0
    je not_prime

    ; Increment the counter by 2
    add ecx, 2
    jmp check_divisor

is_prime:
    ; Print the prime message
    mov edx, OFFSET prime_message
    call WriteString
    jmp exit_kerdo

not_prime:
    ; Print the not prime message
    mov edx, OFFSET not_prime_message
    call WriteString

    ; new line
    call Crlf

exit_kerdo:
    ; new line
    call Crlf

    mov edx, OFFSET exit_message
    call WriteString

    ; new line
    call Crlf

INVOKE ExitProcess, 0
main ENDP
END main