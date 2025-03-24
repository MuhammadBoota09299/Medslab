`timescale 1ps/1ps
module lab2_1_tb(
);
logic a1;
logic b1;
logic c1;
logic x1;
logic y1;
localparam period =10 ;
lab2_1 abc(.a(a1),
.b(b1),
.c(c1),
.x(x1),
.y(y1));
initial begin
    $dumpfile("lab2_1.vcd");
    $dumpvars(0,lab2_1_tb);
    a1=0;b1=0;c1=0;
    #period;
    c1=1;
    #period;
    b1=1;c1=0;
    #period;
    c1=1;
    #period;
    a1=1;b1=0;c1=0;
    #period;
    c1=1;
    #period;
    b1=1;c1=0;
    #period;
    c1=1;
    #period;
    $stop;
end
initial begin
    $monitor("a=%b,b=%b,c=%b,x=%b,y=%b",a1,b1,c1,x1,y1);
end
endmodule
