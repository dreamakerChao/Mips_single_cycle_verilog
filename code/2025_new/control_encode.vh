`ifndef CONTROL_ENCODE_VH
`define CONTROL_ENCODE_VH

// -----------------------------------------------------------------------------
// Bit positions for control word [21:0]
// -----------------------------------------------------------------------------
`define CTRL_HI_WRITE    21
`define CTRL_HI_READ     20
`define CTRL_LO_WRITE    19
`define CTRL_LO_READ     18
`define CTRL_IFUNSIGNED  17
`define CTRL_REGDST      16
`define CTRL_ALUSRC      15
`define CTRL_MEMTOREG    14
`define CTRL_REGWRITE    13
`define CTRL_MEMREAD     12
`define CTRL_MEMWRITE    11
`define CTRL_BRANCH      10
`define CTRL_JUMP         9
`define CTRL_LINKED       8
`define CTRL_RETURN       7
`define CTRL_ALUOP       6:3
`define CTRL_SHIFTV       2
`define CTRL_DATA_TYPE    1:0

// -----------------------------------------------------------------------------
// ALU operation codes
// -----------------------------------------------------------------------------
`define ALU_AND    4'd0
`define ALU_OR     4'd1
`define ALU_XOR    4'd2
`define ALU_NOR    4'd3
`define ALU_ADD    4'd4
`define ALU_SUB    4'd5
`define ALU_EQ     4'd6
`define ALU_GT     4'd7
`define ALU_LT     4'd8
`define ALU_GE     4'd9
`define ALU_LE     4'd10
`define ALU_SRL    4'd11
`define ALU_SRA    4'd12
`define ALU_SLL    4'd13
`define ALU_MUL    4'd14
`define ALU_DIV    4'd15

// -----------------------------------------------------------------------------
// Data type constants
// -----------------------------------------------------------------------------
`define DATA_TYPE_WORD  2'b00
`define DATA_TYPE_HALF  2'b01
`define DATA_TYPE_BYTE  2'b10

// -----------------------------------------------------------------------------
// Control word constants for each instruction
// (These were generated from previous mappings)
// -----------------------------------------------------------------------------

// Control signals for instruction
`define CTRL_J     22'b0000000000001000000000
`define CTRL_JAL   22'b0000000010001100000000
`define CTRL_BEQ   22'b0000000000010000110000
`define CTRL_BNE   22'b0000000000010000110000
`define CTRL_BLEZ  22'b0000000000010001010000
`define CTRL_BGTZ  22'b0000000000010000111000
`define CTRL_ADDI  22'b0000001010000000100000
`define CTRL_ADDIU 22'b0000101010000000100000
`define CTRL_SLTI  22'b0000001010000001000000
`define CTRL_SLTIU 22'b0000101010000001000000
`define CTRL_ANDI  22'b0000001010000000000000
`define CTRL_ORI   22'b0000001010000000001000
`define CTRL_XORI  22'b0000001010000000010000
`define CTRL_LUI   22'b0000001010000000000000
`define CTRL_LB    22'b0000001111000000100010
`define CTRL_LH    22'b0000001111000000100001
`define CTRL_LWL   22'b0000001111000000100000
`define CTRL_LW    22'b0000001111000000100000
`define CTRL_LBU   22'b0000101111000000100010
`define CTRL_LHU   22'b0000101111000000100001
`define CTRL_LWR   22'b0000001111000000100000
`define CTRL_SB    22'b0000001000100000100010
`define CTRL_SH    22'b0000001000100000100001
`define CTRL_SWL   22'b0000001000100000100000
`define CTRL_SW    22'b0000001000100000100000
`define CTRL_SWR   22'b0000001000100000100000
`define CTRL_BLTZ  22'b0000000000010000101000
`define CTRL_SLL   22'b0000010010000001101000
`define CTRL_SRL   22'b0000010010000001011000
`define CTRL_SRA   22'b0000010010000001100000
`define CTRL_SLLV  22'b0000010010000001101100
`define CTRL_SRLV  22'b0000010010000001011100
`define CTRL_SRAV  22'b0000010010000001100100
`define CTRL_JR    22'b0000000000001010000000
`define CTRL_JALR  22'b0000010010001110000000
`define CTRL_MFHI  22'b0100010010000000000000
`define CTRL_MTHI  22'b1000000000000000000000
`define CTRL_MFLO  22'b0001010010000000000000
`define CTRL_MTLO  22'b0010000000000000000000
`define CTRL_MULT  22'b1010010000000001110000
`define CTRL_MULTU 22'b1010110000000001110000
`define CTRL_DIV   22'b1010010000000001111000
`define CTRL_DIVU  22'b1010110000000001111000
`define CTRL_ADD   22'b0000010010000000100000
`define CTRL_ADDU  22'b0000110010000000100000
`define CTRL_SUB   22'b0000010010000000101000
`define CTRL_SUBU  22'b0000110010000000101000
`define CTRL_AND   22'b0000010010000000000000
`define CTRL_OR    22'b0000010010000000001000
`define CTRL_XOR   22'b0000010010000000010000
`define CTRL_NOR   22'b0000010010000000011000
`define CTRL_SLT   22'b0000010010000001000000
`define CTRL_SLTU  22'b0000110010000001000000




`endif
