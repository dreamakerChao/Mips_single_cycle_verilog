module hex2ascii (
    input wire [3:0] hex,
    output reg [7:0] ascii
);

always @(*)
begin
    case(hex)
        4'h0: ascii = 8'b00110000; // '0'
        4'h1: ascii = 8'b00110001; // '1'
        4'h2: ascii = 8'b00110010; // '2'
        4'h3: ascii = 8'b00110011; // '3'
        4'h4: ascii = 8'b00110100; // '4'
        4'h5: ascii = 8'b00110101; // '5'
        4'h6: ascii = 8'b00110110; // '6'
        4'h7: ascii = 8'b00110111; // '7'
        4'h8: ascii = 8'b00111000; // '8'
        4'h9: ascii = 8'b00111001; // '9'
        4'ha: ascii = 8'b01000001; // 'A'
        4'hb: ascii = 8'b01000010; // 'B'
        4'hc: ascii = 8'b01000011; // 'C'
        4'hd: ascii = 8'b01000100; // 'D'
        4'he: ascii = 8'b01000101; // 'E'
        4'hf: ascii = 8'b01000110; // 'F'
        default: ascii = 8'b00000000; // Invalid input
    endcase
end

endmodule
