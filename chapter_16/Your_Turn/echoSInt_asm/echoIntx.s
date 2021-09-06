# echoInput.s
# Echos user input.
        .intel_syntax noprefix

# Useful contant
        .equ    MAX, 5  # includes NUL char
# Stack frame
#   local vars (rbp)
#     need 10x4 + 8 = 48 -> 48 bytes
        .equ    canary,-8
        .equ    count,-12
        .equ    myString,-64
        .equ    localSize,-64
# Read only data
        .section  .rodata
prompt:
        .string "Enter up to 50 characters: "
newLine:
        .string "\n"
# Code
        .text
        .globl  main
        .type   main, @function
main:
        push    rbp             # save frame pointer
        mov     rbp, rsp        # set new frame pointer
        add     rsp, localSize  # for local var.
        mov     rax, fs:40      # get canary
        mov     canary[rbp], rax  #   and save
        
        lea     rdi, prompt[rip]    # prompt user
        call    writeStr@plt
        
        mov     esi, MAX        # max characters to read
        lea     rdi, myString[rbp]  # where to store them
        call    readLn@plt
	
        lea     rdi, myString[rbp]
        call    writeStr@plt
        
        lea     rdi, newLine[rip]   # some formatting
        call    writeStr@plt

        mov     eax, 0
        mov     rsi, canary[rbp]
        xor     rsi, fs:40
        je      stackGood
        call    __stack_chk_fail@plt
stackGood:
        mov     rsp, rbp        # restore stack pointer
        pop     rbp             # and caller frame pointer
        ret


