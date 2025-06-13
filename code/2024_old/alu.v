module Alu (
    input wire ifunsigned,
    input wire [3:0] ALUop,
    input wire [31:0] A,B,
    input wire [4:0] shmt,

    output reg Zero,
    output reg [63:0] Result
);

    always @(*) begin
        case(ALUop) 
            4'd0: Result = {32'd0,A&B};
            4'd1: Result = {32'd0,A|B};
            4'd2: Result = {32'd0,A^B};
            4'd3: begin
                    if(ifunsigned)
                        Result = {32'd0,A+B};
                    else
                        Result = {32'd0,$signed(A) + $signed(B)};
            end
            4'd4: begin
                    if(ifunsigned)
                        Result = {32'd0,A-B};
                    else
                        Result = {32'd0,$signed(A) - $signed(B)};
            end
            4'd5: Result = A >  B ? 64'd1:64'd0;
            4'd6: Result = A < B ? 64'd1:64'd0;
            4'd7: Result = A >= B ? 64'd1:64'd0;
            4'd8: Result = A <= B? 64'd1:64'd0;
            4'd9: Result = {32'd0,A>>shmt};
            4'd10: Result = {32'd0,A>>>shmt};
            4'd11: Result = {32'd0,A<<shmt};
            4'd12: Result = {32'd0,~(A|B)};  
            4'd13: Result = {32'd0,(A==B)};
            4'd14: begin
                    if(ifunsigned)
                        Result = A*B;
                    else
                        Result = $signed(A)*$signed(B);
            end
            4'd15: begin
                    if(ifunsigned)
                        Result = A/B;
                    else
                        Result = $signed(A)/$signed(B);
            end
            default: Result = -64'd1;
        endcase

        Zero = (Result[31:0]==32'd0);
    end
endmodule