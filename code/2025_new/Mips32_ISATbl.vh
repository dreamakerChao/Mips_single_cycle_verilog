`ifndef MIPS32_ISATBL_VH
`define MIPS32_ISATBL_VH

// -----------------------------------------------------------------------------
//  Primary opcodes (6 bits) - I-type, J-type, memory access
// -----------------------------------------------------------------------------
`define OP_SPECIAL       6'h00  // R-type
`define OP_REGIMM        6'h01  // REGIMM: BLTZ, BGEZ, ...
`define OP_J             6'h02
`define OP_JAL           6'h03
`define OP_BEQ           6'h04
`define OP_BNE           6'h05
`define OP_BLEZ          6'h06
`define OP_BGTZ          6'h07
`define OP_ADDI          6'h08
`define OP_ADDIU         6'h09
`define OP_SLTI          6'h0A
`define OP_SLTIU         6'h0B
`define OP_ANDI          6'h0C
`define OP_ORI           6'h0D
`define OP_XORI          6'h0E
`define OP_LUI           6'h0F

`define OP_LB            6'h20
`define OP_LH            6'h21
`define OP_LWL           6'h22
`define OP_LW            6'h23
`define OP_LBU           6'h24
`define OP_LHU           6'h25
`define OP_LWR           6'h26

`define OP_SB            6'h28
`define OP_SH            6'h29
`define OP_SWL           6'h2A
`define OP_SW            6'h2B
`define OP_SWR           6'h2E

// -----------------------------------------------------------------------------
// REGIMM rt field definitions (when opcode == 0x01)
// -----------------------------------------------------------------------------
`define RT_BLTZ          5'h00

// -----------------------------------------------------------------------------
// Function field values for R-type (SPECIAL) instructions
// -----------------------------------------------------------------------------
`define FN_SLL           6'h00
`define FN_SRL           6'h02
`define FN_SRA           6'h03
`define FN_SLLV          6'h04
`define FN_SRLV          6'h06
`define FN_SRAV          6'h07
`define FN_JR            6'h08
`define FN_JALR          6'h09
`define FN_MFHI          6'h10
`define FN_MTHI          6'h11
`define FN_MFLO          6'h12
`define FN_MTLO          6'h13
`define FN_MULT          6'h18
`define FN_MULTU         6'h19
`define FN_DIV           6'h1A
`define FN_DIVU          6'h1B
`define FN_ADD           6'h20
`define FN_ADDU          6'h21
`define FN_SUB           6'h22
`define FN_SUBU          6'h23
`define FN_AND           6'h24
`define FN_OR            6'h25
`define FN_XOR           6'h26
`define FN_NOR           6'h27
`define FN_SLT           6'h2A
`define FN_SLTU          6'h2B

`endif // MIPS32_ISATBL_VH
