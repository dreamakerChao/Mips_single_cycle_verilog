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
`define CTRL_J          25'b0000000000000010000000000
`define CTRL_JAL        25'b0000000010000011000000000
`define CTRL_BEQ        25'b0000000000000100000000000
`define CTRL_BNE        25'b0000000000001000000000000
`define CTRL_BLEZ       25'b0000000000001100000000000
`define CTRL_BGTZ       25'b0000000000010000000000000
`define CTRL_ADDI       25'b0000001010000000001010000
`define CTRL_ADDIU      25'b0000101010000000001010000
`define CTRL_SLTI       25'b0000001010000000001110000
`define CTRL_SLTIU      25'b0000101010000000001110000
`define CTRL_ANDI       25'b0000001010000000000010000
`define CTRL_ORI        25'b0000001010000000000100000
`define CTRL_XORI       25'b0000001010000000000110000
`define CTRL_LUI        25'b0000001010000000000010000

`define CTRL_LB         25'b0000001111000000001010010
`define CTRL_LH         25'b0000001111000000001010001
`define CTRL_LWL        25'b0000001111000000001010011
`define CTRL_LW         25'b0000001111000000001010000
`define CTRL_LBU        25'b0000101111000000001010010
`define CTRL_LHU        25'b0000101111000000001010001
`define CTRL_LWR        25'b0000001111000000001010100

`define CTRL_SB         25'b0000001000100000001010010
`define CTRL_SH         25'b0000001000100000001010001
`define CTRL_SWL        25'b0000001000100000001010011
`define CTRL_SW         25'b0000001000100000001010000
`define CTRL_SWR        25'b0000001000100000001010100

`define CTRL_BLTZ       25'b0000000000010100000000000
`define CTRL_BGEZ       25'b0000000000011000000000000

`define CTRL_SLL        25'b0000010010000000010000000
`define CTRL_SRL        25'b0000010010000000010010000
`define CTRL_SRA        25'b0000010010000000010100000
`define CTRL_SLLV       25'b0000010010000000010001000
`define CTRL_SRLV       25'b0000010010000000010011000
`define CTRL_SRAV       25'b0000010010000000010101000
`define CTRL_JR         25'b0000000000000010100000000
`define CTRL_JALR       25'b0000010010000011100000000
`define CTRL_MFHI       25'b0100010010000000000000000
`define CTRL_MTHI       25'b1000000000000000000000000
`define CTRL_MFLO       25'b0001010010000000000000000
`define CTRL_MTLO       25'b0010000000000000000000000
`define CTRL_MULT       25'b1010010000000000010110000
`define CTRL_MULTU      25'b1010110000000000010110000
`define CTRL_DIV        25'b1010010000000000011000000
`define CTRL_DIVU       25'b1010110000000000011000000
`define CTRL_ADD        25'b0000010010000000001010000
`define CTRL_ADDU       25'b0000110010000000001010000
`define CTRL_SUB        25'b0000010010000000001100000
`define CTRL_SUBU       25'b0000110010000000001100000
`define CTRL_AND        25'b0000010010000000000010000
`define CTRL_OR         25'b0000010010000000000100000
`define CTRL_XOR        25'b0000010010000000000110000
`define CTRL_NOR        25'b0000010010000000001000000
`define CTRL_SLT        25'b0000010010000000001110000
`define CTRL_SLTU       25'b0000110010000000001110000





`endif
