module rv32f_decoder
    (
    input  logic [31:0] instr,                // 32-bit instruction input
    output logic [2:0] fp_rnd_mode,           // Rounding mode
    output logic [11:0] imm,                  // Immediate field
    output logic rs1_sel,imm_sel,rs2_sel,     // rs1 and rs2 are integer or float,immediate sel
    output logic [4:0] apu_op_i,              // Combined operation and modifier
    output logic fpu_enable,                  // Floating-point unit enable
    output logic data_mem_enable,             // Data memory enable
    output logic register_file_float_enable,  // Register file of floating-point enable
    output logic register_file_int_enable,     // Register file of integer enable
    output logic alu_add,                       // for adding immediate and rs1
    output logic write_back_sel                 // select data from register file or memory
);

    // Enumerations for opcodes
    typedef enum logic [6:0] {
        FLW     = 7'b0000111,   // Load Floating-Point Word
        FSW     = 7'b0100111,   // Store Floating-Point Word
        FMADD   = 7'b1000011,   // Fused Multiply-Add
        FMSUB   = 7'b1000111,   // Fused Multiply-Subtract
        FNMSUB  = 7'b1001011,   // Negated Fused Multiply-Subtract
        FNMADD  = 7'b1001111,   // Negated Fused Multiply-Add
        FP_ARITH= 7'b1010011    // Floating-Point Arithmetic Instructions
    } fpu_opcodes_e;

    // Enumerations for FP operations
    typedef enum logic [3:0] {
        FMADD       = 4'b0000,  // Fused Multiply-Add/Subtract
        FNMSUB      = 4'b0001,  // Negated Fused Multiply-Subtract/Add
        ADD         = 4'b0010,  // Addition or Subtraction
        MUL         = 4'b0011,  // Multiplication
        DIV         = 4'b0100,  // Division
        SQRT        = 4'b0101,  // Square Root
        SGNJ        = 4'b0110,  // Sign Injection
        MINMAX      = 4'b0111,  // Minimum/Maximum
        CMP         = 4'b1000,  // Comparison
        CLASSIFY    = 4'b1001,  // Classification
        F2F         = 4'b1010,  // FP to FP cast
        F2I         = 4'b1011,  // FP to Integer cast
        I2F         = 4'b1100,  // Integer to FP cast
        CPK         = 4'b1101   // Cast and Pack
    } fp_operations_e;

    // Internal signals
    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [3:0] fp_op;
    logic op_mod_i;
    // Decode instruction fields
    always_comb begin
        // Extract opcode and fields
        opcode = instr[6:0];
        funct3 = instr[14:12];
        funct7 = instr[31:25];
        // Default values
        fp_rnd_mode              = funct3;
        fp_op                    = 4'b0000;
        op_mod_i                 = 1'b0;
        imm                      = 12'b0;
        data_mem_enable          = 1'b0;
        register_file_float_enable = 1'b0;
        register_file_int_enable = 1'b0;
        fpu_enable               = 1'b0;
        rs2_sel                  = 1'b0; //default to integer
        rs1_sel                  = 1'b0; // Default to float 
        alu_add                  = 1'b0;
        imm_sel                  = 1'b0; //immediate select instand of rs2 in alu
        write_back_sel           =1'b0;  // data from registerfile
        case (opcode)
            FLW: begin // Load Floating-Point Word
                imm = instr[31:20];
                register_file_float_enable = 1'b1;
                alu_add =1'b1; //add
                imm_sel =1'b1; 
                write_back_sel =1'b1;//data from memory
            end
            FSW: begin // Store Floating-Point Word
                imm = {instr[31:25], instr[11:7]};
                data_mem_enable = 1'b1;
                rs2_sel = 1'b1; // store float number
                imm_sel =1'b1; 
                alu_add =1'b1; //add
            end
            FMADD: begin // Fused Multiply-Add/Subtract
                fp_op       = FMADD;
                op_mod_i    = 1'b0; // Modifier (bit 27)
                // fp_rnd_mode = funct3;
                fpu_enable  = 1'b1;
                //rs1_sel = 1'b0; // rs1 is float
                register_file_float_enable = 1'b1;
            end
            FMSUB:begin
                fp_op       = FMADD;
                op_mod_i    = 1'b1; // Modifier (bit 27)
               // fp_rnd_mode = funct3;
                fpu_enable  = 1'b1;
                //rs1_sel = 1'b0; // rs1 is float
                register_file_float_enable = 1'b1;
            end 
            FNMSUB:begin
                fp_op       = FNMSUB;
                op_mod_i    = 1'b1; // Modifier (bit 27)
                //fp_rnd_mode = funct3;
                fpu_enable  = 1'b1;
               // rs1_sel = 1'b0; // rs1 is float
                register_file_float_enable = 1'b1;
            end 
            FNMADD: begin // Negated Fused Multiply-Add/Subtract
                fp_op       = FNMSUB;
                op_mod_i    = 1'b0; // Modifier (bit 27)
                //fp_rnd_mode = funct3;
                fpu_enable  = 1'b1;
                //rs1_sel = 1'b1; // rs1 is float
                register_file_float_enable = 1'b1;
            end
            FP_ARITH: begin // Floating-Point Arithmetic Instructions
                fpu_enable = 1'b1;
                //fp_rnd_mode = funct3;
                case (funct7)
                    7'b0000000: begin
                        fp_op    = ADD; // ADD or SUB based on op_mod_i
                        op_mod_i = 1'b0; // add
                       // rs1_sel = 1'b0; // rs1 is float
                        register_file_float_enable = 1'b1;
                    end
                    7'b0000100: begin
                        fp_op    = ADD; // ADD or SUB based on op_mod_i
                        op_mod_i = 1'b1; // sub
                       // rs1_sel = 1'b0; // rs1 is float
                        register_file_float_enable = 1'b1;
                    end
                    7'b0001000:begin
                       //rs1_sel = 1'b0; // rs1 is float
                        fp_op = MUL;   // Multiplication
                        op_mod_i = 1'b0;
                        register_file_float_enable = 1'b1;
                    end
                 // 7'b0001100: fp_op = DIV;           // Division
                 // 7'b0101100: fp_op = SQRT;          // Square root
                    7'b0010000:begin
                        fp_op = SGNJ;  // Sign injection
                        op_mod_i=1'b0;
                        register_file_float_enable = 1'b1;
                       // rs1_sel = 1'b0; // rs1 is float
                    end          
                    7'b0010100:begin
                        fp_op = MINMAX; // Minimum/Maximum
                        op_mod_i=1'b0;
                        rs1_sel = 1'b0; // rs1 is float
                        register_file_float_enable = 1'b1;
                    end         
                    7'b1010000:begin
                        fp_op = CMP;           // Comparison
                        op_mod_i=1'b0;
                        register_file_int_enable = 1'b1;
                        rs1_sel = 1'b0; // rs1 is float
                    end
                    7'b1110000: fp_op = CLASSIFY;      // Classification
                    7'b1100000:begin
                        fp_op = F2I;   // FP to Integer cast
                        register_file_int_enable = 1'b1;
                        rs1_sel = 1'b0; // rs1 is float
                        case (rs2)
                            5'h0: op_mod_i=1'b0; // FP to signed integer cast
                            5'h1: op_mod_i=1'b1; // FP to unsigned integer cast
                            default: op_mod_i=1'b0; // FP to signed integer cast
                        endcase
                    end
                    7'b1101000:begin 
                        fp_op = I2F;   // Integer to FP cast
                        rs1_sel = 1'b1; // rs1  is integer
                        register_file_float_enable = 1'b1;
                        op_mod_i = rs2;
                    end
                    7'b1111000:begin 
                        register_file_int_enable = 1'b1;
                        fp_rnd_mode=RUP; //  op[0] (passthrough)
                        rs1_sel = 1'b0; // rs1 is float          
                        case (funct3)
                          3'b001:fp_op = CLASSIFY; // Classification, returns RISC-V classification block
                          3'b000:fp_op = SGNJ; // FMV.X.W = move floating-point register to integer register:  rd = rs1
                            default: fp_op = SGNJ;
                        endcase

                    end
                    7'b1111000:begin
                        fp_op=SGNJ;// FMV.W.X = Move integer to floating-point register: rd = rs1
                        fp_rnd_mode=RUP; //  op[0] (passthrough)
                        rs1_sel = 1'b0;  // rs1  is integer
                        register_file_float_enable = 1'b1;
                    end
                        default:fp_op = 4'b0000;      // Default NOP
                endcase
            end
            default: begin
                fpu_enable                = 1'b0;
                data_mem_enable           = 1'b0;
                register_file_float_enable = 1'b0;
                register_file_int_enable  = 1'b0;
                rs1_sel                   = 1'b0; // Default to integer operations
                alu_add                   = 1'b0;
            end
        endcase
    end

    // Combine operation and modifier
    assign apu_op_i = {op_mod_i, fp_op};

endmodule
