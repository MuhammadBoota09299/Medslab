# Simple Makefile for ModelSim

# Variables
VLOG = vlog
VSIM = vsim
SIM_FILES = \
  common_cells \
  fpu_div_sqrt_mvp \
  work \
  fp_test_bench.sv \
  fp_wrapper.sv \
  fpnew_cast_multi.sv \
  fpnew_classifier.sv \
  fpnew_divsqrt_multi.sv \
  fpnew_divsqrt_th_32.sv \
  fpnew_divsqrt_th_64_multi.sv \
  fpnew_fma.sv \
  fpnew_fma_multi.sv \
  fpnew_noncomp.sv \
  fpnew_opgroup_block.sv \
  fpnew_opgroup_fmt_slice.sv \
  fpnew_opgroup_multifmt_slice.sv \
  fpnew_pkg.sv \
  fpnew_rounding.sv \
  fpnew_top.sv
TOP_MODULE = fp_test_bench

# Default target
all: compile run

# Compile all Verilog/SystemVerilog files
compile:
	@echo "Compiling Verilog/SystemVerilog files..."
	$(VLOG) -sv $(SIM_FILES)

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
