module next_control (
    input clk,sw,
    output wire clk_out
);

parameter idle=2'b00 , going_hi=2'b01, going_hi=2'b11,reset=2'b10;

always @(negedge sw) begin
    stage_next <= going;
end


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