extern GetStdHandle : PROC
extern WriteConsoleA : PROC
extern ExitProcess : PROC

.data
CARRIAGE_RETURN equ 0Dh
LINE_FEED equ 0Ah
STD_OUTPUT_HANDLE equ -11
HELLO_MSG db 'Hello, World!', CARRIAGE_RETURN, LINE_FEED, 0
HELLO_MSG_LEN = sizeof HELLO_MSG

.code
main PROC
    sub rsp, 28h                  ; Allocate shadow space for function calls

    mov rcx, STD_OUTPUT_HANDLE    ; Set up the first argument for GetStdHandle
    call GetStdHandle             ; Get the handle to the console.
    
    mov rcx, rax                  ; Store the handle in rcx
    lea rdx, HELLO_MSG            ; Load address of the message
    mov r8, HELLO_MSG_LEN         ; Num bytes to write
    mov r9, 0                     ; nullptr for the number of bytes written
    call WriteConsoleA            ; Call Windows API to print the message
    
    add rsp, 28h                  ; Clean up stack
    mov rcx, 0                    ; Return zero
    call ExitProcess
main ENDP
END