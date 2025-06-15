`timescale 1ns / 1ps
`include "Mips32_ISATbl.vh"

module control_tb;

    // DUT inputs
    reg [5:0] opcode;
    reg [5:0] funct;

    // DUT output
    wire [21:0] control_word;

    // Instantiate the DUT
    Control_unit dut (
        .opcode(opcode),
        .funct(funct),
        .control_word(control_word)
    );

    // Memory to hold test input and expected output
    reg [31:0] control_inputs [0:67];
    reg [21:0] expected_control_words [0:67];
    integer i, index;

    // Output file pointer
    integer result_fp;

    initial begin
        $readmemh("control_test.mem", control_inputs);
        $readmemb("check_signal.mem", expected_control_words);
        result_fp = $fopen("test_result.txt", "w");

        for (i = 0; i < 68; i = i + 1) begin
            opcode = control_inputs[i][31:26];
            funct  = control_inputs[i][5:0];

            index = decode_inst_index(control_inputs[i]);

            if (index == -1) begin
                $display("[SKIP] Unknown instruction encoding: %h", control_inputs[i]);
                $fdisplay(result_fp, "[SKIP] Unknown instruction encoding: %h", control_inputs[i]);
            end else begin
                #1;
                if (control_word !== expected_control_words[index]) begin
                    $display("[FAIL] index=%0d | opcode=0x%02h funct=0x%02h | expected=%022b got=%022b",
                             index, opcode, funct,
                             expected_control_words[index], control_word);
                    $fdisplay(result_fp, "[FAIL] index=%0d | opcode=0x%02h funct=0x%02h | expected=%022b got=%022b",
                              index, opcode, funct,
                              expected_control_words[index], control_word);
                end else begin
                    $display("[PASS] index=%0d | control_word=%022b", index, control_word);
                    $fdisplay(result_fp, "[PASS] index=%0d | control_word=%022b", index, control_word);
                end
            end
        end

        $fclose(result_fp);
        $finish;
    end

    function integer decode_inst_index;
        input [31:0] inst;
        reg [5:0] op;
        reg [5:0] fn;
        reg [4:0] rt;
        begin
            op = inst[31:26];
            fn = inst[5:0];
            rt = inst[20:16];

            case (op)
                `OP_J:     decode_inst_index = 0;
                `OP_JAL:   decode_inst_index = 1;
                `OP_BEQ:   decode_inst_index = 2;
                `OP_BNE:   decode_inst_index = 3;
                `OP_BLEZ:  decode_inst_index = 4;
                `OP_BGTZ:  decode_inst_index = 5;
                `OP_ADDI:  decode_inst_index = 6;
                `OP_ADDIU: decode_inst_index = 7;
                `OP_SLTI:  decode_inst_index = 8;
                `OP_SLTIU: decode_inst_index = 9;
                `OP_ANDI:  decode_inst_index = 10;
                `OP_ORI:   decode_inst_index = 11;
                `OP_XORI:  decode_inst_index = 12;
                `OP_LUI:   decode_inst_index = 13;
                `OP_LB:    decode_inst_index = 14;
                `OP_LH:    decode_inst_index = 15;
                `OP_LWL:   decode_inst_index = 16;
                `OP_LW:    decode_inst_index = 17;
                `OP_LBU:   decode_inst_index = 18;
                `OP_LHU:   decode_inst_index = 19;
                `OP_LWR:   decode_inst_index = 20;
                `OP_SB:    decode_inst_index = 21;
                `OP_SH:    decode_inst_index = 22;
                `OP_SWL:   decode_inst_index = 23;
                `OP_SW:    decode_inst_index = 24;
                `OP_SWR:   decode_inst_index = 25;
                `OP_REGIMM: begin
                    case (rt)
                        `RT_BLTZ: decode_inst_index = 26;
                        default:  decode_inst_index = -1;
                    endcase
                end
                `OP_SPECIAL: begin
                    case (fn)
                        `FN_SLL:    decode_inst_index = 27;
                        `FN_SRL:    decode_inst_index = 28;
                        `FN_SRA:    decode_inst_index = 29;
                        `FN_SLLV:   decode_inst_index = 30;
                        `FN_SRLV:   decode_inst_index = 31;
                        `FN_SRAV:   decode_inst_index = 32;
                        `FN_JR:     decode_inst_index = 33;
                        `FN_JALR:   decode_inst_index = 34;
                        `FN_MFHI:   decode_inst_index = 35;
                        `FN_MTHI:   decode_inst_index = 36;
                        `FN_MFLO:   decode_inst_index = 37;
                        `FN_MTLO:   decode_inst_index = 38;
                        `FN_MULT:   decode_inst_index = 39;
                        `FN_MULTU:  decode_inst_index = 40;
                        `FN_DIV:    decode_inst_index = 41;
                        `FN_DIVU:   decode_inst_index = 42;
                        `FN_ADD:    decode_inst_index = 43;
                        `FN_ADDU:   decode_inst_index = 44;
                        `FN_SUB:    decode_inst_index = 45;
                        `FN_SUBU:   decode_inst_index = 46;
                        `FN_AND:    decode_inst_index = 47;
                        `FN_OR:     decode_inst_index = 48;
                        `FN_XOR:    decode_inst_index = 49;
                        `FN_NOR:    decode_inst_index = 50;
                        `FN_SLT:    decode_inst_index = 51;
                        `FN_SLTU:   decode_inst_index = 52;
                        default:    decode_inst_index = -1;
                    endcase
                end
                default: decode_inst_index = -1;
            endcase
        end
    endfunction

endmodule
