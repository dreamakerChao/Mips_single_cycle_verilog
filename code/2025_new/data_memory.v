module data_memory #(
    // 1 KiB = 1024 bytes
    parameter MEM_BYTES = 1024
)(
    input  wire         clk,
    input  wire [9:0]   addr,        // byte address
    input  wire [31:0]  write_data,
    input  wire         MemRead,
    input  wire         MemWrite,
    input  wire [1:0]   data_type,   // 0:word  1:half  2:byte
    output reg  [31:0]  data_out
);

    // -------------------------------------------------------------------------
    // 1 KiB single-port BRAM, byte-wide
    // -------------------------------------------------------------------------
    (* ram_style = "block" *)
    reg [7:0] mem [0:MEM_BYTES-1];

    // optional: load initial contents from hex file
    initial begin
        integer i;
        // zero-clear entire BRAM
        // for (i = 0; i < MEM_BYTES; i = i + 1)
        //     mem[i] = 8'd0;

        $readmemh("data_init.mem", mem);
    end

    // -------------------------------------------------------------------------
    // synchronous read + write (single clock edge)
    // -------------------------------------------------------------------------
    always @(posedge clk) begin
        // --------------- write ---------------
        if (MemWrite) begin
            case (data_type)
                2'd2: begin                       // byte
                    mem[addr] <= write_data[7:0];
                end
                2'd1: begin                       // half-word
                    mem[addr]     <= write_data[7:0];
                    mem[addr + 1] <= write_data[15:8];
                end
                default: begin                    // word
                    mem[addr]     <= write_data[7:0];
                    mem[addr + 1] <= write_data[15:8];
                    mem[addr + 2] <= write_data[23:16];
                    mem[addr + 3] <= write_data[31:24];
                end
            endcase
        end

        // --------------- read ---------------
        if (MemRead) begin
            data_out <= {mem[addr + 3],
                         mem[addr + 2],
                         mem[addr + 1],
                         mem[addr    ]};
        end
        else begin
            data_out <= 32'h0;
        end
    end

endmodule
