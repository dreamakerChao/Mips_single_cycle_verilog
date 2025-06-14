`include "control_encode.vh"

module ALU (
    input wire ifunsigned,
    input wire [3:0] ALUop,
    input wire [31:0] A,B,
    input wire [4:0] shmt,

    output reg Zero,
    output reg [63:0] Result
);

    wire signed [WIDTH-1:0] As = $signed(A);
    wire signed [WIDTH-1:0] Bs = $signed(B);
    wire [63:0] mul_res;
    wire [63:0] div_res;

    assign mul_res = ifunsigned ? (A * B) : (As * Bs);
    assign div_res = ifunsigned ? (A / B) : (As / Bs);

    always @(*) begin
        always @(*) begin
        case(ALUop)
            `ALU_AND:  Result = {32'd0, A & B};                                  // AND
            `ALU_OR:   Result = {32'd0, A | B};                                  // OR
            `ALU_XOR:  Result = {32'd0, A ^ B};                                  // XOR
            `ALU_ADD:  Result = ifunsigned ? {32'd0, A + B} : {32'd0, As + Bs}; // ADD
            `ALU_SUB:  Result = ifunsigned ? {32'd0, A - B} : {32'd0, As - Bs}; // SUB
            `ALU_SLTU: Result = {63'd0, (A < B)};                                // SLTU
            `ALU_SLT:  Result = {63'd0, (As < Bs)};                              // SLT
            `ALU_GE:   Result = {63'd0, (As >= Bs)};                             // GE
            `ALU_LE:   Result = {63'd0, (As <= Bs)};                             // LE
            `ALU_SRL:  Result = {32'd0, A >> shmt};                              // SRL
            `ALU_SRA:  Result = {32'd0, As >>> shmt};                            // SRA
            `ALU_SLL:  Result = {32'd0, A << shmt};                              // SLL
            `ALU_NOR:  Result = {32'd0, ~(A | B)};                               // NOR
            `ALU_EQ:   Result = {63'd0, (A == B)};                               // EQ
            `ALU_MUL:  Result = mul_res;                                        // MUL
            `ALU_DIV:  Result = div_res;                                        // DIV
            default:   Result = 64'd0;                        // INVALID
        endcase

        Zero = (Result[31:0]==32'd0);
    end
endmodule