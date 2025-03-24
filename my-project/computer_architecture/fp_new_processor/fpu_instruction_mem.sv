module fpu_instruction_memory (
    input logic clock,reset,
    input logic [31:0] mem_address,   // 32-bit address input
    output logic [31:0] machine_code   // 32-bit machine code output (instruction)
);

    logic [31:0] instruction_memory_reg [31:0] = '{default: 32'b0};


    always_ff @(posedge clock) begin
        machine_code <= instruction_memory_reg[mem_address[31:2]];  // Fetch instruction
    end

    // Initial block to load instructions into the memory array
    initial begin
        instruction_memory_reg[4'd1]=32'h002081B3;
    end

endmodule
