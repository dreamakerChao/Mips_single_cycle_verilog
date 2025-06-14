`ifndef MIPS32_ISATBL_VH
`define MIPS32_ISATBL_VH

// -----------------------------------------------------------------------------
//  Primary opcodes (6 bits)                                                     
// -----------------------------------------------------------------------------
`define OP_SPECIAL       6'h00 // opcode 0x00 for R‑type instructions
`define OP_CLO           6'h1C // opcode 0x1C Count leading ones
`define OP_J             6'h02 // opcode 0x02 Jump
`define OP_JAL           6'h03 // opcode 0x03 Jump and link
`define OP_BEQ           6'h04 // opcode 0x04 Branch if equal
`define OP_BNE           6'h05 // opcode 0x05 Branch if not equal
`define OP_BLEZ          6'h06 // opcode 0x06 Branch if ≤ 0
`define OP_BGTZ          6'h07 // opcode 0x07 Branch if > 0
`define OP_ADDI          6'h08 // opcode 0x08 Add immediate (signed)
`define OP_ADDIU         6'h09 // opcode 0x09 Add immediate (unsigned)
`define OP_SLTI          6'h0A // opcode 0x0A Set on less than immediate (signed)
`define OP_SLTIU         6'h0B // opcode 0x0B Set on less than immediate (unsigned)
`define OP_ANDI          6'h0C // opcode 0x0C Bitwise AND immediate
`define OP_ORI           6'h0D // opcode 0x0D Bitwise OR immediate
`define OP_XORI          6'h0E // opcode 0x0E Bitwise XOR immediate
`define OP_LUI           6'h0F // opcode 0x0F Load upper immediate
`define OP_LB            6'h20 // opcode 0x20 Load byte
`define OP_LH            6'h21 // opcode 0x21 Load half‑word
`define OP_LW            6'h23 // opcode 0x23 Load word
`define OP_LBU           6'h24 // opcode 0x24 Load byte unsigned
`define OP_LHU           6'h25 // opcode 0x25 Load half‑word unsigned
`define OP_LWL           6'h22 // opcode 0x22 Load word left (unaligned)
`define OP_LWR           6'h26 // opcode 0x26 Load word right (unaligned)
`define OP_SB            6'h28 // opcode 0x28 Store byte
`define OP_SH            6'h29 // opcode 0x29 Store half‑word
`define OP_SW            6'h2B // opcode 0x2B Store word
`define OP_SWL           6'h2A // opcode 0x2A Store word left (unaligned)
`define OP_SWR           6'h2E // opcode 0x2E Store word right (unaligned)
`define OP_LL            6'h30 // opcode 0x30 Load linked
`define OP_SC            6'h38 // opcode 0x38 Store conditional
`define OP_BLTZ          6'h01 // opcode 0x01 Branch if < 0 (rt=0x00)

// -----------------------------------------------------------------------------
//  Function field values for R‑type (SPECIAL / SPECIAL2) instructions           
// -----------------------------------------------------------------------------
`define FN_SLL           6'h00 // funct 0x00 Shift left logical
`define FN_SRL           6'h02 // funct 0x02 Shift right logical
`define FN_SRA           6'h03 // funct 0x03 Shift right arithmetic
`define FN_SLLV          6'h04 // funct 0x04 Variable shift left logical
`define FN_SRLV          6'h06 // funct 0x06 Variable shift right logical
`define FN_SRAV          6'h07 // funct 0x07 Variable shift right arithmetic
`define FN_JR            6'h08 // funct 0x08 Jump register
`define FN_JALR          6'h09 // funct 0x09 Jump and link register
`define FN_MOVZ          6'h0A // funct 0x0A Move if zero
`define FN_MOVN          6'h0B // funct 0x0B Move if non‑zero
`define FN_SYSCALL       6'h0C // funct 0x0C System call
`define FN_BREAK         6'h0D // funct 0x0D Breakpoint
`define FN_SDBBP         6'h0F // funct 0x0F Software debug breakpoint
`define FN_MFHI          6'h10 // funct 0x10 Move from HI
`define FN_MTHI          6'h11 // funct 0x11 Move to HI
`define FN_MFLO          6'h12 // funct 0x12 Move from LO
`define FN_MTLO          6'h13 // funct 0x13 Move to LO
`define FN_MULT          6'h18 // funct 0x18 Multiply (signed)
`define FN_MULTU         6'h19 // funct 0x19 Multiply (unsigned)
`define FN_DIV           6'h1A // funct 0x1A Divide (signed)
`define FN_DIVU          6'h1B // funct 0x1B Divide (unsigned)
`define FN_ADD           6'h20 // funct 0x20 Add (signed)
`define FN_ADDU          6'h21 // funct 0x21 Add (unsigned)
`define FN_SUB           6'h22 // funct 0x22 Subtract (signed)
`define FN_SUBU          6'h23 // funct 0x23 Subtract (unsigned)
`define FN_AND           6'h24 // funct 0x24 Bitwise AND
`define FN_OR            6'h25 // funct 0x25 Bitwise OR
`define FN_XOR           6'h26 // funct 0x26 Bitwise XOR
`define FN_NOR           6'h27 // funct 0x27 Bitwise NOR
`define FN_SLT           6'h2A // funct 0x2A Set on less than (signed)
`define FN_SLTU          6'h2B // funct 0x2B Set on less than (unsigned)
`define FN_TGE           6'h30 // funct 0x30 Trap if greater or equal (signed)
`define FN_TGEU          6'h31 // funct 0x31 Trap if greater or equal (unsigned)
`define FN_TLT           6'h32 // funct 0x32 Trap if less than (signed)
`define FN_TLTU          6'h33 // funct 0x33 Trap if less than (unsigned)
`define FN_TEQ           6'h34 // funct 0x34 Trap if equal
`define FN_TNE           6'h36 // funct 0x36 Trap if not equal

// -----------------------------------------------------------------------------
//  Reserved opcodes / function codes for future user expansion                  
// -----------------------------------------------------------------------------
`define OP_USER0          6'h3E // opcode 0x3E User‑defined extension 0
`define OP_USER1          6'h3F // opcode 0x3F User‑defined extension 1
`define FN_USER0          6'h3E // funct 0x3E User‑defined extension 0
`define FN_USER1          6'h3F // funct 0x3F User‑defined extension 1

`endif // MMIPS32_ISATBL_VH