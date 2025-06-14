module Regfile(
    input  wire        clk,
    input  wire        rst,
    input  wire        RegWrite,          // General reg write enable
    input  wire        HiWrite,           // HI register write enable
    input  wire        LoWrite,           // LO register write enable
    input  wire [4:0]  rs_addr,           // Read register 1 address
    input  wire [4:0]  rt_addr,           // Read register 2 address
    input  wire [4:0]  rd_addr,           // Write register address
    input  wire [31:0] rd_data,           // Write data
    input  wire [31:0] hi_data_in,        // Write data to HI
    input  wire [31:0] lo_data_in,        // Write data to LO
    output wire [31:0] rs_data,           // Read data 1
    output wire [31:0] rt_data,           // Read data 2
    output wire [31:0] hi_data_out,       // HI output
    output wire [31:0] lo_data_out        // LO output
);

    // General-purpose registers (excluding $zero)
    reg [31:0] reg_array [31:1];  // note: $0 is not physically stored

    // HI/LO special registers
    reg [31:0] hi;
    reg [31:0] lo;

    // Combinational read
    assign rs_data = (rs_addr == 5'd0) ? 32'd0 : reg_array[rs_addr];
    assign rt_data = (rt_addr == 5'd0) ? 32'd0 : reg_array[rt_addr];

    assign hi_data_out = hi;
    assign lo_data_out = lo;

    // Sequential logic
    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 1; i < 32; i = i + 1)
                reg_array[i] <= 32'd0;
            hi <= 32'd0;
            lo <= 32'd0;
        end else begin
            if (RegWrite && rd_addr != 5'd0)
                reg_array[rd_addr] <= rd_data;

            if (HiWrite)
                hi <= hi_data_in;
            if (LoWrite)
                lo <= lo_data_in;
        end
    end

endmodule
