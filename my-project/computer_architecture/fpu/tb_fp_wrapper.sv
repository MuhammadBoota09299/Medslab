`timescale 1ns / 1ps

module tb_fp_wrapper;

  // Parameters
  parameter FPU_ADDMUL_LAT = 0;
  parameter FPU_OTHERS_LAT = 0;

  // Clock and Reset signals
  reg clk_i;
  reg rst_ni;

  // APU Side: Master port signals
  reg  apu_req_i;
  wire apu_gnt_o;

  // request channel signals
  reg  [2:0] [31:0] apu_operands_i;  // Only three operands
  reg  [5:0]  apu_op_i;
  reg  [2:0]  fp_rnd_mode;

  // response channel signals
  wire apu_rvalid_o;
  wire [31:0] apu_rdata_o;
  wire [4:0]  apu_rflags_o;

  // Instantiate the Unit Under Test (UUT)
  cv32e40p_fp_wrapper #(
      .FPU_ADDMUL_LAT(FPU_ADDMUL_LAT),
      .FPU_OTHERS_LAT(FPU_OTHERS_LAT)
  ) uut (
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .apu_req_i(apu_req_i),
      .apu_gnt_o(apu_gnt_o),
      .apu_operands_i(apu_operands_i),
      .apu_op_i(apu_op_i),
      .apu_flags_i({2'b10, 3'b0, 3'b0, fp_rnd_mode}),
      .apu_rvalid_o(apu_rvalid_o),
      .apu_rdata_o(apu_rdata_o),
      .apu_rflags_o(apu_rflags_o)
  );

  // Clock generation
  initial begin
    clk_i = 0;
    forever #1 clk_i = ~clk_i;  // 100 MHz clock
  end

  // Reset generation
  initial begin
    rst_ni = 1;
    #5;
    rst_ni = 0;
  end

  // Test procedure
  initial begin
    // Initialize inputs
    apu_req_i = 0;
    apu_op_i = 6'b000010;
    fp_rnd_mode = 3'b000;
    apu_operands_i[0] = 32'h00000000;
    apu_operands_i[1] = 32'h00000000;
    apu_operands_i[2] = 32'h00000000;

    // Wait for reset de-assertion
    @(negedge rst_ni);

    // Apply a first test case
    apu_req_i = 1;
    apu_op_i = 6'b001100;  // Example operation code
    fp_rnd_mode= 3'b011; // Example flag settings
    apu_operands_i[0] = 32'h10; 
    apu_operands_i[1] = 32'h00000; 
    apu_operands_i[2] = 32'h00000; 

    // Wait for a grant
    @(posedge clk_i);


    // Check result (expected result will depend on the operation performed)
      $display("output 0x%h", apu_rdata_o);
  

    // Add more test cases here...

    // Finish simulation
    #10;
    $stop;
  end
initial begin
  $dumpfile("tb_fp_wrapper.vcd");
  $dumpvars(0,tb_fp_wrapper);
end
endmodule
