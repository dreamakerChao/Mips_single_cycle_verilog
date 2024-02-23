module uart_control (
    input wire clk,done,
    input wire [63:0]data_in,
    output reg [7:0]data_out,
    output reg rd,wr
);
    //reg work=1'b0;
    reg [3:0] counter=4'd0;
    reg [3:0] counter_next=4'd0;
    reg [7:0] data_temp;

    always @(negedge clk) begin
        counter <= counter_next;
    end

    always @(posedge clk ) begin
        if(done) begin      
            if(counter <8) begin
                counter_next <= counter +1;
                data_temp <= data_in[counter*8 +: 8];
                rd <= 1'b0;
                wr <= 1'b1;
            end
            else begin
                counter_next <= counter ;
                data_temp <= 8'd0;
                rd <= 1'b0;
                wr <= 1'b0;
            end
        end
        else begin
            counter_next <= 0 ;
            data_temp <= 8'd0;
            rd <= 1'b0;
            wr <= 1'b0;
        end

    end

always @(*) begin
        data_out <= data_temp;
end

endmodule