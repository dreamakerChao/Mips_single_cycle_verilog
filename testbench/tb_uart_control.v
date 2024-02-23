module tb_uart_control;
    reg clk=1'b1;
    reg done = 1'b0;
    wire rd,wr;
    wire [7:0]data_out;

    always #50 clk = ~clk;

    uart_control  m1(clk,done,64'habcd_1234_5678_9fec,data_out,rd,wr);

initial
	begin
    #100;done=1'b1;
    #3000;done=1'b0;
    #100;done=1'b1;
    #3000;done=1'b0;

	#3000;
    $stop;

	end

endmodule