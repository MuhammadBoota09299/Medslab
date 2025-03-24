fpu_processor(input logic clock,reset);
logic register_file_int_enable,register_file_float_enable,rs1_imm,fpu_enable,data_mem_float_enable,data_mem_int_enable,register_file_float_enable,register_file_int_enable,fpu_clock,alu_add;
logic [31:0]pc_next,machine_code,int_rd_data,float_rd_data,apu_operands_i_1,apu_operands_i_2,apu_operands_i_3,int_apu_operands_i_1,int_apu_operands_i_2,result;
logic [2:0]fp_rnd_mode;
logic [4:0]apu_op_i;
logic [11:0]imm
//programe counter
pc clock(.clock,.reset,.pc_next);
//instruction memory
fpu_instruction_memory instruction_memory(.clock,.reset,.mem_address(pc_next),.machine_code);
//registerfiles
fpu_registerfile fpu_registerfile(.rs1(mechine_code[15:19]), .rs2(mechine_code[20:24]), .rs3(mechine_code[27:31]), .rd(mechine_code[7:11]), .rd_data, .register_file_enable(registerfile_float_enable), .clock, .reset, .fpu_operands_i_1, .apu_operands_i_2, .apu_operands_i_3);
int_registerfile int_registerfile(.rs1(mechine_code[15:19]), .rs2(mechine_code[20:24]), .rd(mechine_code[7:11]), .rd_data, .register_file_enable(registerfile_int_enable), .clock, .reset, .int_operands_i_1, .int_operands_i_2);
// decoder
rv32f_decoder decoder(.instr(instruction),.fp_rnd_mode,.imm,.rs1_imm,.apu_op_i,.fpu_enable,.data_mem_float_enable,.data_mem_int_enable,.register_file_float_enable,.register_file_int_enable,.alu_add);
//memory write data mux

//immediate 

//fpu register rs1 selection mux

//immediate selection mux

//fpu alu

//alu


alu alu( .int_apu_operands_i_1(int_apu_operands_i_1),.int_apu_operands_i_2(int_apu_operands_i_2),.operantion(alu_add),.result)
fpu_alu fpu( .clk_i(fpu_clock),.rst_ni(reset),.apu_req_i(fpu_enable),.apu_gnt_o(/*unused*/),.apu_operands_i_1,.apu_operands_i_2,.apu_operands_i_3,.apu_op_i,.fp_rnd_mode,.apu_rvalid_o(/*unsed*/),.apu_rdata_o,.apu_rflags_o(/*unused*/));



