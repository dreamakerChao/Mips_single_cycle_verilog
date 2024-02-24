module mips_cpu_test (
    input wire clk,
    input wire reset,
    input wire next,
    input wire [1:0]switch,
    output reg [3:0]led
);
    wire next_clk,db_next,db_reset;
    wire [4:0] peek_addr=5'd17;
    wire [31:0]led_full;

    db db1(.clk(clk),.sw(next),.db_level(db_next),.db_tick());
    db db2(.clk(clk),.sw(reset),.db_level(db_reset),.db_tick());

    cycle_generator m1(clk, db_next , next_clk);

    
    wire [31:0]reg_32_data;
    wire [63:0]reg_data;
    wire [7:0]w_data,r_data;
    wire [31:0]start_addr=32'd0;
    wire rd,wr,tx_full, rx_empty;
    mips_single cpu1(
        .clk(next_clk),
        .reset(db_reset),
        .start_addr(start_addr),
        .peek_addr(peek_addr),
        .done(),
        .show(led_full),
        .PC());
        
     always @(led_full,switch) begin
        case(switch)
            2'd0:led = led_full[3:0];
            2'd1:led = led_full[7:4];
            2'd2:led = led_full[11:8];
            2'd3:led = led_full[15:12];
        endcase
     end 

endmodule