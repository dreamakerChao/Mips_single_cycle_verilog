
`timescale 10ns/1ns
module tb_db;
    reg reset=1'b1;

    reg clk=1'b0;

	wire db;

    reg sw;

    wire [1:0]state;

    always #1 clk = ~clk;

	debound_fsm m2(clk,reset,sw,db/*,state*/ );

initial
	begin
    #0 sw=1'b0;
    #1 reset=1'b0;

    //00000=ms

    #1048576 sw=1'b1;
    #300000 sw=1'b0;
    #300000 sw=1'b1;
    #300000 sw=1'b0;
    #300000 sw=1'b1;
    #300000 sw=1'b0;
    #300000 sw=1'b1;

    #5000000 sw=1'b0;

    #300000 sw=1'b1;
    #300000 sw=1'b0;
    #300000 sw=1'b1;
    #300000 sw=1'b0;
    #300000 sw=1'b1;
    #300000 sw=1'b0;
    
    #5000000 sw=1'b1;

    #300000 sw=1'b0;
    #300000 sw=1'b1;
    #300000 sw=1'b0;
    #300000 sw=1'b1;

    #5000000 sw=1'b0;

    #300000 sw=1'b1;
    #300000 sw=1'b0;
    #5000000 $stop;
	end

   


endmodule