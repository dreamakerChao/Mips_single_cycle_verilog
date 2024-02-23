module tb_pc;
	reg clk=1'b0;
    always #50 clk = ~clk;
    reg reset=1'b0;
    reg [31:0]addr_in=32'b0000_0000;

    wire [31:0]addr_out;
    PC m5(clk,reset,addr_in,addr_out);
initial
	begin
    #0 addr_in=32'habcd_8123;

    #100 addr_in=32'habcd_4444;reset=1'b1;
    
    #100 addr_in=32'habcd_0123;reset=1'b0;
    #100 addr_in=32'habcd_abcd;
    #400;
    
    $stop;

	end

endmodule