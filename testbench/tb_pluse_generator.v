module tb_pluse_generator;
    reg clk=1'b1;

    always #50 clk = ~clk;
    wire clk_out;

    pluse_generator g1 (clk,clk_out);

initial
	begin
    #5000;
    $stop;

	end

endmodule