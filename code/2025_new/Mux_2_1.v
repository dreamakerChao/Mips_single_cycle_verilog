module Mux_2_1 #(
    parameter n = 32 //2xn in, 1xn out 
) (
    input wire [n-1:0] data_A, data_B,
    input wire src,

    output reg [n-1:0] data_out
);

    always@(*)
        data_out = src ? data_B : data_A;data_out= data_B;
    end
    
endmodule