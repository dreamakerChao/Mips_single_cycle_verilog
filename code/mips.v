module mips_single (
    input wire clk,reset,
    input wire [31:0]start_addr,
    input wire [4:0]peek_addr,
    output wire done,
    output wire [31:0]show,PC
);
    wire pluse;
    pluse_generator pluse1clk(clk,pluse);
    wire reg_clk,data_clk,pc_clk,imm_clk;
    stage_control stage_controler(clk|pluse,reg_clk,data_clk,pc_clk,imm_clk,reset_clk,done);
    
    //--------- L1 -----------------
    wire [31:0] pc_wire,inst_wire;
    wire [31:0]final_new_pc,pc_start;

    assign PC = pc_wire;

    mux  #(.n(32)) pcsrc(
        .data_A(final_new_pc),
        .data_B(start_addr),
        .src(reset_clk|reset),
        .data_out(pc_start)
    );

    PC u11(
        .clk(pc_clk), .reset(reset_clk|reset),
        .addr_in(pc_start), .addr_out(pc_wire)
    );
    
    immemory u12(
        .clk(imm_clk),
        .resetpc(reset|reset_clk),
        .addr(pc_wire[9:2]), .inst(inst_wire)
    );
    //--------------------------------

    //---------- L2 -----------------
    wire ifunsigned,RegDst,ALUsrc,
         MemtoReg,reg_write,MemRead,
         MemWrite,Branch,Jump;
    wire [3:0]ALUop;
    wire [2:0]data_type;
    wire [1:0]j_type;
    wire [2:0]HiLotype;
        
    control_unit u21(
        reset_clk|reset,
        inst_wire[31:26],
        inst_wire[5:0],
        ifunsigned,RegDst,
        ALUsrc,MemtoReg,reg_write,
        MemRead,MemWrite,Branch,Jump,
        data_type,
        j_type,
        HiLotype,
        ALUop
    );

    wire [31:0]pc_p4;


    pc_alu u22(
        .reset(reset|reset_clk),
        .pc(pc_wire),
        .new_pc(pc_p4)
    );


    wire [4:0]wb_reg_num,rd_addr_or_ra;
    mux  #(.n(5)) choose_rt_td(
        .data_A(inst_wire[20:16]),
        .data_B(inst_wire[15:11]),
        .src(RegDst),
        .data_out(wb_reg_num)
    );

    mux  #(.n(5)) choose_rd_or_ra(
        .data_A(wb_reg_num),
        .data_B(5'd31),
        .src(j_type[1]),
        .data_out(rd_addr_or_ra)
    );
        
    wire [63:0] AluResult;
    wire [31:0]rs_data,rt_data,wb_data,final_wb_data;
    Registerfiles u24(
        .clk(reg_clk),
        .reset(reset_clk|reset),
        .reg_write(reg_write),
        .rs_addr(inst_wire[25:21]),
        .rt_addr(inst_wire[20:16]),
        .rd_addr(rd_addr_or_ra),
        .peek_addr(peek_addr),
        .write_data(final_wb_data),
        .write_data_hi(AluResult[63:32]),
        .HiLotype(HiLotype),
        .rs_data(rs_data),
        .rt_data(rt_data),
        .show(show)
    );


    wire [31:0] sign_ex_data;
    sign_extend u25(
        .data_in(inst_wire[15:0]),
        .ifunsigned(ifunsigned),
        .data_out(sign_ex_data)
    );

    wire [31:0]data2ALU_b;
    mux #(.n(32)) u26(
        .data_A(rt_data),
        .data_B(sign_ex_data),
        .src(ALUsrc),
        .data_out(data2ALU_b)
    );


    //--------------------------------

    //----------- L3 -----------------
    wire [31:0] branch_address;
    Address_alu u31(
        .addr(pc_p4),
        .branch_count(sign_ex_data),
        .next_address(branch_address)
    );
    
    wire Zero;
    
    Alu u32(
        .ifunsigned(ifunsigned),
        .ALUop(ALUop),
        .A(rs_data), .B(data2ALU_b),
        .shmt(inst_wire[10:6]),
        .Zero(Zero),
        .Result(AluResult)
    );
    //--------------------------------

    //---------- L4 ------------------
    wire [31:0] u41tou42, u42tou43; 
    mux #(.n(32)) u41(
        .data_A(pc_p4),
        .data_B(branch_address),
        .src(Zero & Branch),
        .data_out(u41tou42)
    );

    
    mux #(.n(32)) u42(
        .data_A(u41tou42),
        .data_B({pc_p4[31:28],inst_wire[25:0],2'b00}),
        .src(Jump),
        .data_out(u42tou43)
    );

    mux #(.n(32)) u43(
        .data_A(u42tou43),
        .data_B(rs_data),
        .src(j_type[0]),
        .data_out(final_new_pc)
    );

  
    wire [31:0] lw_data;
    data_memory u44(
        .clk(data_clk),
        .addr(AluResult[9:0]),
        .write_data(rt_data),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .data_type(data_type[1:0]),
        .data_out(lw_data)
    );

    wire [31:0] data2reg_load;
    load_data_sign_ex u45(
    .data_in(lw_data),
    .immediate(inst_wire[15:0]),
    .ifunsigned(data_type[2]),
    .type(data_type[1:0]),
    .data_out(data2reg_load)
    );

    mux #(.n(32)) u46(
        .data_A(AluResult[31:0]),
        .data_B(data2reg_load),
        .src(MemtoReg),
        .data_out(wb_data)
    );

    wire [31:0]u47tou48;
    mux #(.n(32)) u47(
        .data_A(wb_data),
        .data_B(rt_data),//hilo
        .src((HiLotype==3'b100 || HiLotype==3'b010)),
        //read
        .data_out(u47tou48)
    );

    wire [31:0] u48tou49,u49tou410;
    mux #(.n(32)) u48( //mult, divide
        .data_A(u47tou48),
        .data_B(AluResult[31:0]),
        .src(HiLotype[1] & HiLotype[0]),
        .data_out(u48tou49)
    );

    mux #(.n(32)) u49( //mthi, mtlo
        .data_A(u48tou49),
        .data_B(rs_data),
        .src((HiLotype==3'b011 || HiLotype==3'b101)),
        .data_out(u49tou410)
    );
    
    mux #(.n(32)) u4_10(
        .data_A(u49tou410),
        .data_B(pc_p4),
        .src(j_type[1]),
        .data_out(final_wb_data)
    );

    //--------------------------------




endmodule