module tb_data_memory;
    reg clk=1'b0;
    always #50 clk = ~clk;
	reg [7:0] addr=8'd0;
    reg [31:0] write_data=32'd0;
    wire [31:0]data_out;
    reg MemRead=1'b0;
    reg MemWrite=1'b0;

    data_memory m1(clk,addr,write_data,MemRead,MemWrite,data_out);
initial
	begin
	#100 addr=8'h02;
        write_data=32'h1111_1234;
        MemRead=1'b0; MemWrite=1'b1;

    #100 addr=8'h02;
        write_data=32'h0000_0000;
        MemRead=1'b1; MemWrite=1'b0;

    #100; addr=8'h03;
        write_data=32'habcd_dcba;
        MemRead=1'b0; MemWrite=1'b1;

    #100 addr=8'h03;
        write_data=32'h0000_0000;
        MemRead=1'b1; MemWrite=1'b0;

    #100 addr=8'h04;
        write_data=32'h0000_0000;
        MemRead=1'b1; MemWrite=1'b0;

    #100;

    $stop;

	end

endmodule