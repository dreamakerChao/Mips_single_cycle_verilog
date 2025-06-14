// -----------------------------------------------------------------------------
// Control Unit Template for MIPS32
// -----------------------------------------------------------------------------
`include "Control_encode.vh"  // Contains CTRL_* and ALU_* defines
`include "Mips32_ISATbl.vh"  // Contains OP_* and FN_* defines

module Control_unit (
    input  wire [5:0] opcode,
    input  wire [5:0] funct,
    output wire  [20:0] control_word
);

    reg HI_WRITE;
    reg HI_READ;
    reg LO_WRITE;
    reg LO_READ;
    reg IFUNSIGNED;
    reg REGDST;
    reg ALUSRC;
    reg MEMTOREG;
    reg REGWRITE;
    reg MEMREAD;
    reg MEMWRITE;
    reg BRANCH;
    reg JUMP;
    reg [3:0]ALUOP;
    reg LINKED;
    reg RETURN;
    reg [1:0]DATA_TYPE;


    // HI_WRITE
    always @(*) begin
        if (opcode == `OP_SPECIAL &&
            (funct == `FN_MTHI || funct == `FN_MULT ||
            funct == `FN_MULTU || funct == `FN_DIV ||
            funct == `FN_DIVU)) begin
            HI_WRITE = 1'b1; // HI_WRITE
        end else begin
            HI_WRITE = 1'b0; // HI_WRITE
        end
    end

    // HI_READ
    always @(*) begin
        if(opcode == `OP_SPECIAL &&
            (funct == `FN_MFHI || funct == `FN_MULT ||
            funct == `FN_MULTU || funct == `FN_DIV ||
            funct == `FN_DIVU)) begin
            HI_READ = 1'b1; // HI_READ
        end else begin
            HI_READ = 1'b0; // HI_READ
        end
    end

    // LO_WRITE
    always @(*) begin
        if (opcode == `OP_SPECIAL &&
            (funct == `FN_MTLO || funct == `FN_MULT ||
            funct == `FN_MULTU || funct == `FN_DIV ||
            funct == `FN_DIVU)) begin
            LO_WRITE = 1'b1; // LO_WRITE
        end else begin
            LO_WRITE = 1'b0; // LO_WRITE
        end
    end

    // LO_READ
    always @(*) begin
        if(opcode == `OP_SPECIAL &&
            (funct == `FN_MFLO || funct == `FN_MULT ||
            funct == `FN_MULTU || funct == `FN_DIV ||
            funct == `FN_DIVU)) begin
            LO_READ = 1'b1; // LO_READ
        end else begin
            LO_READ = 1'b0; // LO_READ
        end
    end

    // IFUNSIGNED
    always @(*) begin
        if (
            // R-type unsigned operations
            (opcode == `OP_SPECIAL &&
            (funct == `FN_MULTU || funct == `FN_DIVU)) ||

            // I-type unsigned operations or loads
            (opcode == `OP_ADDIU ||
            opcode == `OP_SLTIU ||
            opcode == `OP_LBU   ||
            opcode == `OP_LHU)
        ) begin
            IFUNSIGNED = 1'b1; // IFUNSIGNED
        end else begin
            IFUNSIGNED = 1'b0; // IFUNSIGNED
        end
    end


    // REGDST
    // 0: rt, 1: rd
    always @(*) begin
        if (opcode == `OP_SPECIAL) begin
            REGDST = 1'b1; // R-type rd
        end else begin
            REGDST = 1'b0; // I-type rt
        end
    end

    // ALUSRC
    // 0: reg_out
    // 1: immediate
    always @(*) begin
        case (opcode)
            `OP_ADDI, `OP_ADDIU,
            `OP_ANDI, `OP_ORI, `OP_XORI,
            `OP_SLTI, `OP_SLTIU,
            `OP_LUI,
            `OP_LB, `OP_LH, `OP_LW, `OP_LBU, `OP_LHU, `OP_LWL, `OP_LWR,
            `OP_SB, `OP_SH, `OP_SW, `OP_SWL, `OP_SWR:
                ALUSRC = 1'b1; // Use immediate for I-type and load/store
            default:
                ALUSRC = 1'b0; // Use register for R-type
        endcase
    end

    // MEMTOREG
    // 0: ALU_out
    // 1: data (memory read)
    always @(*) begin
        if (opcode == `OP_LB  || opcode == `OP_LH  || opcode == `OP_LW  ||
            opcode == `OP_LBU || opcode == `OP_LHU || opcode == `OP_LWL ||
            opcode == `OP_LWR) begin
            MEMTOREG = 1'b1; // Load instructions write memory data to register
        end else begin
            MEMTOREG = 1'b0; // Otherwise, write ALU result to register
        end
    end

    // REGWRITE
    // 0: false (do not write to register file)
    // 1: true  (write to register file)
    always @(*) begin
        case (opcode)
            // R-type: only MFHI, MFLO, and others like ADD/SUB write to register
            `OP_SPECIAL: begin
                case (funct)
                    `FN_JR,
                    `FN_MTHI, `FN_MTLO,
                    `FN_MULT, `FN_MULTU,
                    `FN_DIV,  `FN_DIVU:
                        REGWRITE = 1'b0;

                    default:
                        REGWRITE = 1'b1; // other R-type
                endcase
            end

            // I-type: write-back instructions
            `OP_ADDI, `OP_ADDIU,
            `OP_ANDI, `OP_ORI, `OP_XORI,
            `OP_SLTI, `OP_SLTIU,
            `OP_LUI,
            `OP_LB, `OP_LH, `OP_LW, `OP_LBU, `OP_LHU, `OP_LWL, `OP_LWR:
                REGWRITE = 1'b1;

            // J-type with link (JAL writes to $ra)
            `OP_JAL:
                REGWRITE = 1'b1;

            default:
                REGWRITE = 1'b0;
        endcase
    end



    // MEMREAD
    // 0: false (do not read memory)
    // 1: true  (read memory)
    always @(*) begin
        case (opcode)
            `OP_LB, `OP_LH, `OP_LW,
            `OP_LBU, `OP_LHU,
            `OP_LWL, `OP_LWR:
                MEMREAD = 1'b1; // Load instructions require memory read

            default:
                MEMREAD = 1'b0;
        endcase
    end

    // MEMWRITE
    // 0: false (do not write memory)
    // 1: true  (write memory)
    always @(*) begin
        case (opcode)
            // Store instructions
            `OP_SB, `OP_SH, `OP_SW, `OP_SWL, `OP_SWR:
                MEMWRITE = 1'b1;
            default:
                MEMWRITE = 1'b0;
        endcase
    end

    // BRANCH
    // 0: false (do not branch)
    // 1: true  (branch)
    always @(*) begin
        case (opcode)
            //branch instructions
            `OP_BEQ, `OP_BNE, `OP_BGTZ, `OP_BLEZ:
                BRANCH = 1'b1;
            `OP_REGIMM:begin
                if(funct==`RT_BLTZ)
                    BRANCH = 1'b1; // BLTZ   
            end
            default:
                BRANCH = 1'b0;
        endcase
    end

    // JUMP
    // 0: false (do not jump)
    // 1: true  (jump)
    always @(*) begin
        case (opcode)
            `OP_J, `OP_JAL: JUMP = 1'b1;
            `OP_SPECIAL: begin
                case (funct)
                    `FN_JR, `FN_JALR: JUMP = 1'b1;
                    default: JUMP = 1'b0;
                endcase
            end
            default: JUMP = 1'b0;
        endcase
    end

    // ALUOP
    always @(*) begin
        case (opcode)
            // R-type instructions
            `OP_SPECIAL: begin
                case (funct)
                    `FN_ADD, `FN_ADDU:       ALUOP = `ALU_ADD;
                    `FN_SUB, `FN_SUBU:       ALUOP = `ALU_SUB;
                    `FN_AND:                 ALUOP = `ALU_AND;
                    `FN_OR:                  ALUOP = `ALU_OR;
                    `FN_XOR:                 ALUOP = `ALU_XOR;
                    `FN_NOR:                 ALUOP = `ALU_NOR;
                    `FN_SLT:                 ALUOP = `ALU_SLT;
                    `FN_SLTU:                ALUOP = `ALU_SLTU;
                    `FN_SLL, `FN_SLLV:       ALUOP = `ALU_SLL;
                    `FN_SRL, `FN_SRLV:       ALUOP = `ALU_SRL;
                    `FN_SRA, `FN_SRAV:       ALUOP = `ALU_SRA;
                    `FN_MULT, `FN_MULTU:     ALUOP = `ALU_MUL;
                    `FN_DIV, `FN_DIVU:       ALUOP = `ALU_DIV;
                    default:                 ALUOP = 4'd0;
                endcase
            end

            // I-type arithmetic instructions
            `OP_ADDI, `OP_ADDIU,
            `OP_LW, `OP_LB, `OP_LH, `OP_LBU, `OP_LHU, `OP_LWL, `OP_LWR,
            `OP_SW, `OP_SB, `OP_SH, `OP_SWL, `OP_SWR,
            `OP_LL, `OP_SC:
                ALUOP = `ALU_ADD;

            `OP_ANDI:     ALUOP = `ALU_AND;
            `OP_ORI:      ALUOP = `ALU_OR;
            `OP_XORI:     ALUOP = `ALU_XOR;
            `OP_SLTI:     ALUOP = `ALU_SLT;
            `OP_SLTIU:    ALUOP = `ALU_SLTU;

            // Branch instructions
            `OP_BEQ, `OP_BNE:
                ALUOP = `ALU_EQ;

            `OP_BLEZ:
                ALUOP = `ALU_LE;

            `OP_BGTZ:
                ALUOP = `ALU_GE;

            `OP_REGIMM: // Branch on register
            begin
                if(funct==`RT_BLTZ)
                    ALUOP = `ALU_LT; // BLTZ
            end
            `OP_BLTZ:
                ALUOP = `ALU_LE;

            default:
                ALUOP = 4'd0;
        endcase
    end


    // LINKED
    // 0: false (not linked)
    // 1: true  (linked, e.g., JAL)
    always @(*) begin
        if (opcode == `OP_JAL || (opcode == `OP_SPECIAL && funct == `FN_JALR))
            LINKED = 1'b1;
        else
            LINKED = 1'b0;
    end

    // RETURN
    // 0: false (not returning)
    // 1: true  (returning, e.g., JR)
    always @(*) begin
        if (opcode == `OP_SPECIAL && funct == `FN_JR)
            RETURN = 1'b1;
        else
            RETURN = 1'b0;
    end

    // DATA_TYPE
    // 00: word, 01: half, 10: byte
    always @(*) begin
        case (opcode)
            // Byte
            `OP_LB, `OP_LBU, `OP_SB:
                DATA_TYPE = 2'b10;

            // Halfword
            `OP_LH, `OP_LHU, `OP_SH:
                DATA_TYPE = 2'b01;

            default:
                DATA_TYPE = 2'b00; //defalut word
        endcase
    end


    // output control word
    assign control_word = {
        HI_WRITE, HI_READ, LO_WRITE, LO_READ,
        IFUNSIGNED, REGDST, ALUSRC, MEMTOREG,
        REGWRITE, MEMREAD, MEMWRITE, BRANCH,
        JUMP, ALUOP, LINKED, RETURN, DATA_TYPE
    };
endmodule
