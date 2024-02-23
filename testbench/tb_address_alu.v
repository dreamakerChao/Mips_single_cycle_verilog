module tb_address_alu;
    reg [31:0]addr;
    reg [31:0] pc_sll;

    wire [31:0] next_address;

    Address_alu m10(addr,pc_sll,next_address);


initial
	begin
    #0 addr=32'd4; pc_sll=32'd4;

    #100 addr=32'd30; pc_sll=-32'd4;

    #100 addr=32'd4; pc_sll=32'd3;

    #100 addr=32'd80; pc_sll=-32'd3;
    
    #100;
    
    $stop;

	end

endmodule