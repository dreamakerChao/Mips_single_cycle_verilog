module sign_extend (
    input wire [15:0]data_in,
    input wire ifunsigned,
    output reg [31:0]data_out
);
 
    always @(*) begin
     if(ifunsigned) begin
        data_out={16'd0,data_in};
     end
     else begin
        if(data_in[15]==1) begin
            data_out={16'hffff,data_in};
        end
        else begin
            data_out={16'd0,data_in};
        end
     end
    end

    
endmodule