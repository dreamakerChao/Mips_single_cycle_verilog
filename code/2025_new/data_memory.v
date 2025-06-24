module Data_memory #(
    parameter MEM_BYTES =  16384  // 16KB
)(
    input  wire         clk,
    input  wire [13:0]   addr,        // byte address
    input  wire [31:0]  write_data,
    input  wire         MemRead,
    input  wire         MemWrite,
    input  wire         ifunsigned,  // 1: zero-extend, 0: sign-extend
    input  wire [2:0]   data_type,   // see define
    input  wire [31:0]  rt_val,      // for LWL/LWR
    output reg  [31:0]  data_out
);

    (* ram_style = "block" *)
    reg [7:0] mem [0:MEM_BYTES-1];

    initial begin : init_mem
        integer i;
        for (i = 0; i < MEM_BYTES; i = i + 1)
            mem[i] = 8'd0;
    end

    wire [1:0] align = addr[1:0]; // for LWL/LWR

    always @(posedge clk) begin
        // ---------------- write ----------------
        if (MemWrite) begin
            case (data_type)
                `DATA_TYPE_BYTE: begin
                    mem[addr] <= write_data[7:0];
                end
                `DATA_TYPE_HALF: begin
                    mem[addr]     <= write_data[15:8];  // MSB
                    mem[addr + 1] <= write_data[7:0];   // LSB
                end
                default: begin // word
                    mem[addr]     <= write_data[31:24];  // MSB
                    mem[addr + 1] <= write_data[23:16];
                    mem[addr + 2] <= write_data[15:8];
                    mem[addr + 3] <= write_data[7:0];    // LSB
                end
            endcase
        end

        // ---------------- read ----------------
        if (MemRead) begin
            case (data_type)
                `DATA_TYPE_WORD: begin
                    data_out <= {mem[addr], mem[addr + 1], mem[addr + 2], mem[addr + 3]};
                end
                `DATA_TYPE_HALF: begin
                    data_out <= ifunsigned ?
                        {16'd0, mem[addr], mem[addr + 1]} :
                        {{16{mem[addr][7]}}, mem[addr], mem[addr + 1]};
                end
                `DATA_TYPE_BYTE: begin
                    data_out <= ifunsigned ?
                        {24'd0, mem[addr]} :
                        {{24{mem[addr][7]}}, mem[addr]};
                end
                `DATA_TYPE_WORDL: begin
                    case (align)
                        2'b00: data_out <= {mem[addr], mem[addr + 1], mem[addr + 2], mem[addr + 3]};
                        2'b01: data_out <= {rt_val[7:0], mem[addr], mem[addr + 1], mem[addr + 2]};
                        2'b10: data_out <= {rt_val[15:0], mem[addr], mem[addr + 1]};
                        2'b11: data_out <= {rt_val[23:0], mem[addr]};
                    endcase
                end
                `DATA_TYPE_WORDR: begin
                    case (align)
                        2'b00: data_out <= {mem[addr], rt_val[31:8]};
                        2'b01: data_out <= {mem[addr], mem[addr + 1], rt_val[31:16]};
                        2'b10: data_out <= {mem[addr], mem[addr + 1], mem[addr + 2], rt_val[31:24]};
                        2'b11: data_out <= {mem[addr], mem[addr + 1], mem[addr + 2], mem[addr + 3]};
                    endcase
                end
                default: data_out <= 32'd0;
            endcase
        end

        data_out <= 32'd0;

    end

endmodule
