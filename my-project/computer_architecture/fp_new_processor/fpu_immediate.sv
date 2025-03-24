module fpu_immediate (
    input logic [11:0] imm,      // 12-bit immediate of instruction
    output logic [31:0] immediate_out   // Sign-extended immediate output
);


    always_comb begin
        if (imm[11]==1) begin
            immediate_out = {20{1'b1}, imm};

        end
        else begin
            immediate_out = {20{1'b0}, imm};
        end
    end
endmodule