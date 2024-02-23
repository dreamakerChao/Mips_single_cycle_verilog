module tb_mips;
    reg clk=1'b1;
    reg reset=1'b0;
    /*reg next=1'b0;
    wire next_clk;*/
    reg [31:0]start_addr=32'd0;
    wire [4:0] peek_addr=5'd17/*2*/;

    always #8 clk = ~clk;
    wire [31:0]show,PC;
    wire done;

    //cycle_generator m1(clk, next , next_clk);
    mips_single cpu1 (clk,reset,start_addr,peek_addr,done,show,PC);
    

initial
	begin
    #11216;
    $stop;

	end

endmodule