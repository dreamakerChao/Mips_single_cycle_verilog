module tb_AluControl;
    reg [5:0] funct;
    reg [1:0] aluop;

    wire [3:0] aluctr;
    AluControl m8(funct,aluop,aluctr);
initial
	begin
    #0 funct=5'd0; aluop=2'b00;

    #100 funct=5'd0; aluop=2'b01;

    #100 funct=5'b0_0000; aluop=2'b10;

    #100 funct=5'b0_0010; aluop=2'b10;

    #100 funct=5'b0_0100; aluop=2'b11;

    #100 funct=5'b1_0101; aluop=2'b11;

    #100 funct=5'b1_0111; aluop=2'b11;

    
    #100;
    
    $stop;

	end

endmodule
