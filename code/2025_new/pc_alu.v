module PC_alu (
    input  wire        reset,   // Active-high reset
    input  wire [31:0] pc,      // Current PC

    output reg  [31:0] new_pc   // PC + 4 or reset to 0
);

    // Next PC is always either reset or PC + 4
    always @(*) begin
        if (reset)
            new_pc = 32'd0;           // Reset: set PC to 0
        else
            new_pc = pc + 32'd4;      // Normal: increment PC by 4
    end

endmodule
