module lab2_1(output logic x, y,
input logic a,b,c
);
   logic l;
logic m;
logic n;
logic o;
logic p;
not L1(l,c);
or m1(m,a,b);
xor x1(x,l,m);
nand n1(n,a,b);
xor o1(o,n,m);
and y1(y,o,m);
endmodule
