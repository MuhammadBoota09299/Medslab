module immediate (
    input logic [11:0]immediate_in,
    output logic [31:0]immediate_out
);
    always_comb begin 
        if (immediate_in[11]==1) begin
            immediate_out={20'b1,immediate_in};
        end
        else begin
            immediate_out={20'b0,immediate_in};
        end
    end
endmodule