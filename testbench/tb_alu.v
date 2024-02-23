module tb_alu;
    reg [3:0] Aluctr;
    wire Zero;
    wire [31:0] Result;
    Alu m8(Aluctr,32'h1234_abcd,32'h5678_abcd,Zero,Result);
initial
	begin
    #0 Aluctr=4'd0;

    #100 Aluctr=4'd1;

    #100 Aluctr=4'd2;

    #100 Aluctr=4'd6;

    #100 Aluctr=4'd7;

    #100 Aluctr=4'd12;

    #100 Aluctr=4'd8;

    
    #100;
    
    $stop;

	end

endmodule