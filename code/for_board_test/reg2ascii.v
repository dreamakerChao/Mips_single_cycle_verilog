module reg2ascii (
    input wire [31:0] regdata,
    output wire [63:0] data_out
);

//assign data_out[95:88] = 8'h0a;
//assign data_out[87:80] = 8'h20;
//assign data_out[79:72] = 8'h20;
//assign data_out[71:64] = 8'h20;

genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : INSTANCE_LOOP
        hex2ascii m (
            .hex(regdata[i*4+3:i*4]),
            .ascii(data_out[i*8+7:i*8])
        );
    end
endgenerate

endmodule
