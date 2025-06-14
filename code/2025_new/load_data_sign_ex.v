//for lb,lh...etc.
module Load_data_sign_ex (
    input wire [31:0]data_in,
    input wire [15:0]immediate,

    input wire ifunsigned,
    input wire [1:0]type,
    
    output reg [31:0]data_out
);
 
    always @(*) begin
        case(type)
            2'd1: begin //half word
                if(ifunsigned) begin
                    data_out={16'd0,data_in[15:0]};
                end
                else begin 
                    if(data_in[15]==1) begin
                        data_out={16'hffff,data_in[15:0]};
                    end
                    else begin
                        data_out={16'd0,data_in[15:0]};
                    end
                end 
            end

            2'd2: begin //byte
                if(ifunsigned) begin
                    data_out={24'd0,data_in[7:0]};
                end
                else begin 
                    if(data_in[7]==1) begin
                        data_out={24'hffff_ff,data_in[7:0]};
                    end
                    else begin
                        data_out={24'd0,data_in[7:0]};
                    end
                end
            end
            2'd3: begin //lui
                data_out = {immediate,16'd0};
            end
            default:begin //word
                data_out=data_in;
            end
        endcase
    end

    
endmodule
