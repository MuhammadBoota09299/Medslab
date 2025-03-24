module instruction_memory ( 
    input logic [31:0]mem_adress,
    output logic [31:0] mechine_code
);
    logic [31:0]instruction_memory_reg [31:0]='{default:0};
    always_ff @( clock ) begin : blockName
    if (mem_adress=|32'b0){
        mechine_code=instruction_memory_reg[mem_adress[31:2]];
    }
    end
    initial begin
        instruction_memory_reg[4'd1]=32'h002081B3;
        instruction_memory_reg[4'd2]=32'h40308233;
        instruction_memory_reg[4'd3]=32'h0041F2B3;
        instruction_memory_reg[4'd4]=32'h0042E333;
        instruction_memory_reg[4'd5]=32'h005323B3;
        instruction_memory_reg[4'd6]=32'h00610193;
        instruction_memory_reg[4'd7]=32'h0023A413;
        instruction_memory_reg[4'd8]=32'h00343493;
        instruction_memory_reg[4'd9]=32'h0044C513;
        instruction_memory_reg[4'd10]=32'h0;
        instruction_memory_reg[4'd11]=32'h0;
        instruction_memory_reg[4'd12]=32'h0;
        instruction_memory_reg[4'd12]=32'h0;
        instruction_memory_reg[4'd12]=32'h0;
;
    end
    

endmodule