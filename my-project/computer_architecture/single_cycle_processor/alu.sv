module alu (
    input logic[31:0]a,b,
    input logic[3:0]operations,
    output logic[31:0]distination_data
);
logic [32:0]ini_out=17'b0;
 logic carry;

always@* begin 
    case (operations)
     4'd0:ini_out=b+a;
     4'd1:ini_out=b-a;
     4'd2:ini_out=b<<a;
     4'd3:ini_out=(($signed(b))<($signed(a)))?1:0;
     4'd4:ini_out=(($unsigned(b))<($unsigned(a)))?1:0;
     4'd5:ini_out=b^a;
     4'd6:ini_out=b>>a;
     4'd7:ini_out=b>>>a;
     4'd8:ini_out=b|a;
     4'd9:ini_out=b&a;
        default: 
        ini_out=17'b0;
    endcase
    carry=ini_out[32];
    distination_data=ini_out[31:0];
end   
endmodule