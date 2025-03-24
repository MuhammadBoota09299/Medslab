module fp_test_bench;

  // Declare signals
  reg clk;
  reg rst_n;
  reg apu_req_i;
  wire apu_gnt_o;
  reg [31:0] apu_operands_i;
  reg [4:0] apu_op_i;  // Adjust the width as needed
  reg [9:0] apu_flags_i; // Adjust the width as needed
  wire apu_rvalid_o;
  wire [31:0] apu_rdata_o;
  wire [3:0] apu_rflags_o; // Adjust the width as needed

  // Instantiate the floating-point wrapper
  fp_wrapper uut (
      .clk_i(clk),
      .rst_ni(rst_n),
      .apu_req_i(apu_req_i),
      .apu_gnt_o(apu_gnt_o),
      .apu_operands_i(apu_operands_i),
      .apu_op_i(apu_op_i),
      .apu_flags_i(apu_flags_i),
      .apu_rvalid_o(apu_rvalid_o),
      .apu_rdata_o(apu_rdata_o),
      .apu_rflags_o(apu_rflags_o)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 ns clock period
  end

  // Reset and stimulus generation
  initial begin
    // Initialize signals
    rst_n = 0;
    apu_req_i = 0;
    apu_operands_i = 32'h0;
    apu_op_i = 5'b00000; // Example operation code
    apu_flags_i = 10'b0000000000; // Example flags

    // Apply reset
    #10;
    rst_n = 1;

    // Apply test cases
    #10;
    test_fld_instruction();
    #20;
    test_fsd_instruction();
    #20;
    test_fadd_instruction();
    #20;
    test_fsub_instruction();
    #20;
    test_fmul_instruction();
    #20;
    test_fdiv_instruction();
    #20;
    test_fsqrt_instruction();
    #20;
    test_fma_instruction();
    #20;
    test_fms_instruction();
    #20;
    test_fcvt_w_s_instruction();
    #20;
    test_fmv_x_w_instruction();
    #20;
    test_fmin_instruction();
    #20;
    test_fmax_instruction();
    #20;
    test_fclass_instruction();
    #20;

    // Finish simulation
    #100;
    $finish;
  end

  // Task to test FLD instruction
  task test_fld_instruction;
    begin
      apu_req_i = 1;
      apu_operands_i = 32'h80000008; // Address
      apu_op_i = 5'b00001; // FLD operation code
      apu_flags_i = 10'b0000001001; // Flags for double-precision

      // Wait for the operation to complete
      #10;
      apu_req_i = 0;

      // Check results
      if (apu_rvalid_o) begin
        $display("FLD Result valid. Data: %h", apu_rdata_o);
        $display("Status flags: %b", apu_rflags_o);
      end else begin
        $display("FLD Result not valid yet.");
      end
    end
  endtask

  // Task to test FSD instruction
  task test_fsd_instruction;
    begin
      apu_req_i = 1;
      apu_operands_i = 32'h80000008; // Address
      apu_op_i = 5'b00010; // FSD operation code
      apu_flags_i = 10'b0000001001; // Flags for double-precision

      // Wait for the operation to complete
      #10;
      apu_req_i = 0;

      // Check results
      if (apu_rvalid_o) begin
        $display("FSD Result valid. Data: %h", apu_rdata_o);
        $display("Status flags: %b", apu_rflags_o);
      end else begin
        $display("FSD Result not valid yet.");
      end
    end
  endtask

  // Task to test FADD instruction
  task test_fadd_instruction;
    begin
      apu_req_i = 1;
      apu_operands_i = {32'h3f800000, 32'h40000000}; // Example operands
      apu_op_i = 5'b00100; // FADD operation code
      apu_flags_i = 10'b0000000001; // Flags for single-precision

      // Wait for the operation to complete
      #10;
      apu_req_i = 0;

      // Check results
      if (apu_rvalid_o) begin
        $display("FADD Result valid. Data: %h", apu_rdata_o);
        $display("Status flags: %b", apu_rflags_o);
      end else begin
        $display("FADD Result not valid yet.");
      end
    end
  endtask

  // Task to test FSUB instruction
  task test_fsub_instruction;
    begin
      apu_req_i = 1;
      apu_operands_i = {32'h3f800000, 32'h40000000}; // Example operands
      apu_op_i = 5'b00101; // FSUB operation code
      apu_flags_i = 10'b0000000001; // Flags for single-precision

      // Wait for the operation to complete
      #10;
      apu_req_i = 0;

      // Check results
      if (apu_rvalid_o) begin
        $display("FSUB Result valid. Data: %h", apu_rdata_o);
        $display("Status flags: %b", apu_rflags_o);
      end else begin
        $display("FSUB Result not valid yet.");
      end
    end
  endtask

  // Task to test FMUL instruction
  task test_fmul_instruction;
    begin
      apu_req_i = 1;
      apu_operands_i = {32'h3f800000, 32'h40000000}; // Example operands
      apu_op_i = 5'b00110; // FMUL operation code
      apu_flags_i = 10'b0000000001; // Flags for single-precision

      // Wait for the operation to complete
      #10;
      apu_req_i = 0;

      // Check results
      if (apu_rvalid_o) begin
        $display("FMUL Result valid. Data: %h", apu_rdata_o);
        $display("Status flags: %b", apu_rflags_o);
      end else begin
        $display("FMUL Result not valid yet.");
      end
    end
  endtask

  // Task to test FDIV instruction
  task test_fdiv_instruction;
    begin
      apu_req_i = 1;
      apu_operands_i = {32'h3f800000, 32'h40000000}; // Example operands
      apu_op_i = 5'b00111; // FDIV operation code
      apu_flags_i = 10'b0000000001; // Flags for single-precision

      // Wait for the operation to complete
      #10;
      apu_req_i = 0;

      // Check results
      if (apu_rvalid_o) begin
        $display("FDIV Result valid. Data: %h", apu_rdata_o);
        $display("Status flags: %b", apu_rflags_o);
      end else begin
        $display("FDIV Result not valid yet.");
      end
    end
  endtask

  // Task to test FSQRT instruction
  task test_fsqrt_instruction;
    begin
      apu_req_i = 1;
      apu_operands_i = 32'h40000000; // Example operand
      apu_op_i = 5'b01000; // FSQRT operation code
      apu_flags_i = 10'b0000000001; // Flags for single-precision

      // Wait for the operation to complete
      #10;
      apu_req_i = 0;

      // Check results
      if (apu_rvalid_o) begin
        $display("FSQRT Result valid. Data: %h", apu_rdata_o);
        $display("Status flags: %b", apu_rflags_o);
      end else begin
        $display("FSQRT Result not valid yet.");
      end
    end
  endtask

  // Task to test FMA instruction
  task test_fma_instruction;
    begin
      apu_req_i = 1;
      apu_operands_i = {32'h3f800000, 32'h40000000, 32'h3f800000}; // Example operands
      apu_op_i = 5'b01001; // FMA operation code
      apu_flags_i = 10'b0000000001; // Flags for single-precision

      // Wait for the operation to complete
      #10;
      apu_req_i = 0;

      // Check results
      if (apu_rvalid_o) begin
        $display("FMA Result valid. Data: %h", apu_rdata_o);
        $display("Status flags: %b", apu_rflags_o);
      end else begin
        $display("FMA Result not valid yet.");
      end
    end
  endtask

  // Task to test FMS instruction
  task test_fms_instruction;
    begin
      apu_req_i = 1;
      apu_operands_i = {32'h3f800000, 32'h40000000, 32'h3f800000}; // Example operands
      apu_op_i = 5'b01010; // FMS operation code
      apu_flags_i = 10'b0000000001; // Flags for single-precision

      // Wait for the operation to complete
      #10;
      apu_req_i = 0;

      // Check results
      if (apu_rvalid_o) begin
        $display("FMS Result valid. Data: %h", apu_rdata_o);
        $display("Status flags: %b", apu_rflags_o);
      end else begin
        $display("FMS Result not valid yet.");
      end
    end
  endtask

  // Task to test FCVT.W.S instruction
  task test_fcvt_w_s_instruction;
    begin
      apu_req_i = 1;
      apu_operands_i = 32'h3f800000; // Example single-precision float
      apu_op_i = 5'b01011; // FCVT.W.S operation code
      apu_flags_i = 10'b0000000001; // Flags for single-precision

      // Wait for the operation to complete
      #10;
      apu_req_i = 0;

      // Check results
      if (apu_rvalid_o) begin
        $display("FCVT.W.S Result valid. Data: %h", apu_rdata_o);
        $display("Status flags: %b", apu_rflags_o);
      end else begin
        $display("FCVT.W.S Result not valid yet.");
      end
    end
  endtask

  // Task to test FMV.X.W instruction
  task test_fmv_x_w_instruction;
    begin
      apu_req_i = 1;
      apu_operands_i = 32'h3f800000; // Example single-precision float
      apu_op_i = 5'b01100; // FMV.X.W operation code
      apu_flags_i = 10'b0000000001; // Flags for single-precision

      // Wait for the operation to complete
      #10;
      apu_req_i = 0;

      // Check results
      if (apu_rvalid_o) begin
        $display("FMV.X.W Result valid. Data: %h", apu_rdata_o);
        $display("Status flags: %b", apu_rflags_o);
      end else begin
        $display("FMV.X.W Result not valid yet.");
      end
    end
  endtask

  // Task to test FMIN instruction
  task test_fmin_instruction;
    begin
      apu_req_i = 1;
      apu_operands_i = {32'h3f800000, 32'h40000000}; // Example operands
      apu_op_i = 5'b01101; // FMIN operation code
      apu_flags_i = 10'b0000000001; // Flags for single-precision

      // Wait for the operation to complete
      #10;
      apu_req_i = 0;

      // Check results
      if (apu_rvalid_o) begin
        $display("FMIN Result valid. Data: %h", apu_rdata_o);
        $display("Status flags: %b", apu_rflags_o);
      end else begin
        $display("FMIN Result not valid yet.");
      end
    end
  endtask

  // Task to test FMAX instruction
  task test_fmax_instruction;
    begin
      apu_req_i = 1;
      apu_operands_i = {32'h3f800000, 32'h40000000}; // Example operands
      apu_op_i = 5'b01110; // FMAX operation code
      apu_flags_i = 10'b0000000001; // Flags for single-precision

      // Wait for the operation to complete
      #10;
      apu_req_i = 0;

      // Check results
      if (apu_rvalid_o) begin
        $display("FMAX Result valid. Data: %h", apu_rdata_o);
        $display("Status flags: %b", apu_rflags_o);
      end else begin
        $display("FMAX Result not valid yet.");
      end
    end
  endtask

  // Task to test FCLASS instruction
  task test_fclass_instruction;
    begin
      apu_req_i = 1;
      apu_operands_i = 32'h3f800000; // Example single-precision float
      apu_op_i = 5'b01111; // FCLASS operation code
      apu_flags_i = 10'b0000000001; // Flags for single-precision

      // Wait for the operation to complete
      #10;
      apu_req_i = 0;

      // Check results
      if (apu_rvalid_o) begin
        $display("FCLASS Result valid. Data: %h", apu_rdata_o);
        $display("Status flags: %b", apu_rflags_o);
      end else begin
        $display("FCLASS Result not valid yet.");
      end
    end
  endtask
  initial begin
    $dumpfile("fp_test_bench.vcd");
    $dumpvars(0,tb_fp_wrapper);
  end

endmodule
