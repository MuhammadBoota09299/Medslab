module pc(
    input logic clock,reset,
    output logic [31:0]pc_next=32'b0
);
logic pc;
always_comb begin
    pc_next=pc;
end
always_ff @( posedge clock ) begin
    if (reset) begin
        pc<=32'h0;
    end
    else begin
        pc <= pc+4;
    end
end
endmodule