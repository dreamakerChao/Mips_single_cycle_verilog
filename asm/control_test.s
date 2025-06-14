J 0x00400000
JAL 0x00400020
BEQ $t0, $t1, label
BNE $t0, $t1, label
BLEZ $t0, label
BGTZ $t0, label
ADDI $t0, $t1, 5
ADDIU $t0, $t1, 5
SLTI $t0, $t1, 5
SLTIU $t0, $t1, 5
ANDI $t0, $t1, 0x00FF
ORI $t0, $t1, 0x00FF
XORI $t0, $t1, 0x00FF
LUI $t0, 0x1234
LB $t0, 4($t1)
LH $t0, 4($t1)
LW $t0, 4($t1)
LBU $t0, 4($t1)
LHU $t0, 4($t1)
LWL $t0, 0($t1)
LWR $t0, 0($t1)
SB $t0, 4($t1)
SH $t0, 4($t1)
SW $t0, 4($t1)
SWL $t0, 0($t1)
SWR $t0, 0($t1)
BLTZ $t0, label
SLL $t0, $t1, 2
SRL $t0, $t1, 2
SRA $t0, $t1, 2
SLLV $t0, $t1, $t2
SRLV $t0, $t1, $t2
SRAV $t0, $t1, $t2
JR $ra
JALR $t0, $t1
MOVZ $t0, $t1, $t2
MOVN $t0, $t1, $t2
MFHI $t0
MTHI $t0
MFLO $t0
MTLO $t0
MULT $t0, $t1
MULTU $t0, $t1
DIV $t0, $t1
DIVU $t0, $t1
ADD $t0, $t1, $t2
ADDU $t0, $t1, $t2
SUB $t0, $t1, $t2
SUBU $t0, $t1, $t2
AND $t0, $t1, $t2
OR $t0, $t1, $t2
XOR $t0, $t1, $t2
NOR $t0, $t1, $t2
SLT $t0, $t1, $t2
SLTU $t0, $t1, $t2
label: nop
