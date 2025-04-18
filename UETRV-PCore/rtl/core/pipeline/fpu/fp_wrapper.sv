module fp_wrapper
#(
    parameter FPU_ADDMUL_LAT = 0, // Floating-Point ADDition/MULtiplication computing lane pipeline registers number
    parameter FPU_OTHERS_LAT = 0, // Floating-Point COMParison/CONVersion computing lanes pipeline registers number
    parameter APU_NARGS_CPU = 3,  // Number of operands
    parameter APU_WOP_CPU = 5,    // Width of operation
    parameter APU_NDSFLAGS_CPU = 10, // Number of DSFLAGS
    parameter APU_NUSFLAGS_CPU = 3, // Number of USFLAGS
    parameter C_RM = 3,           // Rounding mode width
    parameter C_FLEN = 32,        // Floating-point length
    parameter C_XFVEC = 0,        // Enable Vectors
    parameter C_RVF = 1,          // Enable FP32
    parameter C_RVD = 0,          // Disable FP64
    parameter C_XF16 = 0,         // Disable FP16
    parameter C_XF8 = 0,          // Disable FP8
    parameter C_XF16ALT = 0,      // Disable FP16ALT
    parameter C_LAT_FP64 = 0,     // Latency for FP64
    parameter C_LAT_FP16 = 0,     // Latency for FP16
    parameter C_LAT_FP8 = 0,      // Latency for FP8
    parameter C_LAT_FP16ALT = 0,  // Latency for FP16ALT
    parameter C_LAT_DIVSQRT = 0   // Latency for DIVSQRT
) (
    // Clock and Reset
    input logic clk_i,
    input logic rst_ni,

    // APU Side: Master port
    input  logic apu_req_i,
    output logic apu_gnt_o,

    // request channel
    input logic [APU_NARGS_CPU-1:0][31:0] apu_operands_i,
    input logic [APU_WOP_CPU-1:0]         apu_op_i,
    input logic [APU_NDSFLAGS_CPU-1:0]    apu_flags_i,

    // response channel
    output logic                          apu_rvalid_o,
    output logic [31:0]                   apu_rdata_o,
    output logic [APU_NUSFLAGS_CPU-1:0]   apu_rflags_o
);

  import fpnew_pkg::*;

  logic [fpnew_pkg::OP_BITS-1:0] fpu_op;
  logic                          fpu_op_mod;
  logic                          fpu_vec_op;

  logic [fpnew_pkg::FP_FORMAT_BITS-1:0] fpu_dst_fmt;
  logic [fpnew_pkg::FP_FORMAT_BITS-1:0] fpu_src_fmt;
  logic [fpnew_pkg::INT_FORMAT_BITS-1:0] fpu_int_fmt;
  logic [C_RM-1:0] fp_rnd_mode;

  assign {fpu_vec_op, fpu_op_mod, fpu_op} = apu_op_i;
  assign {fpu_int_fmt, fpu_src_fmt, fpu_dst_fmt, fp_rnd_mode} = apu_flags_i;

  // -----------
  // FPU Config
  // -----------
  // Features (enabled formats, vectors etc.)
  localparam fpnew_pkg::fpu_features_t FPU_FEATURES = '{
      Width: C_FLEN,
      EnableVectors: C_XFVEC,
      EnableNanBox: 1'b0,
      FpFmtMask: {
          C_RVF, C_RVD, C_XF16, C_XF8, C_XF16ALT
      },
      IntFmtMask: {
          C_XFVEC && C_XF8, C_XFVEC && (C_XF16 || C_XF16ALT), 1'b1, 1'b0
      }
  };

  // Implementation (number of registers etc)
  localparam fpnew_pkg::fpu_implementation_t FPU_IMPLEMENTATION = '{
      PipeRegs: '{  // FP32, FP64, FP16, FP8, FP16alt
          '{
              FPU_ADDMUL_LAT, C_LAT_FP64, C_LAT_FP16, C_LAT_FP8, C_LAT_FP16ALT
          },  // ADDMUL
          '{default: C_LAT_DIVSQRT},  // DIVSQRT
          '{default: FPU_OTHERS_LAT},  // NONCOMP
          '{default: FPU_OTHERS_LAT}
      },  // CONV
      UnitTypes: '{
          '{default: fpnew_pkg::MERGED},  // ADDMUL
          '{default: fpnew_pkg::MERGED},  // DIVSQRT
          '{default: fpnew_pkg::PARALLEL},  // NONCOMP
          '{default: fpnew_pkg::MERGED}
      },
      PipeConfig: fpnew_pkg::AFTER
  };

  //---------------
  // FPU instance
  //---------------

  fpnew_top #(
      .Features      (FPU_FEATURES),
      .Implementation(FPU_IMPLEMENTATION),
      .PulpDivsqrt   (1'b0),
      .TagType       (logic)
  ) i_fpnew_bulk (
      .clk_i         (clk_i),
      .rst_ni        (rst_ni),
      .operands_i    (apu_operands_i),
      .rnd_mode_i    (fpnew_pkg::roundmode_e'(fp_rnd_mode)),
      .op_i          (fpnew_pkg::operation_e'(fpu_op)),
      .op_mod_i      (fpu_op_mod),
      .src_fmt_i     (fpnew_pkg::fp_format_e'(fpu_src_fmt)),
      .dst_fmt_i     (fpnew_pkg::fp_format_e'(fpu_dst_fmt)),
      .int_fmt_i     (fpnew_pkg::int_format_e'(fpu_int_fmt)),
      .vectorial_op_i(fpu_vec_op),
      .tag_i         (1'b0),
      .simd_mask_i   (1'b0),
      .in_valid_i    (apu_req_i),
      .in_ready_o    (apu_gnt_o),
      .flush_i       (1'b0),
      .result_o      (apu_rdata_o),
      .status_o      (apu_rflags_o),
      .tag_o         (  /* unused */),
      .out_valid_o   (apu_rvalid_o),
      .out_ready_i   (1'b1),
      .busy_o        (  /* unused */)
  );

endmodule  // cv32e40p_fp_wrapper
