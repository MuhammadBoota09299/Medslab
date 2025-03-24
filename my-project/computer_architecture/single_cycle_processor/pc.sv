module pc(
    input logic clock,reset,
    output logic [31:0]pc_next=32'b0
);
always_ff @( posedge clock ) begin 
    if (reset) begin
        pc_next<=32'h0;
    end
    else begin
        pc_next<=pc_next+4;
    end
end 
endmodule