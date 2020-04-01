# RISC-V baremetal init.s
# This code is executed first.

.section .text.init
.global  entry
entry:

#set divisor (0x68 = 104 = 12MHz/115.2Kbps, 0x1b2 = 434 = 50MHz/115.2Kbps)
#            (0x364  = 868 = 100MHz/115.2Kbps) - 1
    lui a0, 0x00020
    li a1, 434
    sw a1, 0x10(a0)

    lui gp, %hi(_sdata+0x800)
    addi gp, gp, %lo(_sdata+0x800)
    lui tp, %hi(_sdata+0x1000)
    addi tp, tp, %lo(_sdata+0x1000)


    la    sp, _stack_pointer-32   # set up the stack pointer, using a constant defined in the linker script.

    la    t0, end       # on hardware, ECALL doesn't stop the CPU, so define
                        # a handler to catch the ECALL and spin
    csrw  0x305, t0     # set the address of the handler (CSR 0x305 is the trap handler base register)

    call  main          # call the main function
    ecall               # halt the simluation when it returns

end:
    j end               # loop when finished if there is no environment to return to.
