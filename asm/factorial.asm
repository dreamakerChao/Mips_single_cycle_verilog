main:
    addi $a0, $zero, 5        # let the argument be 5 00
    jal fact                  # jump to fib label, like calling F(5) 04
    j exit 08

fact:
    addi $sp, $sp, -8         # allocate 8 bytes to this stack 0c
    sw $ra, 0($sp)            # save return address in stack 10
    sw $a0, 4($sp)            # save argument value in stack 14

    slti $t0, $a0, 1          # if n < 1 then $t0 = 1, else $t0 = 0 18
    beq $t0, $zero, L1        # if $t0 == 0 then jump to branch L1 1c
    addi $v0, $zero, 1        # let $v0 be 1 20
    addi $sp, $sp, 8          # let $sp point to upper stack 24
    jr $ra                    # jump to the next line of the line calling fib 28

L1:
    addi $a0, $a0, -1         # n = n - 1 2c
    jal fact                  # jump fact again, like as returning F(n - 1) 30
    lw $a0, 4($sp)            # recover the value of argument 34
    mul $v0, $a0         # $v0 *= $a0, like as F(n) = n * F(n - 1) 38
    mflo $v0                # 3c
    lw $ra, 0($sp)            # recover return address 40
    addi, $sp, $sp, 8         # let $sp point to upper stack 44
    jr $ra                    # jump to the next line of the line calling L1 48

exit:  #4c
