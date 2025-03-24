module alu (
    input logic[31:0]a,b,
    input logic[2:0]op,
    output logic[31:0]out
);
logic [32:0]ini_out;
 logic carry;

always@* begin 
    case (op)
     3'd0: ini_out=a+b;
     3'd1: ini_out=a-b;
     3'd2: ini_out=a<<b;
     3'd3: ini_out=(a<b)?1:0;
     3'd4: ini_out=a^b;
     3'd5:ini_out=a>>b;
     3'd6:ini_out=a|b;
     3'd7:ini_outa&b;
        default: 
        ini_out=17'b0;
    endcase
    carry=ini_out[32];
    out=ini_out[31:0];
end   
endmodule