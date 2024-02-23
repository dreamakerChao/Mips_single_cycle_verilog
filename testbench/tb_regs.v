module tb_regs;
	reg clk=1'b0;
    always #50 clk = ~clk;
    reg reg_write=1'b0;
    reg [4:0] rs_addr=5'b0_0000;
    reg [4:0] rt_addr=5'b0_0000;
    reg [4:0] rd_addr=5'b0_0000;
    reg [31:0] write_data=32'd0;

    wire [31:0] rs_data;
    wire [31:0] rt_data;  
    Registerfiles m3(clk,reg_write,rs_addr,rt_addr,rd_addr,write_data,rs_data,rt_data);
initial
	begin

	#100 reg_write = 1'b1; //$1=abcd_1234
        rs_addr = 5'd1; //keep monitor $1 and $2
        rt_addr = 5'd2;
        rd_addr = 5'b0_0001;
        write_data = 32'habcd_1234;

    #100 reg_write = 1'b1; //$2=abcd_abcd
        rs_addr = 5'd1;
        rt_addr = 5'd2;
        rd_addr = 5'd2;
        write_data = 32'habcd_5678;

    #100 reg_write = 1'b1; //$1=abcd_abcd
        rs_addr =  5'd1;
        rt_addr = 5'd2;
        rd_addr = 5'd1;
        write_data = 32'habcd_abcd;

    #100 reg_write = 1'b0; //read $1
        rs_addr =  5'd1;
        rt_addr =  5'd2;
        rd_addr = 5'd1;
        write_data = 32'habcd_1234;

    #100 reg_write = 1'b0; //read $2
        rs_addr =  5'd1;
        rt_addr = 5'd2;
        rd_addr = 5'd2;
        write_data = 32'habcd_1234;

    #100;
    
    $stop;

	end

endmodule