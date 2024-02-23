module immemory (
    input wire clk,resetpc,
    input wire [7:0]addr,

    output reg[31:0]inst 
    //Read only
);

    reg [31:0] inst_array [255:0];
    //4byte x 256 =1kB
    integer i;

    initial begin

        /*inst_array[0] = 32'h20040005;
        inst_array[1] = 32'h0C000003;
        inst_array[2] = 32'h08000013;
        inst_array[3] = 32'h23BDFFF8;
        inst_array[4] = 32'hAFBF0000;
        inst_array[5] = 32'hAFA40004;
        inst_array[6] = 32'h28880001;
        inst_array[7] = 32'h11000003;
        inst_array[8] = 32'h20020001;
        inst_array[9] = 32'h23BD0008;
        inst_array[10] = 32'h03E00008;
        inst_array[11] = 32'h2084FFFF;
        inst_array[12] = 32'h0C000003;
        inst_array[13] = 32'h8FA40004;
        inst_array[14] = 32'h00440018;
        inst_array[15] = 32'h00001012;
        inst_array[16] = 32'h8FBF0000;
        inst_array[17] = 32'h23BD0008;
        inst_array[18] = 32'h03E00008;*/

        inst_array[0] = 32'h23BDFFF2;
	    inst_array[1] = 32'h200A0000;
	    inst_array[2] = 32'h2009000E;
	    inst_array[3] = 32'h83B10000;
	    inst_array[4] = 32'h23BD0001;
	    inst_array[5] = 32'h22310001;
	    inst_array[6] = 32'h214A0001;
	    inst_array[7] = 32'hA1510000;
	    inst_array[8] = 32'h1549FFFA;

        for(i=/*19*/9;i<256;i=i+1)
            inst_array[i] <= 32'd0;
    end

    always @(negedge clk) begin
        if(resetpc)
            inst <= 32'd0;
        else
            inst <= inst_array[addr];
    end

    
endmodule