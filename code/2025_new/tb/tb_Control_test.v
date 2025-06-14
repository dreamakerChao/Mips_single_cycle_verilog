`timescale 1ns / 1ps

module control_tb;

    // DUT inputs
    reg [5:0] opcode;
    reg [5:0] funct;

    // DUT output
    wire [19:0] control_word;

    // Instantiate the DUT
    Control_unit dut (
        .opcode(opcode),
        .funct(funct),
        .control_word(control_word)
    );

    // Memory to hold test input (12-bit: [11:6] opcode, [5:0] funct)
    reg [31:0] control_inputs [0:67];
    integer i;

    initial begin
        // Load test patterns
        $readmemh("control_test.mem", control_inputs);

        // Initialize
        i = 0;

        // Stimulus loop
        repeat (256) begin
            opcode = control_inputs[i][31:26];
            funct = control_inputs[i][5:0];
            #1;
            $display("Time=%0t | opcode=0x%02h funct=0x%02h => control_word=0x%06h", $time, opcode, funct, control_word);
            i = i + 1;
        end

        $finish;
    end

endmodule
