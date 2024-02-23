module pc_alu (
    input wire reset,
    input wire [31:0] pc,

    output reg [31:0] new_pc
);

    initial begin
        new_pc = 32'd0;
    end

    always @(*) begin
        if(~reset) begin
            new_pc = pc+32'd4;           
        end
        else begin
            new_pc = 32'd0;
        end
    end
endmodule