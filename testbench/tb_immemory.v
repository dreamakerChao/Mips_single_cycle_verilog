module tb_immemory;
	reg [31:0] addr;
    wire [31:0]inst;

    immemory m2(addr,inst);
initial
	begin
	#0 addr=32'h0000_0000;
    #100 addr=32'h0000_0004;
    #100 addr=32'h0000_0008;
    #100 addr=32'h0000_000c;
    #100 addr=32'h0000_0010;
    #100;
    
    $stop;

	end

endmodule