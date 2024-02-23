module Address_alu (
    input wire [31:0] addr,
    input wire [31:0] branch_count,

    output reg [31:0] next_address
);
    
    always @(*) begin
        next_address = addr + (branch_count<<2);
    end
    
endmodule