module mux2_1(
    input logic [31:0]mux2_1_x1,mux2_1_x2,
    input logic mux2_1_enable,
    output logic [31:0]mux2_1_y 
);
 always_comb begin 
    if (mux2_1_enable) begin
        mux2_1_y=mux2_1_x1;
    end
    else begin
        mux2_1_y=mux2_1_x2;
    end
 end   
endmodule