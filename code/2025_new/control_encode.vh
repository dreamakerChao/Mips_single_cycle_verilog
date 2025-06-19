`ifndef CONTROL_ENCODE_VH
`define CONTROL_ENCODE_VH

// -----------------------------------------------------------------------------
// Bit positions for control word [24:0]
// -----------------------------------------------------------------------------
`define CTRL_HI_WRITE    25
`define CTRL_HI_READ     24
`define CTRL_LO_WRITE    23
`define CTRL_LO_READ     22
`define CTRL_IFUNSIGNED  21
`define CTRL_REGDST      20
`define CTRL_ALUSRC      19
`define CTRL_MEMTOREG    18
`define CTRL_REGWRITE    17
`define CTRL_MEMREAD     16
`define CTRL_MEMWRITE    15
`define CTRL_BRANCH      13:11
`define CTRL_JUMP        10
`define CTRL_LINKED       9
`define CTRL_RETURN       8
`define CTRL_ALUOP       7:4
`define CTRL_SHIFTV       3
`define CTRL_DATA_TYPE    2:0

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
`define ALU_NONE  4'd0
`define ALU_AND   4'd1
`define ALU_OR    4'd2
`define ALU_XOR   4'd3
`define ALU_NOR   4'd4

`define ALU_ADD   4'd5
`define ALU_SUB   4'd6
`define ALU_LT    4'd7

`define ALU_SLL   4'd8
`define ALU_SRL   4'd9
`define ALU_SRA   4'd10

`define ALU_MUL   4'd11
`define ALU_DIV   4'd12


// -----------------------------------------------------------------------------
// Data type constants
// -----------------------------------------------------------------------------
`define DATA_TYPE_WORD     3'd0
`define DATA_TYPE_HALF     3'd1
`define DATA_TYPE_BYTE     3'd2
`define DATA_TYPE_WORDL    3'd3  // Load Word Left
`define DATA_TYPE_WORDR    3'd4  // Load Word Right

// -----------------------------------------------------------------------------
// Control word constants for each instruction
// (These were generated from previous mappings)
// -----------------------------------------------------------------------------

// Control signals for instruction
`define J       25'b0000000000000010000000000
`define JAL     25'b0000000010000011000000000
`define BEQ     25'b0000000000000100000000000
`define BNE     25'b0000000000001000000000000
`define BLEZ    25'b0000000000001100000000000
`define BGTZ    25'b0000000000010000000000000
`define ADDI    25'b0000001010000000001010000
`define ADDIU   25'b0000101010000000001010000
`define SLTI    25'b0000001010000000001110000
`define SLTIU   25'b0000101010000000001110000
`define ANDI    25'b0000001010000000000010000
`define ORI     25'b0000001010000000000100000
`define XORI    25'b0000001010000000000110000
`define LUI     25'b0000001010000000000010000

`define LB      25'b0000001111000000001010010
`define LH      25'b0000001111000000001010001
`define LWL     25'b0000001111000000001010011
`define LW      25'b0000001111000000001010000
`define LBU     25'b0000101111000000001010010
`define LHU     25'b0000101111000000001010001
`define LWR     25'b0000001111000000001010100

`define SB      25'b0000001000100000001010010
`define SH      25'b0000001000100000001010001
`define SWL     25'b0000001000100000001010011
`define SW      25'b0000001000100000001010000
`define SWR     25'b0000001000100000001010100

`define BLTZ    25'b0000000000010100000000000
`define BGEZ    25'b0000000000011000000000000

`define SLL     25'b0000010010000000010000000
`define SRL     25'b0000010010000000010010000
`define SRA     25'b0000010010000000010100000
`define SLLV    25'b0000010010000000010001000
`define SRLV    25'b0000010010000000010011000
`define SRAV    25'b0000010010000000010101000
`define JR      25'b0000000000000010100000000
`define JALR    25'b0000010010000011100000000
`define MFHI    25'b0100010010000000000000000
`define MTHI    25'b1000000000000000000000000
`define MFLO    25'b0001010010000000000000000
`define MTLO    25'b0010000000000000000000000
`define MULT    25'b1010010000000000010110000
`define MULTU   25'b1010110000000000010110000
`define DIV     25'b1010010000000000011000000
`define DIVU    25'b1010110000000000011000000
`define ADD     25'b0000010010000000001010000
`define ADDU    25'b0000110010000000001010000
`define SUB     25'b0000010010000000001100000
`define SUBU    25'b0000110010000000001100000
`define AND     25'b0000010010000000000010000
`define OR      25'b0000010010000000000100000
`define XOR     25'b0000010010000000000110000
`define NOR     25'b0000010010000000001000000
`define SLT     25'b0000010010000000001110000
`define SLTU    25'b0000110010000000001110000




`endif
