work:work
	mkdir work
run:
	vlog -work work fifo_queue.sv fifo_queue_tb.sv	
	vsim -c -do "run -all;quit" fifo_queue_tb
wave:
	gtkwave fifo_queue.vcd
clean:
	rm fif_queue.vcd
	rm -r work
