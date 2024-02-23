module tb_mux;
    reg src;

    wire [15:0] data_out;
    mux #(.n(16)) m6(16'h1234,16'habcd,src,data_out);
initial
	begin
    #0 src=1'b0;

    #100 src=1'b1;

    #100 src=1'b0;
    
    #100;
    
    $stop;

	end

endmodule