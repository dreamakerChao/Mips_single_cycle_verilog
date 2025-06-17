`timescale 1ns / 1ps
`include "Mips32_ISATbl.vh"

module control_tb;

    // DUT inputs
    reg [5:0] opcode;
    reg [5:0] funct;
    reg [4:0] rt;

    // DUT output
    wire [21:0] control_word;

    // Instantiate the DUT
    Control_unit dut (
        .opcode(opcode),
        .funct(funct),
        .rt(rt),
        .control_word(control_word)
    );

    // Control signal decomposition
    wire HI_WRITE     = control_word[21];
    wire HI_READ      = control_word[20];
    wire LO_WRITE     = control_word[19];
    wire LO_READ      = control_word[18];
    wire IFUNSIGNED   = control_word[17];
    wire REGDST       = control_word[16];
    wire ALUSRC       = control_word[15];
    wire MEMTOREG     = control_word[14];
    wire REGWRITE     = control_word[13];
    wire MEMREAD      = control_word[12];
    wire MEMWRITE     = control_word[11];
    wire BRANCH       = control_word[10];
    wire JUMP         = control_word[9];
    wire LINKED       = control_word[8];
    wire RETURN       = control_word[7];
    wire [3:0] ALUOP   = control_word[6:3];
    wire SHIFT_V      = control_word[2];
    wire [1:0] DATA_TYPE = control_word[1:0];

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
            rt     = control_inputs[i][20:16];

            index = decode_inst_index(control_inputs[i]);

            if (index == -1) begin
                $display(">[SKIP] Unknown instruction encoding: %h", control_inputs[i]);
                $fdisplay(result_fp, ">[SKIP] Unknown instruction encoding: %h", control_inputs[i]);
            end else begin
                #1;
                if (control_word !== expected_control_words[index]) begin
                    $display(">>[FAIL] index=%0d (%s) | opcode=0x%02h funct=0x%02h", index, decode_inst_name(index), opcode, funct);
                    $fdisplay(result_fp, ">>[FAIL] index=%0d (%s) | opcode=0x%02h funct=0x%02h", index, decode_inst_name(index), opcode, funct);
                    display_mismatched_signals(expected_control_words[index], control_word);
                end else begin
                    $display("[PASS] index=%0d (%s)", index, decode_inst_name(index));
                    $fdisplay(result_fp, "[PASS] index=%0d (%s)", index, decode_inst_name(index));
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

    function [8*8:1] decode_inst_name;
        input integer index;
        begin
            case (index)
                0: decode_inst_name = "J";
                1: decode_inst_name = "JAL";
                2: decode_inst_name = "BEQ";
                3: decode_inst_name = "BNE";
                4: decode_inst_name = "BLEZ";
                5: decode_inst_name = "BGTZ";
                6: decode_inst_name = "ADDI";
                7: decode_inst_name = "ADDIU";
                8: decode_inst_name = "SLTI";
                9: decode_inst_name = "SLTIU";
                10: decode_inst_name = "ANDI";
                11: decode_inst_name = "ORI";
                12: decode_inst_name = "XORI";
                13: decode_inst_name = "LUI";
                14: decode_inst_name = "LB";
                15: decode_inst_name = "LH";
                16: decode_inst_name = "LWL";
                17: decode_inst_name = "LW";
                18: decode_inst_name = "LBU";
                19: decode_inst_name = "LHU";
                20: decode_inst_name = "LWR";
                21: decode_inst_name = "SB";
                22: decode_inst_name = "SH";
                23: decode_inst_name = "SWL";
                24: decode_inst_name = "SW";
                25: decode_inst_name = "SWR";
                26: decode_inst_name = "BLTZ";
                27: decode_inst_name = "SLL";
                28: decode_inst_name = "SRL";
                29: decode_inst_name = "SRA";
                30: decode_inst_name = "SLLV";
                31: decode_inst_name = "SRLV";
                32: decode_inst_name = "SRAV";
                33: decode_inst_name = "JR";
                34: decode_inst_name = "JALR";
                35: decode_inst_name = "MFHI";
                36: decode_inst_name = "MTHI";
                37: decode_inst_name = "MFLO";
                38: decode_inst_name = "MTLO";
                39: decode_inst_name = "MULT";
                40: decode_inst_name = "MULTU";
                41: decode_inst_name = "DIV";
                42: decode_inst_name = "DIVU";
                43: decode_inst_name = "ADD";
                44: decode_inst_name = "ADDU";
                45: decode_inst_name = "SUB";
                46: decode_inst_name = "SUBU";
                47: decode_inst_name = "AND";
                48: decode_inst_name = "OR";
                49: decode_inst_name = "XOR";
                50: decode_inst_name = "NOR";
                51: decode_inst_name = "SLT";
                52: decode_inst_name = "SLTU";
                default: decode_inst_name = "UNKNOWN";
            endcase
        end
    endfunction

        // Display control signals
    // Function to display mismatched control signals
    task display_mismatched_signals;
        input [21:0] expected;
        input [21:0] actual;
        integer b;
        begin
            $display("    >> Mismatched signals (expected vs actual):");
            $fdisplay(result_fp, "    >> Mismatched signals (expected vs actual):");
            $display("    expected = %022b", expected);
            $display("    actual   = %022b", actual);
            $fdisplay(result_fp, "    expected = %022b", expected);
            $fdisplay(result_fp, "    actual   = %022b", actual);
            for (b = 21; b >= 0; b = b - 1) begin
                if (expected[b] !== actual[b]) begin
                    case (b)
                        21: begin $display("      HI_WRITE       : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      HI_WRITE       : %b != %b", expected[b], actual[b]); end
                        20: begin $display("      HI_READ        : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      HI_READ        : %b != %b", expected[b], actual[b]); end
                        19: begin $display("      LO_WRITE       : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      LO_WRITE       : %b != %b", expected[b], actual[b]); end
                        18: begin $display("      LO_READ        : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      LO_READ        : %b != %b", expected[b], actual[b]); end
                        17: begin $display("      IFUNSIGNED     : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      IFUNSIGNED     : %b != %b", expected[b], actual[b]); end
                        16: begin $display("      REGDST         : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      REGDST         : %b != %b", expected[b], actual[b]); end
                        15: begin $display("      ALUSRC         : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      ALUSRC         : %b != %b", expected[b], actual[b]); end
                        14: begin $display("      MEMTOREG       : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      MEMTOREG       : %b != %b", expected[b], actual[b]); end
                        13: begin $display("      REGWRITE       : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      REGWRITE       : %b != %b", expected[b], actual[b]); end
                        12: begin $display("      MEMREAD        : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      MEMREAD        : %b != %b", expected[b], actual[b]); end
                        11: begin $display("      MEMWRITE       : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      MEMWRITE       : %b != %b", expected[b], actual[b]); end
                        10: begin $display("      BRANCH         : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      BRANCH         : %b != %b", expected[b], actual[b]); end
                        9: begin $display("      JUMP           : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      JUMP           : %b != %b", expected[b], actual[b]); end
                        8: begin $display("      LINKED         : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      LINKED         : %b != %b", expected[b], actual[b]); end
                        7: begin $display("      RETURN         : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      RETURN         : %b != %b", expected[b], actual[b]); end
                        6: begin $display("      ALUOP[3]       : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      ALUOP[3]       : %b != %b", expected[b], actual[b]); end
                        5: begin $display("      ALUOP[2]       : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      ALUOP[2]       : %b != %b", expected[b], actual[b]); end
                        4: begin $display("      ALUOP[1]       : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      ALUOP[1]       : %b != %b", expected[b], actual[b]); end
                        3: begin $display("      ALUOP[0]       : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      ALUOP[0]       : %b != %b", expected[b], actual[b]); end
                        2: begin $display("      SHIFT_V        : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      SHIFT_V        : %b != %b", expected[b], actual[b]); end
                        1: begin $display("      DATA_TYPE[1]   : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      DATA_TYPE[1]   : %b != %b", expected[b], actual[b]); end
                        0: begin $display("      DATA_TYPE[0]   : %b != %b", expected[b], actual[b]); $fdisplay(result_fp, "      DATA_TYPE[0]   : %b != %b", expected[b], actual[b]); end
                    endcase
                end
            end
        end
    endtask


endmodule
