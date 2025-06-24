`timescale 1ns/1ps

module tb_MIPS_Core;
    integer i;

    // Clock and reset
    reg clk;
    reg rst;

    // Output from DUT
    wire [31:0] PC;
    wire [31:0] inst;
    wire [31:0] v0;

    reg [8*64-1:0] asm_str;

    // Instantiate the DUT (Device Under Test)
    MIPS_Core dut (
        .clk(clk),
        .rst(rst),
        .PC(PC),
        .inst_out(inst),
        .v0(v0)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset
    initial begin
        rst = 1;
        #20;
        rst = 0;
    end

    // Trace
    always @(posedge dut.clk_wb) begin
        $display("/------------------START----------------------------\\");
         $display("==== Stack Dump  at PC 0x%08h ====", PC);
        for (i = 32'h0000_0000; i <= 32'h0000_00CC; i = i + 12) begin
            $display("mem[0x%04h] = 0x%02h%02h%02h%02h   mem[0x%04h] = 0x%02h%02h%02h%02h   mem[0x%04h] = 0x%02h%02h%02h%02h",
                    i,
                    dut.dmem.mem[i],     dut.dmem.mem[i+1],
                    dut.dmem.mem[i+2],   dut.dmem.mem[i+3],
                    i+4,
                    dut.dmem.mem[i+4],   dut.dmem.mem[i+5],
                    dut.dmem.mem[i+6],   dut.dmem.mem[i+7],
                    i+8,
                    dut.dmem.mem[i+8],   dut.dmem.mem[i+9],
                    dut.dmem.mem[i+10],  dut.dmem.mem[i+11]);
        end
        $display("");
        if(dut.control[`CTRL_REGWRITE]) begin
            $display("[WB] PC: 0x%08h | Inst: 0x%08h | %s", PC, inst, asm_str);
            $display("     $ra=0x%08h | $sp=0x%08h | $s8=0x%08h | $v0=0x%08h | $v1=0x%08h | %a0=0x%08h",
                    dut.regfile.reg_array[31],
                    dut.regfile.reg_array[29],
                    dut.regfile.reg_array[30],
                    dut.regfile.reg_array[2],
                    dut.regfile.reg_array[3],
                    dut.regfile.reg_array[4]);
        end
        if (inst[31:26] == `OP_SW) begin
            // SW rt, offset(rs) => store value in rt to memory
            $display("     [SW] mem[0x%08h] <= %s with 0x%08h", dut.mem_addr, regname(inst[20:16]), dut.mem_wdata);
        end else if (inst[31:26] == `OP_LW) begin
            // LW rt, offset(rs) => load memory into rt
            $display("     [LW] mem[0x%08h] => %s with 0x%08h", dut.mem_addr, regname(inst[20:16]), dut.mem_rdata);
        end

        $display("\\------------------end-----------------------------/");      
    end


    // End on syscall
    initial begin
        forever begin
            @(posedge clk);
            if (inst == 32'h0000000C) begin
                $display("[SYSCALL] Time: %0t | PC: %h | $v0: %d", $time, PC, v0);
                $finish;
            end
        end
    end

    // Timeout
    initial begin
        #500000;
        $display("[TIMEOUT] Simulation reached 500000ns without syscall.");
        $finish;
    end

    // Register name function
    function [7*8:1] regname;
        input [4:0] regnum;
        begin
            case (regnum)
                5'd0:  regname = "$0";
                5'd1:  regname = "$at";
                5'd2:  regname = "$v0";
                5'd3:  regname = "$v1";
                5'd4:  regname = "$a0";
                5'd5:  regname = "$a1";
                5'd6:  regname = "$a2";
                5'd7:  regname = "$a3";
                5'd8:  regname = "$t0";
                5'd9:  regname = "$t1";
                5'd10: regname = "$t2";
                5'd11: regname = "$t3";
                5'd12: regname = "$t4";
                5'd13: regname = "$t5";
                5'd14: regname = "$t6";
                5'd15: regname = "$t7";
                5'd16: regname = "$s0";
                5'd17: regname = "$s1";
                5'd18: regname = "$s2";
                5'd19: regname = "$s3";
                5'd20: regname = "$s4";
                5'd21: regname = "$s5";
                5'd22: regname = "$s6";
                5'd23: regname = "$s7";
                5'd24: regname = "$t8";
                5'd25: regname = "$t9";
                5'd26: regname = "$k0";
                5'd27: regname = "$k1";
                5'd28: regname = "$gp";
                5'd29: regname = "$sp";
                5'd30: regname = "$fp";
                5'd31: regname = "$ra";
                default: regname = "$r??";
            endcase
        end
    endfunction

    task decode_inst_full;
        input  [31:0] inst;
        output [255:0] asm_str;
        reg [5:0] op, fn;
        reg [4:0] rs, rt, rd, shamt;
        reg [15:0] imm;
        reg [25:0] target;
        begin
            op     = inst[31:26];
            rs     = inst[25:21];
            rt     = inst[20:16];
            rd     = inst[15:11];
            shamt  = inst[10:6];
            fn     = inst[5:0];
            imm    = inst[15:0];
            target = inst[25:0];

                        case (op)
                6'h00: begin
                    case (fn)
                        6'h00: $sformat(asm_str, "sll  %s, %s, %0d", regname(rd), regname(rt), shamt);
                        6'h02: $sformat(asm_str, "srl  %s, %s, %0d", regname(rd), regname(rt), shamt);
                        6'h03: $sformat(asm_str, "sra  %s, %s, %0d", regname(rd), regname(rt), shamt);
                        6'h08: $sformat(asm_str, "jr   %s", regname(rs));
                        6'h09: $sformat(asm_str, "jalr %s", regname(rs));
                        6'h10: $sformat(asm_str, "mfhi %s", regname(rd));
                        6'h11: $sformat(asm_str, "mthi %s", regname(rs));
                        6'h12: $sformat(asm_str, "mflo %s", regname(rd));
                        6'h13: $sformat(asm_str, "mtlo %s", regname(rs));
                        6'h18: $sformat(asm_str, "mult %s, %s", regname(rs), regname(rt));
                        6'h19: $sformat(asm_str, "multu %s, %s", regname(rs), regname(rt));
                        6'h1A: $sformat(asm_str, "div  %s, %s", regname(rs), regname(rt));
                        6'h1B: $sformat(asm_str, "divu %s, %s", regname(rs), regname(rt));
                        6'h20: $sformat(asm_str, "add  %s, %s, %s", regname(rd), regname(rs), regname(rt));
                        6'h21: $sformat(asm_str, "addu %s, %s, %s", regname(rd), regname(rs), regname(rt));
                        6'h22: $sformat(asm_str, "sub  %s, %s, %s", regname(rd), regname(rs), regname(rt));
                        6'h23: $sformat(asm_str, "subu %s, %s, %s", regname(rd), regname(rs), regname(rt));
                        6'h24: $sformat(asm_str, "and  %s, %s, %s", regname(rd), regname(rs), regname(rt));
                        6'h25: $sformat(asm_str, "or   %s, %s, %s", regname(rd), regname(rs), regname(rt));
                        6'h26: $sformat(asm_str, "xor  %s, %s, %s", regname(rd), regname(rs), regname(rt));
                        6'h27: $sformat(asm_str, "nor  %s, %s, %s", regname(rd), regname(rs), regname(rt));
                        6'h2A: $sformat(asm_str, "slt  %s, %s, %s", regname(rd), regname(rs), regname(rt));
                        6'h2B: $sformat(asm_str, "sltu %s, %s, %s", regname(rd), regname(rs), regname(rt));
                        default: $sformat(asm_str, "R-type unknown (fn=0x%02h)", fn);
                    endcase
                end
                6'h01: begin
                    case (rt)
                        5'h00: $sformat(asm_str, "bltz %s, offset=%0d", regname(rs), $signed(imm));
                        5'h01: $sformat(asm_str, "bgez %s, offset=%0d", regname(rs), $signed(imm));
                        default: $sformat(asm_str, "regimm unknown");
                    endcase
                end
                6'h02: $sformat(asm_str, "j    0x%07x", target << 2);
                6'h03: $sformat(asm_str, "jal  0x%07x", target << 2);
                6'h04: $sformat(asm_str, "beq  %s, %s, offset=%0d", regname(rs), regname(rt), $signed(imm));
                6'h05: $sformat(asm_str, "bne  %s, %s, offset=%0d", regname(rs), regname(rt), $signed(imm));
                6'h06: $sformat(asm_str, "blez %s, offset=%0d", regname(rs), $signed(imm));
                6'h07: $sformat(asm_str, "bgtz %s, offset=%0d", regname(rs), $signed(imm));
                6'h08: $sformat(asm_str, "addi %s, %s, %0d", regname(rt), regname(rs), $signed(imm));
                6'h09: $sformat(asm_str, "addiu %s, %s, %0d", regname(rt), regname(rs), $signed(imm));
                6'h0A: $sformat(asm_str, "slti %s, %s, %0d", regname(rt), regname(rs), $signed(imm));
                6'h0B: $sformat(asm_str, "sltiu %s, %s, %0d", regname(rt), regname(rs), $signed(imm));
                6'h0C: $sformat(asm_str, "andi %s, %s, 0x%04x", regname(rt), regname(rs), imm);
                6'h0D: $sformat(asm_str, "ori  %s, %s, 0x%04x", regname(rt), regname(rs), imm);
                6'h0E: $sformat(asm_str, "xori %s, %s, 0x%04x", regname(rt), regname(rs), imm);
                6'h0F: $sformat(asm_str, "lui  %s, 0x%04x", regname(rt), imm);
                6'h20: $sformat(asm_str, "lb   %s, %0d(%s)", regname(rt), $signed(imm), regname(rs));
                6'h21: $sformat(asm_str, "lh   %s, %0d(%s)", regname(rt), $signed(imm), regname(rs));
                6'h22: $sformat(asm_str, "lwl  %s, %0d(%s)", regname(rt), $signed(imm), regname(rs));
                6'h23: $sformat(asm_str, "lw   %s, %0d(%s)", regname(rt), $signed(imm), regname(rs));
                6'h24: $sformat(asm_str, "lbu  %s, %0d(%s)", regname(rt), $signed(imm), regname(rs));
                6'h25: $sformat(asm_str, "lhu  %s, %0d(%s)", regname(rt), $signed(imm), regname(rs));
                6'h26: $sformat(asm_str, "lwr  %s, %0d(%s)", regname(rt), $signed(imm), regname(rs));
                6'h28: $sformat(asm_str, "sb   %s, %0d(%s)", regname(rt), $signed(imm), regname(rs));
                6'h29: $sformat(asm_str, "sh   %s, %0d(%s)", regname(rt), $signed(imm), regname(rs));
                6'h2A: $sformat(asm_str, "swl  %s, %0d(%s)", regname(rt), $signed(imm), regname(rs));
                6'h2B: $sformat(asm_str, "sw   %s, %0d(%s)", regname(rt), $signed(imm), regname(rs));
                6'h2E: $sformat(asm_str, "swr  %s, %0d(%s)", regname(rt), $signed(imm), regname(rs));
                default: $sformat(asm_str, "unknown (op=0x%02h)", op);
            endcase
        end
    endtask

endmodule
