# displayRecord.s
# Displays contents of a record.
# Calling sequence:
#   rdi <- pointer to record
        .intel_syntax noprefix
# Record field offsets
        .include    "aRecord"
# Useful constant
        .equ    STDOUT,1
# Constant data
        .section	.rodata
        .align 8
endl:
        .string "\n"
# Code
        .text
        .globl  displayRecord
        .type   displayRecord, @function
displayRecord:
        push    rbp         # save frame pointer
        mov     rbp, rsp    # set new frame pointer
        
        mov     r12, rdi    # perserved in function call

        mov     edx, 1      # write one character
        lea     rsi, aChar[r12] # located here
        mov     edi, STDOUT # to screen
        call    write@plt
        lea     rdi, endl[rip]  # new line
        call    writeStr
        
        mov     edi,anInt[r12]  # get the integer
        call    putInt          # write to screen
        lea     rdi, endl[rip]
        call    writeStr
        
        mov     edx, 1      # second character
        lea     rsi, anotherChar[r12]
        mov     edi, STDOUT
        call    write@plt
        lea     rdi, endl[rip]
        call    writeStr

        mov     rsp, rbp    # restore stack pointer
        pop     rbp         # and caller frame pointer
        ret

