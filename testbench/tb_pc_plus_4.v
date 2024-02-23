module tb_pc_plu_4;
    reg [31:0]pc=32'h0000_0000;

    wire [31:0] new_pc;
    pc_plus_4_alu m7(pc,new_pc);
initial
	begin
    #0 pc=32'h0000_0003;

    #100 pc=32'h0000_0001;

    #100 pc=32'h1000_0000;

    
    #100;
    
    $stop;

	end

endmodule