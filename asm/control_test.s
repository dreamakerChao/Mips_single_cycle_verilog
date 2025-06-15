    .text
    .globl main

main:
    j label
    jal label

    beq $t0, $t1, label
    bne $t0, $t1, label
    blez $t0, label
    bgtz $t0, label
    bltz $t0, label

    addi  $t0, $t1, 10
    addiu $t0, $t1, 10
    slti  $t0, $t1, 5
    sltiu $t0, $t1, 5
    andi  $t0, $t1, 0xF0F0
    ori   $t0, $t1, 0x00FF
    xori  $t0, $t1, 0x0F0F
    lui   $t0, 0x1234

    lb   $t0, 0($t1)
    lh   $t0, 0($t1)
    lwl  $t0, 0($t1)
    lw   $t0, 0($t1)
    lbu  $t0, 0($t1)
    lhu  $t0, 0($t1)
    lwr  $t0, 0($t1)

    sb   $t0, 0($t1)
    sh   $t0, 0($t1)
    swl  $t0, 0($t1)
    sw   $t0, 0($t1)
    swr  $t0, 0($t1)

    sll   $t0, $t1, 2
    srl   $t0, $t1, 2
    sra   $t0, $t1, 2
    sllv  $t0, $t1, $t2
    srlv  $t0, $t1, $t2
    srav  $t0, $t1, $t2

    jr    $ra
    jalr  $t0, $ra

    mfhi  $t0
    mthi  $t0
    mflo  $t0
    mtlo  $t0

    mult  $t0, $t1
    multu $t0, $t1
    div   $t0, $t1
    divu  $t0, $t1

    add   $t0, $t1, $t2
    addu  $t0, $t1, $t2
    sub   $t0, $t1, $t2
    subu  $t0, $t1, $t2
    and   $t0, $t1, $t2
    or    $t0, $t1, $t2
    xor   $t0, $t1, $t2
    nor   $t0, $t1, $t2
    slt   $t0, $t1, $t2
    sltu  $t0, $t1, $t2

label:
    nop
