module Regfile(
    input  wire        clk,
    input  wire        rst,
    input  wire        RegWrite,          // Enable writing to general-purpose register
    input  wire        HiWrite,           // Enable writing to HI
    input  wire        LoWrite,           // Enable writing to LO
    input  wire [4:0]  rs_addr,           // Read address for rs
    input  wire [4:0]  rt_addr,           // Read address for rt
    input  wire [4:0]  rd_addr,           // Write address for rd
    input  wire [31:0] lo_data_in,        // Unified ALU output lower 32-bit (ALU_RESULT[31:0])
    input  wire [31:0] hi_data_in,        // ALU output upper 32-bit (ALU_RESULT[63:32])
    output wire [31:0] rs_data,           // Output of rs register
    output wire [31:0] rt_data,           // Output of rt register
    output wire [31:0] hi_data_out,       // Output of HI
    output wire [31:0] lo_data_out,        // Output of LO

    output wire [31:0] test_output // For testing purposes, can be removed later
);

    

    // General-purpose register file (excluding $zero)
    reg [31:0] reg_array [31:1];  // $1 ~ $31
    reg [31:0] hi;                // HI special register
    reg [31:0] lo;                // LO special register

    // Combinational read ports
    assign rs_data = (rs_addr == 5'd0) ? 32'd0 : reg_array[rs_addr];
    assign rt_data = (rt_addr == 5'd0) ? 32'd0 : reg_array[rt_addr];

    // HI/LO read output
    assign hi_data_out = hi;
    assign lo_data_out = lo;

    initial begin : init_mem
        integer i;
        // Initialize general-purpose registers to 0
        for (i = 1; i < 32; i = i + 1)begin
            if(i== 29 || i==30) // $sp or $fp
                reg_array[i] = 32'h0000_00CC;  // $sp 
            else
                reg_array[i] <= 32'd0;
        end

        hi = 32'd0;
        lo = 32'd0;
    end


    // Sequential write logic
    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 1; i < 32; i = i + 1)begin
                if(i== 29 || i==30) // $sp or $fp
                    reg_array[i] = 32'h0000_00CC;  // $sp 
                else
                    reg_array[i] <= 32'd0;
            end
            hi <= 32'd0;
            lo <= 32'd0;
        end else begin
            // Write to general-purpose register using lo_data_in
            if (RegWrite && rd_addr != 5'd0)
                reg_array[rd_addr] <= lo_data_in;

            // Write to HI/LO if enabled
            if (HiWrite)
                hi <= hi_data_in;
            if (LoWrite)
                lo <= lo_data_in;
        end
    end


    assign test_output = reg_array[3]; 
endmodule
