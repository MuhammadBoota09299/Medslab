module fpu_data_memory (
    input logic [4:0] mem_rd,          // 5-bit address to access memory (byte-aligned)
    input logic [31:0] mem_write_data, // Data to write to memory
    input logic mem_write_enable,      // Enable writing to memory
    input logic clock,                 // Clock signal
    input logic reset,                 // Reset signal
    output logic [31:0] mem_read_data  // Data read from memory
);

    logic [31:0] data_memory [63:0];
    data_memory[63:0] <= '{default: 32'b0};

    always_ff @(negedge clock or posedge reset) begin
        if (reset) begin
            data_memory[63:0] <= '{default: 32'b0};
        end
        else if(mem_write_enable & mem_rd !=5'b0 ) begin
            data_memory[mem_rd] <= mem_write_data;
            end
        end

    // Combinational process for memory read
    always_comb begin
            mem_read_data = data_memory[mem_rd];
    end

endmodule
