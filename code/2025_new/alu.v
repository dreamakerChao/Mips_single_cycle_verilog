`include "control_encode.vh"

module ALU #(
    parameter WIDTH = 32
)(
    input  wire        ifunsigned,
    input  wire [3:0]  ALUop,
    input  wire [31:0] A, B,
    input  wire [4:0]  shmt,
    input  wire        sv, // shift source: 0=shamt, 1=rs

    output reg [63:0]  Result
);

    wire signed [WIDTH-1:0] As = $signed(A);
    wire signed [WIDTH-1:0] Bs = $signed(B);
    wire [63:0] mul_res;
    wire [63:0] div_res;

    wire [4:0] shift_amt = sv ? B[4:0] : shmt;

    assign mul_res = ifunsigned ? (A * B) : (As * Bs);
    assign div_res = ifunsigned ? (A / B) : (As / Bs);

    always @(*) begin
        case (ALUop)
            `ALU_AND:  Result = {32'd0, A & B};
            `ALU_OR:   Result = {32'd0, A | B};
            `ALU_XOR:  Result = {32'd0, A ^ B};
            `ALU_NOR:  Result = {32'd0, ~(A | B)};
            
            `ALU_ADD:  Result = ifunsigned ? {32'd0, A + B} : {32'd0, As + Bs};
            `ALU_SUB:  Result = ifunsigned ? {32'd0, A - B} : {32'd0, As - Bs};

            `ALU_LT:   Result = {63'd0, ifunsigned ? (A < B)  : (As < Bs)};

            `ALU_SLL:  Result = {32'd0, A << shift_amt};
            `ALU_SRL:  Result = {32'd0, A >> shift_amt};
            `ALU_SRA:  Result = {32'd0, As >>> shift_amt};

            `ALU_MUL:  Result = mul_res;
            `ALU_DIV:  Result = div_res;

            default:   Result = 64'd0;
        endcase

    end

endmodule
