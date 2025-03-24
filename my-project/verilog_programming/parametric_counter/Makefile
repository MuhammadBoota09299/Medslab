work:work
	mkdir work
run:parametric_counter.sv parametric_counter_tb.sv
	vlog -work work parametric_counter.sv parametric_counter_tb.sv
	vsim -c -do "run -all;quit" parametric_counter_tb
wave:
	gtkwave parametric_counter.vcd

