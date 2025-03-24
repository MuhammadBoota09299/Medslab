module registerfile (
    input logic [4:0]rs1,rs2,rd,logic [31:0]distination_data,logic write_enable,clock,reset,
    output logic [31:0]data_1,data_2
);
logic [31:0]register_file[31:0];
    always_ff @( negedge clock ) begin 
        if (reset) begin
          register_file[31:0]<='{default:0}; 
          register_file[1]<=32'h4;
          register_file[2]<=32'h6; 
        end
        else if (write_enable) begin
            register_file[rd]<=distination_data;
        end
    end
    always_comb begin  
        data_1=register_file[rs1];
        data_2=register_file[rs2];
    end
endmodule