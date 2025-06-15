`ifndef CONTROL_ENCODE_VH
`define CONTROL_ENCODE_VH

// Bit positions for control word [21:0]
`define CTRL_HI_WRITE    21
`define CTRL_HI_READ     10
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
`define CTRL_ALUOP      6:3
`define CTRL_SHIFTV       2
`define CTRL_DATA_TYPE  1:0

// ALU operation codes
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

// data to data_mem type
`define DATA_TYPE_WORD  2'b00
`define DATA_TYPE_HALF  2'b01
`define DATA_TYPE_BYTE  2'b10

`endif
