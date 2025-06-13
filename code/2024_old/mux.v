module mux #(
    parameter n = 32 //2xn in, 1xn out 
) (
    input wire [n-1:0] data_A, data_B,
    input wire src,

    output reg [n-1:0] data_out
);

    always@(*)
    begin
        if(~src)
            data_out= data_A;
        else
             data_out= data_B;
    end
    
endmodule