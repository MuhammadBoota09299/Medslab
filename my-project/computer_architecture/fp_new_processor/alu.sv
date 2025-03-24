module alu (
    input logic [31:0]int_apu_operands_i_1,int_apu_operands_i_2,
    input logic operantion,
    output logic result
);
    always_comb begin
        case (operantion)
           1'b1 :result= int_apu_operands_i_1+int_apu_operands_i_2 
            default: result=32'b0;
        endcase
    end
endmodule