# Simple Makefile for ModelSim

# Variables
VLOG = vlog
VSIM = vsim
SIM_FILES = \
  fpnew_pkg.sv\
  fpnew_top.sv\

# Default target
all: compile run

# Compile all Verilog/SystemVerilog files
compile:
	@echo "Compiling Verilog/SystemVerilog files..."
	$(VLOG) -work work $(SIM_FILES)

# Run the simulation
run:
	@echo "Running simulation..."
	$(VSIM) -c -do "run -all; quit" $(TOP_MODULE)

# Clean target to remove compiled files
clean:
	@echo "Cleaning up..."
	rm -rf work
	rm -rf transcript

.PHONY: all compile run clean
