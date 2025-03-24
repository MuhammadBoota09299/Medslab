module mux2_1 (
    input logic [31:0]a,b,
    input logic  sel,
    output logic [31:0]c
);
always_comb begin
    if (sel)begin
        c=a;
    end
    else begin
        c=b;
    end
end
endmodule
