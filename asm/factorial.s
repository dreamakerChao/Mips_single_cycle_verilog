.text
.globl _start
.set noreorder

_start:
    addi $a0, $zero, 5        # let the argument be 5
    jal fact                  # jump to fact
    j exit

fact:
    addi $sp, $sp, -8         # allocate stack
    sw $ra, 0($sp)            # save return address
    sw $a0, 4($sp)            # save argument

    slti $t0, $a0, 1          # if n < 1 then $t0 = 1
    beq $t0, $zero, L1        # if $t0 == 0 jump to L1
    addi $v0, $zero, 1        # $v0 = 1
    addi $sp, $sp, 8          # restore stack
    jr $ra

L1:
    addi $a0, $a0, -1         # n = n - 1
    jal fact                  # call fact(n-1)
    lw $a0, 4($sp)            # restore argument
    mul $v0, $v0, $a0         # $v0 *= $a0
    lw $ra, 0($sp)            # restore return address
    addi $sp, $sp, 8          # restore stack
    jr $ra

exit:
    nop
    j exit
