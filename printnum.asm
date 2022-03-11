section .bss
    digitSpace resb 100
    digitSpacePos resb 4
 
section .data
 
section .text
    global _start
 
_start:
 
    mov eax, 84 ; value that will be printed
    call _printEAX
 
    mov eax, 60
    mov edi, 0
    int 0x80
 
 
_printEAX:
    mov ecx, digitSpace
    mov ebx, 10
    mov [ecx], ebx
    inc ecx
    mov [digitSpacePos], ecx
 
_printEAXLoop:
    mov edx, 0
    mov ebx, 10
    div ebx
    push eax
    add edx, 48
 
    mov ecx, [digitSpacePos]
    mov [ecx], dl
    inc ecx
    mov [digitSpacePos], ecx
    
    pop eax
    cmp eax, 0
    jne _printEAXLoop
 
_printEAXLoop2:
    
    mov eax, SYS_WRITE 
    mov ebx, FD_STDOUT
    mov ecx, [digitSpacePos] ; adress of where the text to print starts
    mov edx, 1 ;; count of bytes to print 
    int 0x80 ; system call
    
 
    mov ecx, [digitSpacePos]
    dec ecx
    mov [digitSpacePos], ecx
 
    cmp ecx, digitSpace
    jge _printEAXLoop2
 
 
 exit:
    mov eax, 1 ;; prep system exit call
    mov ebx, 0 ; return 0
    int 0x80 ; system call 
    
    
; symbols defined: 
    SYS_WRITE equ 4 
    FD_STDOUT equ 1 
