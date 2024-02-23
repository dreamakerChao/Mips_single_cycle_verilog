module tb_sign_ex;
	reg [15:0]data_in;
    wire [31:0]data_out;

    sign_extend m4(data_in,data_out);
initial
	begin
	#0 data_in=16'h8000;
    #100 data_in=16'h8123;
    #100 data_in=16'h0123;
    #100 data_in=16'habcd;
    #100;
    
    $stop;

	end

endmodule