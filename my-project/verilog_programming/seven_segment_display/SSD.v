module SSD(
    input [3:0]no,
    output reg [6:0]segments
);
always @(*) begin
    case (no)
    4'h0:segments=7'b0000001;
    4'h1:segments=7'b1001111;
    4'h2:segments=7'b0010010;
    4'h3:segments=7'b0000110;
    4'h4:segments=7'b1001100;
    4'h5:segments=7'b0100100;
    4'h6:segments=7'b0100000;
    4'h7:segments=7'b0001111;
    4'h8:segments=7'b0000000;
    4'h9:segments=7'b0000100;
    4'hA:segments=7'b0001000;
    4'hB:segments=7'b1100000;
    4'hC:segments=7'b0110001;
    4'hD:segments=7'b1000010;
    4'hE:segments=7'b0110000;
    4'hF:segments=7'b0111000; 
        default: 
        segments=7'b1111111;
    endcase
end
endmodule