`include "Control_encode.vh"
`include "Mips32_ISATbl.vh"

module MIPS_Core (
    input wire clk,
    input wire rst,

    output wire [31:0] PC
);
    // ---------------------------- IF Stage ----------------------------
    reg [31:0] pc_reg;
    wire [31:0] next_pc;
    wire [31:0] inst;

    assign PC = pc_reg;

    Inst_memory imem (
        .clk(clk),
        .reset(rst),
        .addr(pc_reg[31:2]),
        .inst(inst)
    );

    // ---------------------------- ID Stage ----------------------------
    wire [5:0] opcode = inst[31:26];
    wire [4:0] rs     = inst[25:21];
    wire [4:0] rt     = inst[20:16];
    wire [4:0] rd     = inst[15:11];
    wire [15:0] imm   = inst[15:0];
    wire [25:0] jidx  = inst[25:0];
    wire [5:0] funct  = inst[5:0];
    wire [4:0] shamt  = inst[10:6];

    wire [31:0] sign_ext_imm;
    wire        ifunsigned;

    // decode control signals
    wire [24:0] control;
    // control = {HI_WRITE, HI_READ, LO_WRITE, LO_READ, ifunsigned, ... ALUOP, SHIFTV, DATA_TYPE}
    Controller controller (
        .opcode(opcode),
        .funct(funct),
        .control(control)
    );

    assign ifunsigned = control[`CTRL_IFUNSIGNED];

    Sign_extend sext (
        .data_in(imm),
        .ifunsigned(ifunsigned),
        .data_out(sign_ext_imm)
    );

    wire [31:0] rs_val, rt_val, hi_val, lo_val;

    Regfile regfile (
        .clk(clk),
        .rst(rst),
        .RegWrite(control[`CTRL_REGWRITE]),
        .HiWrite(control[`CTRL_HI_WRITE]),
        .LoWrite(control[`CTRL_LO_WRITE]),
        .rs_addr(rs),
        .rt_addr(rt),
        .rd_addr(control[`CTRL_REGDST] ? rd : rt),
        .rd_data(lo_val),
        .hi_data_in(alu_result[63:32]),
        .lo_data_in(alu_result[31:0]),
        .rs_data(rs_val),
        .rt_data(rt_val),
        .hi_data_out(hi_val),
        .lo_data_out(lo_val)
    );

    // ---------------------------- EX Stage ----------------------------
    wire [63:0] alu_result;
    wire [31:0] alu_in_b = control[`CTRL_ALUSRC] ? sign_ext_imm : rt_val;
    wire [4:0]  shmt = shamt;
    wire        sv = control[`CTRL_SHIFTV];

    wire        zero_flag;

    ALU alu (
        .ifunsigned(ifunsigned),
        .ALUop(control[`CTRL_ALUOP]),
        .A(rs_val),
        .B(alu_in_b),
        .shmt(shmt),
        .sv(sv),
        .zero(zero_flag),
        .Result(alu_result)
    );

    // ---------------------------- MEM Stage ----------------------------
    wire [31:0] data_mem_out;

    Data_memory dmem (
        .clk(clk),
        .addr(alu_result[9:0]),
        .write_data(rt_val),
        .MemRead(control[`CTRL_MEMREAD]),
        .MemWrite(control[`CTRL_MEMWRITE]),
        .ifunsigned(ifunsigned),
        .data_type(control[`CTRL_DATA_TYPE]),
        .rt_val(rt_val),
        .data_out(data_mem_out)
    );

    // ---------------------------- WB Stage ----------------------------
    wire [31:0] write_back_data = control[`CTRL_MEMTOREG] ? data_mem_out : alu_result[31:0];

    // ---------------------------- PC Update ----------------------------
    wire [2:0] branch_type = control[`CTRL_BRANCH];
    wire       do_branch;

    Branch_unit branch_unit (
        .BranchType(branch_type),
        .A(rs_val),
        .B(rt_val),
        .BranchTaken(do_branch)
    );

    wire [31:0] pc_branch = pc_reg + 4 + ({{14{imm[15]}}, imm, 2'b00});
    wire [31:0] pc_jump   = {pc_reg[31:28], jidx, 2'b00};
    wire [31:0] pc_return = rs_val; // for JR/JALR

    assign next_pc = control[`CTRL_RETURN]  ? pc_return :
                     control[`CTRL_JUMP]    ? pc_jump   :
                     do_branch              ? pc_branch :
                                              pc_reg + 4;

    always @(posedge clk or posedge rst) begin
        if (rst)
            pc_reg <= 32'd0;
        else
            pc_reg <= next_pc;
    end

endmodule
