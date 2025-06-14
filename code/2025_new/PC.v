module PC (
    input wire clk,reset,
    input wire [31:0]addr_in,

    output wire [31:0]addr_out
);

    reg [31:0]array;

    initial begin
        array=32'h0000_0000;
    end

    always @(postedge clk) begin
        if(~reset)
            array=addr_in;
        else
            array=32'd0;        
    end


    assign addr_out=array;


endmodule