module control_unit (
    input wire reset,
    input wire [5:0] op, // inst[31:26]
    input wire [5:0] funct, //inst_wire[5:0]

    output wire ifunsigned,RegDst,ALUSrc,MemtoReg,reg_write,MemRead,MemWrite,Branch,Jump,

    output reg [2:0]data_type,
    output reg [1:0]j_type,
    output reg [2:0]HiLotype,
    output wire [3:0]ALUop
                
);

// opcode
    parameter 	addi	=	6'b	001000	;
    parameter 	addiu	=	6'b	001001	;
    parameter 	andi	=	6'b	001100	;
    parameter 	ori	=	6'b	001101	;
    parameter 	beq	=	6'b	000100	;
    parameter 	blez	=	6'b	000110	;
    parameter 	bne	=	6'b	000101	;
    parameter 	bgtz	=	6'b	000111	;
    parameter 	lb	=	6'b	100000	;
    parameter 	lbu	=	6'b	100100	;
    parameter 	lhu	=	6'b	100101	;
    parameter 	lui	=	6'b	001111	;
    parameter 	lw	=	6'b	100011	;
    parameter 	slti	=	6'b	001010	;
    parameter 	sltiu	=	6'b	001011	;
    parameter 	sb	=	6'b	101000	;
    parameter 	sh	=	6'b	101001	;
    parameter 	sw	=	6'b	101011	;
    parameter 	jal	=	6'b	000011	;
    parameter 	j	=	6'b	000010	;

//funct
    parameter	add	=	6'b	100000	;
    parameter	addu	=	6'b	100001	;
    parameter	sra	=	6'b	000011	;
    parameter	andl	=	6'b	100100	;
    parameter	norl	=	6'b	100111	;
    parameter	orl	=	6'b	100101	;
    parameter	xorl	=	6'b	100110	;
    parameter	div	=	6'b	011010	;
    parameter	jalr	=	6'b	001001	;
    parameter	jr	=	6'b	001000	;
    parameter	sll	=	6'b	000000	;
    parameter	srl	=	6'b	000010	;
    parameter	mfhi	=	6'b	010000	;
    parameter	mflo	=	6'b	010010	;
    parameter	mthi	=	6'b	010001	;
    parameter	mtlo	=	6'b	010011	;
    parameter	mult	=	6'b	011000	;
    parameter	slt	=	6'b	101010	;
    parameter	sltu	=	6'b	101011	;
    parameter	sub	=	6'b	100010	;
    parameter	divu	=	6'b	011011	;
    parameter	multu	=	6'b	011001	;
    parameter	subu	=	6'b	100011	;

//code


    `include "control_encode.vh"

    reg [12:0]data=13'd0;

    always @(*) begin
        if (~reset) begin
            case(op)
            6'b00_0000: begin//R_type
                case (funct) 
                data = `CTRL(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0011);
                data = `CTRL(1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0011);
                data = `CTRL(1'b0, 1'b1, 1'bx, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b1011);
                data = `CTRL(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0000);
                data = `CTRL(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0001);
                data = `CTRL(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0001);
                data = `CTRL(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0010);
                data = `CTRL(1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b1111);
                data = `CTRL(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 4'b0000);
                data = `CTRL(1'b0, 1'b1, 1'bx, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 4'b0000);
                data = `CTRL(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b1001);
                data = `CTRL(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b1011);
                data = `CTRL(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0000);
                data = `CTRL(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0000);
                data = `CTRL(1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0000);
                data = `CTRL(1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0000);
                data = `CTRL(1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b1110);
                data = `CTRL(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0110);
                data = `CTRL(1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0110);
                data = `CTRL(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0100);
                data = `CTRL(1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b1111);
                data = `CTRL(1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b1110);
                data = `CTRL(1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0100);

                    default:  data=13'd0;
                endcase
            end
            
                data = `CTRL(1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0011);
                data = `CTRL(1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0011);
                data = `CTRL(1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0000);
                data = `CTRL(1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0001);
                data = `CTRL(1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 4'b0100);
                data = `CTRL(1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 4'b0111);
                data = `CTRL(1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 4'b1101);
                data = `CTRL(1'b0, 1'bx, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 4'b0111);
                data = `CTRL(1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 4'b0011);
                data = `CTRL(1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 4'b0011);
                data = `CTRL(1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 4'b0011);
                data = `CTRL(1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 4'b0011);
                data = `CTRL(1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 4'b0011);
                data = `CTRL(1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0110);
                data = `CTRL(1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 4'b0110);
                data = `CTRL(1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 4'b0011);
                data = `CTRL(1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 4'b0011);
                data = `CTRL(1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 4'b0011);
                data = `CTRL(1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 4'b0000);
                data = `CTRL(1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 4'b0000);
            default: data=13'd0; 
            endcase
        end
        else begin
            data = 13'd0;
        end
    end
    
    always@(op) begin //load and store special
        case (op)
            //load
            //data_type = {data_unsigned?,type}
            //type: 00 word, 01 halfword, 10 byte.
            lb:data_type=3'b010;
            lbu:data_type=3'b110;
            lhu:data_type=3'b101;
            lw:data_type=3'b000;
            //store
            sb:data_type=3'b010;
            sh:data_type=3'b001;
            sw:data_type=3'b100;
            default:data_type=3'b000;
        endcase
        
    end

    always@(op,funct) begin
        if(op==jal) begin
            j_type=2'b10;
        end else if(op==6'd0)begin
            case(funct)
                jalr: j_type=2'b11;
                jr: j_type=2'b01;
                default: j_type=2'b00;
            endcase
        end
        else begin
            j_type=2'b00;
        end
    end

    always@(op,funct) begin
        if(op==6'd0)begin
            case(funct)
                    //Read,Write
                    /* Hi Lo R/W 
                      */
                mthi: HiLotype=3'b101;
                mtlo: HiLotype=3'b011;
                mfhi: HiLotype=3'b100;
                mflo: HiLotype=3'b010;

                mult: HiLotype=3'b111;
                multu: HiLotype=3'b111;

                div: HiLotype=3'b111;
                divu: HiLotype=3'b111;
                default:  HiLotype=3'b000;//others
            endcase
        end
        else begin
            HiLotype=3'b000;
        end
    end


    assign {ifunsigned,RegDst,ALUSrc,MemtoReg,reg_write,MemRead,MemWrite,Branch,Jump,ALUop[3],ALUop[2],ALUop[1],ALUop[0]}  = data;
        // rt,rd 
        //data,sign ex  
        //alu result,data
        //oo+,01-,10 func       
endmodule