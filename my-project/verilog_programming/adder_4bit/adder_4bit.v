module adder_4bit( input wire [3:0]x,y, 
                   output wire [3:0]sum,
		           output wire carry);
 wire [3:0]c;
 assign c[0]=1'b0;
 full_adder uu1(.a(x[0]) ,.b(y[0]) ,.c(c[0]) ,.sum(sum[0]),.carry(c[1]));
 full_adder uu2(.a(x[1]) ,.b(y[1]) ,.c(c[1]) ,.sum(sum[1]),.carry(c[2])); 
 full_adder uu3(.a(x[2]) ,.b(y[2]) ,.c(c[2]) ,.sum(sum[2]),.carry(c[3]));
 full_adder uu4(.a(x[3]) ,.b(y[3]) ,.c(c[3]) ,.sum(sum[3]),.carry(carry)); 
endmodule
