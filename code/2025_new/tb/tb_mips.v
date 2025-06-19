`timescale 1ns/1ps

module tb_MIPS_Core;

    // Clock and reset
    reg clk;
    reg rst;

    // Output from DUT
    wire [31:0] PC;

    // Instantiate the DUT (Device Under Test)
    MIPS_Core dut (
        .clk(clk),
        .rst(rst),
        .PC(PC)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset and simulation control
    initial begin
        // Initialize reset
        rst = 1;
        #20; // Hold reset for 20ns

        rst = 0;

        // Run simulation for a while
        #500;

        $finish;
    end

    // Optional: monitor PC for debug
    initial begin
        $display("Time\tPC");
        $monitor("%0t\t%h", $time, PC);
    end

endmodule
