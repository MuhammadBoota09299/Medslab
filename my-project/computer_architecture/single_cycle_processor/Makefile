run: alu.sv  controller.sv   instruction_memory.sv  pc.sv registerfile.sv  single_cycle_processor.sv  single_cycle_processor_tb.sv   mux2_1.sv   immediate.sv
	vlog -work work alu.sv  controller.sv   instruction_memory.sv  pc.sv registerfile.sv  single_cycle_processor.sv  single_cycle_processor_tb.sv mux2_1.sv  immediate.sv 
	vsim -c -do "run -all; quit" single_cycle_processor_tb
	
