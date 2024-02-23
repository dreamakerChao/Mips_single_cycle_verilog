module mips_cpu_test (
    input wire clk,
    input wire reset,
    input wire next,rx,
    output wire tx,done
);
    wire next_clk,db_next,db_reset;

    db db1(.clk(clk),.sw(next),.db_level(db_next),.db_tick());
    db db2(.clk(clk),.sw(reset),.db_level(db_reset),.db_tick());

    //cycle_generator m1(clk, next , next_clk);

    
    wire [31:0]reg_32_data;
    wire [63:0]reg_data;
    wire [7:0]w_data,r_data;
    wire [31:0]start_addr=32'd0;
    wire rd,wr,tx_full, rx_empty;
    mips_single cpu1(db_next,db_reset,done,start_addr,reg_32_data);
    reg2ascii m2(reg_32_data,reg_data);
    uart_control u1(clk,done,reg_data,w_data,rd,wr);
    uart uart(clk,reset,rd,wr,rx,w_data,tx_full, rx_empty,tx,r_data);

endmodule