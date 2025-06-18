`ifndef CONTROL_ENCODE_VH
`define CONTROL_ENCODE_VH

// -----------------------------------------------------------------------------
// Bit positions for control word [24:0]
// -----------------------------------------------------------------------------
`define CTRL_HI_WRITE    24
`define CTRL_HI_READ     23
`define CTRL_LO_WRITE    22
`define CTRL_LO_READ     21
`define CTRL_IFUNSIGNED  20
`define CTRL_REGDST      19
`define CTRL_ALUSRC      18
`define CTRL_MEMTOREG    17
`define CTRL_REGWRITE    16
`define CTRL_MEMREAD     15
`define CTRL_MEMWRITE    14
`define CTRL_BRANCH      12:10
`define CTRL_JUMP         9
`define CTRL_LINKED       8
`define CTRL_RETURN       7
`define CTRL_ALUOP       6:3
`define CTRL_SHIFTV       2
`define CTRL_DATA_TYPE    1:0

// -----------------------------------------------------------------------------
// BRANCH operation codes
// -----------------------------------------------------------------------------
`define BR_NONE  3'b000
`define BR_BEQ   3'b001
`define BR_BNE   3'b010
`define BR_BLEZ  3'b011
`define BR_BGTZ  3'b100
`define BR_BLTZ  3'b101
`define BR_BGEZ  3'b110

// -----------------------------------------------------------------------------
// ALU operation codes
// -----------------------------------------------------------------------------
`define ALU_AND   4'd0
`define ALU_OR    4'd1
`define ALU_XOR   4'd2
`define ALU_NOR   4'd3

`define ALU_ADD   4'd4
`define ALU_SUB   4'd5

`define ALU_LT   4'd6

`define ALU_SLL   4'd8
`define ALU_SRL   4'd9
`define ALU_SRA   4'd10

`define ALU_MUL   4'd11
`define ALU_DIV   4'd12
`define ALU_LUI   4'd13


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
`define J       25'b0000000000000010011010000
`define JAL     25'b0000000010000011011010000
`define BEQ     25'b0000000000000100001010000
`define BNE     25'b0000000000001000001010000
`define BLEZ    25'b0000000000001100011010000
`define BGTZ    25'b0000000000010000011010000
`define ADDI    25'b0000001010000000001000000
`define ADDIU   25'b0000101010000000001000000
`define SLTI    25'b0000001010000000001100000
`define SLTIU   25'b0000101010000000001100000
`define ANDI    25'b0000001010000000000000000
`define ORI     25'b0000001010000000000010000
`define XORI    25'b0000001010000000000100000
`define LUI     25'b0000001010000000000000000

`define LB      25'b0000001111000000001000010
`define LH      25'b0000001111000000001000001
`define LWL     25'b0000001111000000001000000
`define LW      25'b0000001111000000001000000
`define LBU     25'b0000101111000000001000010
`define LHU     25'b0000101111000000001000001
`define LWR     25'b0000001111000000001000000

`define SB      25'b0000001000100000001000010
`define SH      25'b0000001000100000001000001
`define SWL     25'b0000001000100000001000000
`define SW      25'b0000001000100000001000000
`define SWR     25'b0000001000100000001000000

`define BLTZ    25'b0000000000010100011010000
`define BGEZ    25'b0000000000011000011010000

`define SLL     25'b0000010010000000001110000
`define SRL     25'b0000010010000000010000000
`define SRA     25'b0000010010000000010010000
`define SLLV    25'b0000010010000000001111000
`define SRLV    25'b0000010010000000010001000
`define SRAV    25'b0000010010000000010011000
`define JR      25'b0000000000000010111010000
`define JALR    25'b0000010010000011111010000
`define MFHI    25'b0100010010000000011010000
`define MTHI    25'b1000000000000000011010000
`define MFLO    25'b0001010010000000011010000
`define MTLO    25'b0010000000000000011010000
`define MULT    25'b1010010000000000010100000
`define MULTU   25'b1010110000000000010100000
`define DIV     25'b1010010000000000010110000
`define DIVU    25'b1010110000000000010110000
`define ADD     25'b0000010010000000001000000
`define ADDU    25'b0000110010000000001000000
`define SUB     25'b0000010010000000001010000
`define SUBU    25'b0000110010000000001010000
`define AND     25'b0000010010000000000000000
`define OR      25'b0000010010000000000010000
`define XOR     25'b0000010010000000000100000
`define NOR     25'b0000010010000000000110000
`define SLT     25'b0000010010000000001100000
`define SLTU    25'b0000110010000000001100000





`endif
