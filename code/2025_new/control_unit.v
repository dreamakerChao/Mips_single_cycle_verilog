`include "Control_encode.vh"
`include "Mips32_ISATbl.vh"

module Control_unit (
    input  wire [5:0] opcode,
    input  wire [5:0] funct,
    input  wire [4:0] rt,
    output reg  [21:0] control_word
);

    always @(*) begin
        case (opcode)
            `OP_J:       control_word = `CTRL_J;
            `OP_JAL:     control_word = `CTRL_JAL;
            `OP_BEQ:     control_word = `CTRL_BEQ;
            `OP_BNE:     control_word = `CTRL_BNE;
            `OP_BLEZ:    control_word = `CTRL_BLEZ;
            `OP_BGTZ:    control_word = `CTRL_BGTZ;
            `OP_ADDI:    control_word = `CTRL_ADDI;
            `OP_ADDIU:   control_word = `CTRL_ADDIU;
            `OP_SLTI:    control_word = `CTRL_SLTI;
            `OP_SLTIU:   control_word = `CTRL_SLTIU;
            `OP_ANDI:    control_word = `CTRL_ANDI;
            `OP_ORI:     control_word = `CTRL_ORI;
            `OP_XORI:    control_word = `CTRL_XORI;
            `OP_LUI:     control_word = `CTRL_LUI;
            `OP_LB:      control_word = `CTRL_LB;
            `OP_LH:      control_word = `CTRL_LH;
            `OP_LWL:     control_word = `CTRL_LWL;
            `OP_LW:      control_word = `CTRL_LW;
            `OP_LBU:     control_word = `CTRL_LBU;
            `OP_LHU:     control_word = `CTRL_LHU;
            `OP_LWR:     control_word = `CTRL_LWR;
            `OP_SB:      control_word = `CTRL_SB;
            `OP_SH:      control_word = `CTRL_SH;
            `OP_SWL:     control_word = `CTRL_SWL;
            `OP_SW:      control_word = `CTRL_SW;
            `OP_SWR:     control_word = `CTRL_SWR;
            `OP_REGIMM: begin
                case (rt)
                    `RT_BLTZ: control_word = `CTRL_BLTZ;
                    default:  control_word = 22'b0;
                endcase
            end
            `OP_SPECIAL: begin
                case (funct)
                    `FN_SLL:   control_word = `CTRL_SLL;
                    `FN_SRL:   control_word = `CTRL_SRL;
                    `FN_SRA:   control_word = `CTRL_SRA;
                    `FN_SLLV:  control_word = `CTRL_SLLV;
                    `FN_SRLV:  control_word = `CTRL_SRLV;
                    `FN_SRAV:  control_word = `CTRL_SRAV;
                    `FN_JR:    control_word = `CTRL_JR;
                    `FN_JALR:  control_word = `CTRL_JALR;
                    `FN_MFHI:  control_word = `CTRL_MFHI;
                    `FN_MTHI:  control_word = `CTRL_MTHI;
                    `FN_MFLO:  control_word = `CTRL_MFLO;
                    `FN_MTLO:  control_word = `CTRL_MTLO;
                    `FN_MULT:  control_word = `CTRL_MULT;
                    `FN_MULTU: control_word = `CTRL_MULTU;
                    `FN_DIV:   control_word = `CTRL_DIV;
                    `FN_DIVU:  control_word = `CTRL_DIVU;
                    `FN_ADD:   control_word = `CTRL_ADD;
                    `FN_ADDU:  control_word = `CTRL_ADDU;
                    `FN_SUB:   control_word = `CTRL_SUB;
                    `FN_SUBU:  control_word = `CTRL_SUBU;
                    `FN_AND:   control_word = `CTRL_AND;
                    `FN_OR:    control_word = `CTRL_OR;
                    `FN_XOR:   control_word = `CTRL_XOR;
                    `FN_NOR:   control_word = `CTRL_NOR;
                    `FN_SLT:   control_word = `CTRL_SLT;
                    `FN_SLTU:  control_word = `CTRL_SLTU;
                    default:   control_word = 22'b0;
                endcase
            end
            default: control_word = 22'b0;
        endcase
    end
endmodule
