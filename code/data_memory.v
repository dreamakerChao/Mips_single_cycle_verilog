module data_memory  (//1byte x 1024 =1kB
        //m bit x 2^n
    input wire clk,
    input wire [9:0] addr,
    input wire [31:0] write_data,
    input wire MemRead,MemWrite,
    input wire [1:0] data_type,

    output reg[31:0]data_out

);

    reg [7:0] data_array [1023:0];
    integer i;

    initial begin
        for(i=0;i<512;i=i+1)
            data_array[i] <= 8'd0;
            
        for(i=512;i<1009/*1024*/;i=i+1)
            data_array[i] <= 8'd0;

        {data_array[1023],data_array[1022],data_array[1021],data_array[1020]}=32'h0a48656c;
        {data_array[1019],data_array[1018],data_array[1017],data_array[1016]}=32'h6c6f2057;
        {data_array[1015],data_array[1014],data_array[1013],data_array[1012]}=32'h6f726c64;
        {data_array[1011],data_array[1010],data_array[1009],data_array[1008]}=32'h210a0000;


        data_out=32'h0000_0000;
    end

    always @(negedge clk) begin
        if(MemRead) begin
            data_out = {data_array[addr+3],data_array[addr+2],data_array[addr+1],data_array[addr]};
        end
    end

    always @(posedge clk) begin
        if(MemWrite) begin
            case (data_type)
                2'd1: begin //half word
                    data_array[addr] = write_data[7:0];
                    data_array[addr+1] = write_data[15:8];
                end

                2'd2: begin //byte
                    data_array[addr] = write_data[7:0];
                end
                
                default:begin //word
                    data_array[addr] = write_data[7:0];
                    data_array[addr+1] = write_data[15:8];
                    data_array[addr+2] = write_data[23:16];
                    data_array[addr+3] = write_data[31:24];
                end 
            endcase
            
        end
    end
    
endmodule