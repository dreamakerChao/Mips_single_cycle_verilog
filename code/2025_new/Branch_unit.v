`include "Control_encode.vh"
module Branch_unit (
    input  [2:0] BranchType,
    input  [31:0] A, B,
    output reg BranchTaken
);

    always @(*) begin
        case (BranchType)
            `BR_NONE:  BranchTaken = 1'b0;
            `BR_BEQ:   BranchTaken = (A == B);
            `BR_BNE:   BranchTaken = (A != B);
            `BR_BLEZ:  BranchTaken = ($signed(A) <= 0);
            `BR_BGTZ:  BranchTaken = ($signed(A) > 0);
            `BR_BLTZ:  BranchTaken = ($signed(A) < 0);
            `BR_BGEZ:  BranchTaken = ($signed(A) >= 0);
            default:   BranchTaken = 1'b0;
        endcase
    end

endmodule
