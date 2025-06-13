module Registerfiles (
    input wire clk,
    input wire reset,
    input wire reg_write,
    input wire [4:0] rs_addr,
    input wire [4:0] rt_addr,
    input wire [4:0] rd_addr,
    input wire [4:0] peek_addr,
    input wire [31:0] write_data,
    input wire [31:0] write_data_hi,
    input wire [2:0] HiLotype,

    output reg [31:0] rs_data,
    output reg [31:0] rt_data,
    output reg [31:0] show
);

    reg [31:0] reg_array [33:0];
    reg [5:0] new_addr;
    //Hi Lo reg31 ~ reg0

    integer i;

    initial begin
        rs_data = 32'd0;
        rt_data = 32'd0;
        show =32'd0;
        for(i=0;i<34;i=i+1)begin
            if(i==29)
                reg_array[i] = 32'h0000_0400;
            else
                reg_array[i] = 32'd0;

        end
    end

    always @(*) begin
        case (HiLotype[2:1])
            2'b00: begin
                new_addr = {1'b0,rd_addr};                  
            end
            2'b01:begin
                new_addr = 6'd32;
            end
            2'b10: begin
                new_addr =6'd33;
            end
            2'b11: begin
                new_addr = 6'd32;
            end
        endcase
    end

    always @ (posedge clk) begin
    if(reset) begin
        for(i=0;i<34;i=i+1)begin
            if(i==29)
                reg_array[i] <= 32'h0000_0400;
            else
                reg_array[i] <= 32'd0;
        end
    end else if(reg_write) begin
            if(HiLotype[0] & HiLotype[1]) begin
                reg_array[32] <= write_data;
                reg_array[33] <= write_data_hi;
            end else if (HiLotype==3'b100||HiLotype==3'b010) begin
                reg_array[rd_addr] <= write_data;
            end
            else begin
                reg_array[new_addr] <= write_data;
            end
        end

    end
 
    always @ (negedge clk) begin
        if(reset) begin
            rs_data <= 32'd0;
            rt_data <= 32'd0;
            show <=32'd0;
        end else if((HiLotype==3'b100 || HiLotype==3'b010)) begin
            rt_data <= reg_array[new_addr];
            rs_data <= reg_array[rs_addr];
            show <=reg_array[peek_addr];

        end
        else begin          
            rs_data <= reg_array[rs_addr];
            rt_data <= reg_array[rt_addr];
            show <=reg_array[peek_addr];
        end          
    end
endmodule