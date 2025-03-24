module single_cycle_processor (
    input clock,reset
);
logic [31:0]pc_next,mechine_code,distination_data,data_1,data_2,immediate,mux2_1_out;
logic write_enable,mux2_1_enable;
logic [3:0]operations;
pc uut1(.clock(clock),.reset(reset),.pc_next(pc_next));
instruction_memory uut2(.mem_adress(pc_next),.mechine_code(mechine_code));
registerfile uut3(.write_enable(write_enable),.rs1(mechine_code[19:15]),.rs2(mechine_code[24:20]),.rd(mechine_code[11:7]),.distination_data(distination_data),.data_1(data_1),.data_2(data_2),.clock(clock),.reset(reset));
controller uut4(.instructions(mechine_code),.write_enable(write_enable),.operations(operations),.mux2_1_enable(mux2_1_enable));
alu uut5(.a(mux2_1_out),.b(data_2),.distination_data(distination_data),.operations(operations));
mux2_1 uut6(.mux2_1_enable(mux2_1_enable),.mux2_1_x1(data_1),.mux2_1_y(mux2_1_out),.mux2_1_x2(immediate));
immediate uut7(.immediate_in(mechine_code[31:20]),.immediate_out(immediate));
endmodule