module pluse_generator (
    input clk,
    output wire clk_out
);

reg src= 1'b0;
reg src_next = 1'b0;
reg dect=1'b0;

mux #(.n(1)) m1(1'b0,clk,src,clk_out);

always @(negedge clk) begin
    src <= src_next;
end

always @(posedge clk) begin
    if(dect) begin
        dect <= 1'b1;
        src_next <= 1'b0;
    end
    else begin
        dect <= 1'b1;
        src_next <= 1'b1;
    end
    
end



endmodule
