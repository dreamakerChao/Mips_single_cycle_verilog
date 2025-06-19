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
            if (dut.inst == 32'h0000000C) begin // Detect syscall
                $display("[SYSCALL] Time: %0t | PC: %h | $v0: %d", $time, PC, dut.v0);
                $finish;
            end
        end
    end

    // Optional timeout limit: 50000 time units
    initial begin
        #5000;
        $display("[TIMEOUT] Simulation reached 50000 time units without syscall.");
        $finish;
    end


endmodule
