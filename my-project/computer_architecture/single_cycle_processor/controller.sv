module controller (
    input logic [31:0]instructions ,
    output logic [3:0]operations,
    output logic write_enable,mux2_1_enable
);
logic [2:0]f3;
logic [6:0]f7;
logic [6:0]opcode;
always_comb begin
    opcode=instructions[6:0];
    f3=instructions[14:12];
    f7=instructions[31:25];
if (opcode==7'b0110011 || opcode==7'b0010011)begin
    write_enable=1'b1;
    case (f3)
         3'b000:if (f7==7'b0100000) begin
             operations=4'h1;
         end 
         else begin 
            operations=4'h0;
         end
         3'b001:operations=4'h2;
         3'b010:operations=4'h3;
         3'b011:operations=4'h4;
         3'b100:operations=4'h5;
         3'b101:if (f7==7'b0100000) begin
             operations=4'h7;
         end 
         else begin 
            operations=4'h6;
         end
         3'b110:operations=4'h8;
         3'b111:operations=4'h9; 
            default:begin 
                operations=4'd0; 
            end
        endcase 
end 
else begin
        write_enable=1'b0;
end
if (opcode==7'b0010011) begin
    mux2_1_enable=1'b0;
end   
else begin
    mux2_1_enable=1'b1;
end
end
endmodule