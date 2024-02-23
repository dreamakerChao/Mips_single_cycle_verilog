module cycle_generator #(
    parameter N=3,
              M=7 //m max : 2^3-1
)(
    input wire clk,
    input wire trigger,
    output reg clk_out
);

reg do=1'b0;
localparam wait_trigger = 2'b00,
          going = 2'b01,
          wait_reset =2'b11;

reg [N-1:0]counter=0,counter_next=0;
reg [1:0]stage=2'b0,stage_next=2'b0;

always @(posedge clk) begin //renew
    if(trigger) begin
        counter<=counter_next;
    end else begin
        counter<=0;
    end
end
always @(negedge clk) begin //renew
    if(trigger) begin
        stage<=stage_next;
    end else begin
        stage<=wait_trigger;
    end
end

always @(*) begin //next-state logic
    case (stage)
        wait_trigger:begin
            clk_out = 1'b0;
            stage_next = going;
            counter_next = 3'b0;
        end 
        going:begin  
            clk_out = clk; 
            if(counter < M) begin 
                counter_next = counter+1;
                stage_next = going;    
                 
            end else begin 
                counter_next = counter;
                stage_next = wait_reset;
            end
        end
        wait_reset:begin
            clk_out = 1'b0;
            counter_next = counter;
            stage_next = wait_reset;
        end
        default:begin
            clk_out = 1'b0;
            stage_next = wait_trigger;
            counter_next = 3'b0;
        end 
    endcase
end


endmodule
