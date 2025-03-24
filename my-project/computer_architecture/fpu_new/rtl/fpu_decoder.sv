module rv32f_decoder (
    input [31:0] instr,        // 32-bit instruction input
    output reg [4:0] rs1, rs2, rs3, rd, rm, // Register fields and rounding mode
    output reg [11:0] imm,                    // Immediate field
    output reg [6:0] opcode,                  // Opcode field
    output reg [2:0] funct3,                  // funct3 field
    output reg [6:0] funct7,                  // funct7 field
    output reg [1:0] instr_type               // Instruction type (FP load/store/arithmetic)
);

    always @(*) begin
        // Default values for all outputs
        rs1 = 5'b0;
        rs2 = 5'b0;
        rs3 = 5'b0;
        rd  = 5'b0;
        rm  = 5'b0;
        imm = 12'b0;
        opcode = instr[6:0];   // Opcode is always bits 6:0
        funct3 = instr[14:12]; // funct3 is bits 14:12
        funct7 = instr[31:25]; // funct7 is bits 31:25
        instr_type = 2'b00;    // Default: No instruction

        case (opcode)
            7'b0000111: begin // FLW (Load Floating-Point Word)
                rd  = instr[11:7];
                rs1 = instr[19:15];
                imm = instr[31:20]; // 12-bit immediate value
                instr_type = 2'b01; // Load-type FP instruction
            end

            7'b0100111: begin // FSW (Store Floating-Point Word)
                rs1 = instr[19:15];
                rs2 = instr[24:20];
                imm = {instr[31:25], instr[11:7]}; // Store immediate
                instr_type = 2'b10; // Store-type FP instruction
            end

            // FMADD.S and variants (requires 3 source registers and rounding mode)
            7'b1000011: begin // FMADD.S
                rd  = instr[11:7];
                rs1 = instr[19:15];
                rs2 = instr[24:20];
                rs3 = instr[31:27]; // 3rd source register
                rm  = instr[14:12]; // Rounding mode
                instr_type = 2'b11; // Fused Multiply-Add (MADD) FP instruction
            end

            7'b1000111: begin // FMSUB.S
                rd  = instr[11:7];
                rs1 = instr[19:15];
                rs2 = instr[24:20];
                rs3 = instr[31:27]; // 3rd source register
                rm  = instr[14:12]; // Rounding mode
                instr_type = 2'b11; // Fused Multiply-Subtract (MSUB) FP instruction
            end

            7'b1001111: begin // FNMSUB.S
                rd  = instr[11:7];
                rs1 = instr[19:15];
                rs2 = instr[24:20];
                rs3 = instr[31:27]; // 3rd source register
                rm  = instr[14:12]; // Rounding mode
                instr_type = 2'b11; // Negative Fused Multiply-Subtract (NMSUB) FP instruction
            end

            7'b1010011: begin // FP Arithmetic Instructions
                rd  = instr[11:7];
                rs1 = instr[19:15];
                rs2 = instr[24:20];
                rm  = instr[14:12]; // Rounding mode for arithmetic

                // Decode based on funct7 field for arithmetic and comparison operations
                case (funct7)
                    7'b0000000: instr_type = 2'b11; // FADD.S
                    7'b0000100: instr_type = 2'b11; // FSUB.S
                    7'b0001000: instr_type = 2'b11; // FMUL.S
                    7'b0001100: instr_type = 2'b11; // FDIV.S
                    7'b0101100: instr_type = 2'b11; // FSQRT.S

                    7'b0010000: begin // FSGNJ instructions
                        case (funct3)
                            3'b000: instr_type = 2'b11; // FSGNJ.S
                            3'b001: instr_type = 2'b11; // FSGNJN.S
                            3'b010: instr_type = 2'b11; // FSGNJX.S
                        endcase
                    end

                    7'b0010100: begin // FMIN and FMAX
                        case (funct3)
                            3'b000: instr_type = 2'b11; // FMIN.S
                            3'b001: instr_type = 2'b11; // FMAX.S
                        endcase
                    end

                    7'b1100000: begin // FCVT instructions (conversion between FP and integer types)
                        case (funct3)
                            3'b000: instr_type = 2'b11; // FCVT.W.S (convert float to signed int)
                            3'b001: instr_type = 2'b11; // FCVT.WU.S (convert float to unsigned int)
                        endcase
                    end

                    7'b1110000: begin // FMV and classification instructions
                        case (funct3)
                            3'b000: instr_type = 2'b11; // FMV.X.W (move FP to integer register)
                            3'b001: instr_type = 2'b11; // FMV.W.X (move integer to FP register)
                            3'b010: instr_type = 2'b11; // FCLASS.S (classify FP value)
                        endcase
                    end

                    7'b1010000: begin // Comparison instructions
                        case (funct3)
                            3'b010: instr_type = 2'b11; // FEQ.S (equality comparison)
                            3'b001: instr_type = 2'b11; // FLT.S (less-than comparison)
                            3'b000: instr_type = 2'b11; // FLE.S (less-than or equal comparison)
                        endcase
                    end

                    default: instr_type = 2'b00; // Invalid or unhandled instruction
                endcase
            end

            default: begin
                instr_type = 2'b00; // Invalid instruction
            end
        endcase
    end

endmodule
