module Inst_memory #(
    parameter INST_DEPTH = 1024 // 1KB instruction memory
)
(
    input wire clk,
    input wire reset,
    input wire [$clog2(INST_DEPTH)-1:0] addr, // word-address (PC[31:2])
    output reg [31:0] inst
);

    (* ram_style = "block" *)      //BRAM
    reg [31:0] inst_array [0:INST_DEPTH-1];// 1KB BRAM

    integer i;

    initial begin
        $readmemh("prog.mem", inst_array); //.mem initialize
        // for (i = 9; i < 256; i = i + 1)
        //     inst_array[i] = 32'd0;   
    end

    always @(posedge clk) begin
        if (reset)
            inst <= 32'd0;
        else
            inst <= inst_array[addr];
    end

endmodule
