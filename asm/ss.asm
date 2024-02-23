fact:
    addi $sp, $sp, -8         # allocate 8 bytes to this stack
    sw $ra, 0($sp)            # save return address in stack
    sw $a0, 4($sp)            # save argument value in stack

    slti $t0, $a0, 1          # if n < 1 then $t0 = 1, else $t0 = 0
    beq $t0, $zero, L1        # if $t0 == 0 then jump to branch L1
    addi $v0, $zero, 1        # let $v0 be 1
    addi $sp, $sp, 8          # let $sp point to upper stack
    jr $ra                    # jump to the next line of the line calling fib

L1:
    addi $a0, $a0, -1         # n = n - 1
    jal fact                  # jump fact again, like as returning F(n - 1)
    lw $a0, 4($sp)            # recover the value of argument
    lw $ra, 0($sp)            # recover return address
    mul $v0, $a0, $v0         # $v0 *= $a0, like as F(n) = n * F(n - 1)
    addi, $sp, $sp, 8         # let $sp point to upper stack
    jr $ra                    # jump to the next line of the line calling L1

exit:
