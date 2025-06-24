module Stage_control (
    input wire clk,
    input wire rst,
    output reg clk_imm,   // for instruction memory
    output reg clk_dmm,   // for data memory
    output reg clk_reg,   // for register file
    output reg clk_wb
);

    reg [2:0] stage, next_stage;

    // Stage encoding
    localparam STAGE_NOP  = 3'd0;
    localparam STAGE_IF   = 3'd1;
    localparam STAGE_ID   = 3'd2;
    localparam STAGE_EX   = 3'd3;
    localparam STAGE_MEM  = 3'd4;
    localparam STAGE_WB   = 3'd5;
    localparam STAGE_PC   = 3'd6;

    // State register
    always @(posedge clk or posedge rst) begin
        if (rst)
            stage <= STAGE_NOP;
        else
            stage <= next_stage;
    end

    // Next state logic
    always @(*) begin
        case (stage)
            STAGE_NOP: next_stage = STAGE_IF; // Start with IF stage after reset
            STAGE_IF:  next_stage = STAGE_ID;
            STAGE_ID:  next_stage = STAGE_EX;
            STAGE_EX:  next_stage = STAGE_MEM;
            STAGE_MEM: next_stage = STAGE_WB;
            STAGE_WB:  next_stage = STAGE_PC;
            STAGE_PC:  next_stage = STAGE_IF;
            default:   next_stage = STAGE_NOP;
        endcase
    end

    // Output logic
    always @(*) begin
        // Default all off
        clk_imm = 1'b0;
        clk_dmm = 1'b0;
        clk_reg = 1'b0;
        clk_wb  = 1'b0;

        case (stage)
            STAGE_IF:  clk_imm = 1'b1;
            STAGE_MEM: clk_dmm = 1'b1;
            STAGE_WB:  clk_reg = 1'b1;
            STAGE_PC:  clk_wb  = 1'b1;
        endcase
    end

endmodule
