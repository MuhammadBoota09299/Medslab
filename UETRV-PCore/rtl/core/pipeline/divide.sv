// Copyright 2023 University of Engineering and Technology Lahore.
// Licensed under the Apache License, Version 2.0, see LICENSE file for details.
// SPDX-License-Identifier: Apache-2.0
//
// Description: The divide module for M-extension.
//
// Author: Ali Imran, UET Lahore
// Date: 20.5.2023

 
`ifndef VERILATOR
`include "../../defines/m_ext_defs.svh"
`else
`include "m_ext_defs.svh"
`endif

module divide (

    input   logic                        rst_n,                    // reset
    input   logic                        clk,                      // clock

    // EXE <---> M-extension interface
    input  wire type_exe2div_s           exe2div_i,

    input wire                           fwd2div_stall_i,
    input wire                           fwd2div_flush_i,

    // M-extension <---> Forward-stall interface
    output type_div2fwd_s                div2fwd_o,

    output type_div2wrb_s                div2wrb_o
);


//============================= Local signals and their assignments =============================//
// Local control and data signal structures 
type_exe2div_s                       exe2div;
type_div2fwd_s                       div2fwd;
type_div2wrb_s                       div2wrb;

type_alu_d_ops_e                     alu_d_ops, alu_d_ops_next, alu_d_ops_ff;

// ALU_M signals
logic  [`XLEN-1:0]                   alu_opr_1, alu_d_opr_1, alu_d_opr1_next, alu_d_opr1_ff;
logic  [`XLEN-1:0]                   alu_opr_2, alu_d_opr_2, alu_d_opr2_next, alu_d_opr2_ff;
logic                                alu_d_opr1_sign_next, alu_d_opr1_sign_ff;
logic                                alu_d_opr2_sign_next, alu_d_opr2_sign_ff;

logic                                alu_d_req;
logic                                alu_d_ack_next, alu_d_ack_ff;
logic  [`XLEN-1:0]                   alu_d_result_next;

logic  [`XLEN-1:0]                   div;
logic  [`XLEN-1:0]                   div_u;
logic  [`XLEN-1:0]                   rem;
logic  [`XLEN-1:0]                   rem_u;

logic                                div_done;
logic                                div_valid;


assign exe2div = exe2div_i;

assign alu_d_ops = type_alu_d_ops_e'(exe2div.alu_d_ops); 
assign alu_opr_1 = exe2div.alu_operand_1;
assign alu_opr_2 = exe2div.alu_operand_2;

assign alu_d_req = |alu_d_ops_ff;


always_comb begin
    if (alu_d_ops == ALU_D_OPS_DIV || alu_d_ops == ALU_D_OPS_REM) begin 
        alu_d_opr_1 = alu_opr_1[`XLEN-1] ? (~alu_opr_1 + 1) : alu_opr_1;
    end else begin
        alu_d_opr_1 = alu_opr_1;
    end
end


always_comb begin
    if (alu_d_ops == ALU_D_OPS_DIV || alu_d_ops == ALU_D_OPS_REM) begin
        alu_d_opr_2 = alu_opr_2[`XLEN-1] ? (~alu_opr_2+1) : alu_opr_2;
    end else begin
        alu_d_opr_2 = alu_opr_2;
    end
end


always_ff @(negedge rst_n, posedge clk ) begin

    if (~rst_n | fwd2div_flush_i) begin
        alu_d_ops_ff       <= type_alu_d_ops_e'(0);
        alu_d_opr1_ff      <= '0;
        alu_d_opr2_ff      <= '0;
        alu_d_opr1_sign_ff <= '0;
        alu_d_opr2_sign_ff <= '0;
    end else begin
        alu_d_ops_ff       <= alu_d_ops_next; 
        alu_d_opr1_ff      <= alu_d_opr1_next;
        alu_d_opr2_ff      <= alu_d_opr2_next;
        alu_d_opr1_sign_ff <= alu_d_opr1_sign_next;
        alu_d_opr2_sign_ff <= alu_d_opr2_sign_next;
    end 
end

always_comb begin

    if (fwd2div_stall_i) begin
        alu_d_ops_next       = alu_d_ops_ff; 
        alu_d_opr1_next      = alu_d_opr1_ff;
        alu_d_opr2_next      = alu_d_opr2_ff;
        alu_d_opr1_sign_next = alu_d_opr1_sign_ff;
        alu_d_opr2_sign_next = alu_d_opr2_sign_ff;
    end else begin
        alu_d_ops_next       = alu_d_ops;
        alu_d_opr1_next      = alu_d_opr_1;
        alu_d_opr2_next      = alu_d_opr_2;
        alu_d_opr1_sign_next = alu_opr_1[`XLEN-1];
        alu_d_opr2_sign_next = alu_opr_2[`XLEN-1];
    end
end


always_comb begin
    alu_d_result_next = '0;
    alu_d_ack_next    = '0;

    case (alu_d_ops_ff)
       ALU_D_OPS_DIV  : begin
            alu_d_ack_next    = div_done; 
            alu_d_result_next = ((alu_d_opr1_sign_ff ^ alu_d_opr2_sign_ff) && ~div_u[`XLEN-1]) 
                              ? (~div_u+1): div_u;
        end
        ALU_D_OPS_DIVU  : begin
            alu_d_ack_next    = div_done; 
            alu_d_result_next = div_u;
        end
        ALU_D_OPS_REM  : begin
            alu_d_ack_next    = div_done; 
            alu_d_result_next = ((alu_d_opr1_sign_ff && ~alu_d_opr2_sign_ff) || (alu_d_opr1_sign_ff && alu_d_opr2_sign_ff)) 
                              ? (~rem_u+1): rem_u;
        end
        ALU_D_OPS_REMU  : begin
            alu_d_ack_next    = div_done; 
            alu_d_result_next = rem_u;
        end
        default : begin
            alu_d_ack_next    = 1'b0;
            alu_d_result_next = '0;
        end
    endcase
end


always_ff @(negedge rst_n, posedge clk ) begin

    if (~rst_n) begin
        alu_d_ack_ff <= 1'b0;       
    end else begin
        alu_d_ack_ff <= alu_d_ack_next; 
    end
end

// Request from M-extension
assign div2fwd.div_req = alu_d_req; 

// Response from M-extension
assign div2wrb.alu_d_result = alu_d_result_next; 
assign div2fwd.div_ack      = alu_d_ack_ff;

assign div2fwd_o = div2fwd;
assign div2wrb_o = div2wrb;

divider divider_module(                                                        // width of numbers in bits
    .clk                (clk),                                                 // clock
    .rst                (rst_n),                                               // reset
    .start_i            (alu_d_ops_ff[2] & ~(alu_d_ack_next | alu_d_ack_ff)),  // start calculation
    .opr1_i             (alu_d_opr1_ff),                                       // dividend (numerator)
    .opr2_i             (alu_d_opr2_ff),                                       // divisor (denominator) 
    .done_o             (div_done),                                            // calculation is complete (high for one tick)
    .quo_o              (div_u),                                               // result value: quotient
    .rem_o              (rem_u)                                                // result: remainder
);

endmodule
