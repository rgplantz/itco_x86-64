	.file	"echoSInt.s"
	.intel_syntax noprefix
# Stack frame
        .equ    myString,-32
        .equ    myInt, -12
        .equ    canary,-8
        .equ    localSize,-32
	.section	.rodata
prompt:
        .string "Enter a signed integer: "
.LC1:
	.string	"You entered: "
.LC2:
	.string	"\n"
	.text
	.globl	main
	.type	main, @function
main:
        push    rbp         # save frame pointer
        mov     rbp, rsp    # set new frame pointer
        add     rsp, localSize  # for local var.
        mov     rax, qword ptr fs:40    # get canary
        mov     qword ptr canary[rbp], rax

        lea     rdi, prompt[rip]
        call    writeStr@plt
        
        mov     esi, 5
        mov     rdi, myString[rbp]
        call	readLn@plt
        lea     rdi, myString[rbp]
        lea     rsi, myInt[rbp]
        call    decToUInt@plt
	
        mov     eax, 0      # return 0;
        mov     rcx, qword ptr canary[rbp]
        xor     rcx, qword ptr fs:40
        je      allOK
        call    __stack_chk_fail@plt
allOK:
        mov     rsp, rbp    # restore stack pointer
        pop     rbp         # and caller frame pointer
        ret

