module tb_cycle_generator;
    reg clk=1'b1;
    reg trigger =1'b0;

    always #50 clk = ~clk;
    wire clk_out;

    cycle_generator g1 (clk,trigger,clk_out);

initial
	begin
    #50;
    #50;trigger =1'b0;
    #50;trigger =1'b1;
	#5000;trigger =1'b0;
    #500;trigger =1'b1;
    #5000;
    $stop;

	end

endmodule