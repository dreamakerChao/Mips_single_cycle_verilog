module stage_control (
    input wire clk,
    output reg reg_clk,data_clk,pc_clk,imm_clk,reset_clk,done_tick
);
    parameter IF = 3'b000,
              ID = 3'b001,
              EXE = 3'b010,
              MEM = 3'b011,
              WB = 3'b100,
              RESET = 3'b101,
              DELAY_IF = 3'b110,
              DELAY_MEM = 3'b111;

    reg [2:0] state=3'b101, next_state=3'b101;

    always@(posedge clk) begin
        state<=next_state;
    end


    always@(*) begin
        case(state)
            RESET: begin 
                next_state<=IF;       
                reg_clk <= 1'b1; 
                data_clk <= 1'b0;
                pc_clk <=1'b1;
                imm_clk <= 1'b1;
                reset_clk <= 1'b1;
                done_tick <= 1'b0;
            end
            IF: begin
                next_state<=state+1;
                reg_clk <= 1'b1; 
                data_clk <= 1'b0;
                pc_clk <=1'b0;
                imm_clk <= 1'b1;
                reset_clk <= 1'b0;
                done_tick <= 1'b0;
            end
            ID: begin
                next_state<=DELAY_IF;
                reg_clk <= 1'b0; 
                data_clk <= 1'b0;
                pc_clk <=1'b1;
                imm_clk <= 1'b0;
                reset_clk <= 1'b0;
                done_tick <= 1'b1;
            end
            EXE: begin
                next_state<=state+1;
                reg_clk <= 1'b0; 
                data_clk <= 1'b0;
                pc_clk <=1'b1;
                imm_clk <= 1'b0;
                reset_clk <= 1'b0;
                done_tick <= 1'b0;
            end
            MEM: begin
                next_state<=DELAY_MEM;
                reg_clk <= 1'b0; 
                data_clk <= 1'b1;
                pc_clk <=1'b1;
                imm_clk <= 1'b0;
                reset_clk <= 1'b0;
                done_tick <= 1'b0;
            end
            
            WB: begin
                next_state<=0;
                reg_clk <= 1'b1; 
                data_clk <= 1'b0;
                pc_clk <=1'b1;
                imm_clk <= 1'b1;
                reset_clk <= 1'b0;
                done_tick <= 1'b0;
            end
            DELAY_IF: begin
                next_state<=ID;
                reg_clk <= 1'b1; 
                data_clk <= 1'b0;
                pc_clk <=1'b0;
                imm_clk <= 1'b0;
                reset_clk <= 1'b0;
                done_tick <= 1'b0;
            end

            DELAY_MEM: begin
                next_state<=state+1;
                next_state<=WB;
                reg_clk <= 1'b0; 
                data_clk <= 1'b0;
                pc_clk <=1'b1;
                imm_clk <= 1'b0;
                reset_clk <= 1'b0;
                done_tick <= 1'b0;
            end

        endcase
    end

    

endmodule