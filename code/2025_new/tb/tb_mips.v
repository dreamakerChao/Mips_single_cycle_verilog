`timescale 1ns/1ps

module tb_MIPS_Core;

    // Clock and reset
    reg clk;
    reg rst;

    // Output from DUT
    wire [31:0] PC;
    wire [31:0] inst;  // Current instruction
    wire [31:0] v0;    // Register $v0

    // Instantiate the DUT (Device Under Test)
    MIPS_Core dut (
        .clk(clk),
        .rst(rst),
        .PC(PC),
        .inst_out(inst),
        .v0(v0)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset and syscall detection control
    initial begin
        // Step 1: Reset phase
        rst = 1;
        #20;
        rst = 0;

        // Step 2: Wait for syscall
        forever begin
            @(posedge clk);
            if (inst == 32'h0000000C) begin // Detect syscall
                $display("[SYSCALL] Time: %0t | PC: %h | $v0: %d", $time, PC, dut.v0);
                $finish;
            end
        end
    end

    // Optional timeout limit: 50000 time units
    initial begin
        #500000;
        $display("[TIMEOUT] Simulation reached 50000 time units without syscall.");
        $finish;
    end

    // Display the current instruction name
    reg [127:0] inst_name;
    always @(*) begin
        decode_inst_name(inst, inst_name);
    end

    task decode_inst_name;
    input [31:0] inst;
    output reg [127:0] inst_name;  // 可用於 waveform 顯示
    reg [5:0] op;
    reg [5:0] fn;
    reg [4:0] rt;
    begin
        op = inst[31:26];
        fn = inst[5:0];
        rt = inst[20:16];

        case (op)
            `OP_J:     inst_name = "j";
            `OP_JAL:   inst_name = "jal";
            `OP_BEQ:   inst_name = "beq";
            `OP_BNE:   inst_name = "bne";
            `OP_BLEZ:  inst_name = "blez";
            `OP_BGTZ:  inst_name = "bgtz";
            `OP_ADDI:  inst_name = "addi";
            `OP_ADDIU: inst_name = "addiu";
            `OP_SLTI:  inst_name = "slti";
            `OP_SLTIU: inst_name = "sltiu";
            `OP_ANDI:  inst_name = "andi";
            `OP_ORI:   inst_name = "ori";
            `OP_XORI:  inst_name = "xori";
            `OP_LUI:   inst_name = "lui";
            `OP_LB:    inst_name = "lb";
            `OP_LH:    inst_name = "lh";
            `OP_LWL:   inst_name = "lwl";
            `OP_LW:    inst_name = "lw";
            `OP_LBU:   inst_name = "lbu";
            `OP_LHU:   inst_name = "lhu";
            `OP_LWR:   inst_name = "lwr";
            `OP_SB:    inst_name = "sb";
            `OP_SH:    inst_name = "sh";
            `OP_SWL:   inst_name = "swl";
            `OP_SW:    inst_name = "sw";
            `OP_SWR:   inst_name = "swr";
            `OP_REGIMM: begin
                case (rt)
                    `RT_BLTZ: inst_name = "bltz";
                    `RT_BGEZ: inst_name = "bgez";
                    default:  inst_name = "regimm?";
                endcase
            end
            `OP_SPECIAL: begin
                case (fn)
                    `FN_SLL:    inst_name = "sll";
                    `FN_SRL:    inst_name = "srl";
                    `FN_SRA:    inst_name = "sra";
                    `FN_SLLV:   inst_name = "sllv";
                    `FN_SRLV:   inst_name = "srlv";
                    `FN_SRAV:   inst_name = "srav";
                    `FN_JR:     inst_name = "jr";
                    `FN_JALR:   inst_name = "jalr";
                    `FN_MFHI:   inst_name = "mfhi";
                    `FN_MTHI:   inst_name = "mthi";
                    `FN_MFLO:   inst_name = "mflo";
                    `FN_MTLO:   inst_name = "mtlo";
                    `FN_MULT:   inst_name = "mult";
                    `FN_MULTU:  inst_name = "multu";
                    `FN_DIV:    inst_name = "div";
                    `FN_DIVU:   inst_name = "divu";
                    `FN_ADD:    inst_name = "add";
                    `FN_ADDU:   inst_name = "addu";
                    `FN_SUB:    inst_name = "sub";
                    `FN_SUBU:   inst_name = "subu";
                    `FN_AND:    inst_name = "and";
                    `FN_OR:     inst_name = "or";
                    `FN_XOR:    inst_name = "xor";
                    `FN_NOR:    inst_name = "nor";
                    `FN_SLT:    inst_name = "slt";
                    `FN_SLTU:   inst_name = "sltu";
                    default:    inst_name = "special?";
                endcase
            end
            default: inst_name = "unknown";
        endcase
    end
endtask



endmodule
