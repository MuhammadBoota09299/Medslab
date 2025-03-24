module int_registerfile (
    input logic [4:0]rs1,rs2,rd,logic [31:0]rd_data,logic register_file_enable,clock,reset,
    output logic [31:0]apu_operands_i_1,apu_operands_i_2
);
logic [31:0]register_file[31:0];
    always_ff @( negedge clock ) begin
        if (reset) begin
          register_file[31:0]<='{default:0};
          register_file[1] <= 32'h00000004;
          register_file[2] <= 32'h00000007;
        end
        else if (register_file_enable & rd !=5'b0) begin
            register_file[rd]<=rd_data;
        end
    end
    always_comb begin
        apu_operands_i_1=register_file[rs1];
        apu_operands_i_2=register_file[rs2];

    end
endmodule