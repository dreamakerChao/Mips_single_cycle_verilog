module tb_stage_controler;
    reg clk=1'b1;
    wire reg_clk,data_clk,pc_clk;

    always #50 clk = ~clk;

    stage_control u1 (clk,reg_clk,data_clk,pc_clk);

initial
	begin
	#3000;
    $stop;

	end

endmodule