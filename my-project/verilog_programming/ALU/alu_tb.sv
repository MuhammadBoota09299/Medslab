module alu_tb ();
logic [15:0]a,b;
logic [2:0]op;
logic carry;
logic [15:0]out;
alu uut(.a(a),.b(b),.op(op),.carry(carry),.out(out));
initial begin 
 for (int i=0; i<20 ; i++) begin
    a=$random;
    b=$random;
    op=$random;
    #5; 
 end
end
initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0,alu_tb);
end
endmodule 