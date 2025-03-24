module adder_4bit_tb();
reg [3:0]x,y;
wire [3:0]sum;
wire carry;
integer i,j;
adder_4bit but(.x(x), .y(y), .sum(sum), .carry(carry));

initial begin
	$dumpfile("adder_4bit.vcd");
	$dumpvars(0,adder_4bit_tb);
	$monitor("%b + %b = %b%b",x,y,carry,sum);
	for (i=0;i<=15;i=i+1)begin
		x=i;
		for (j=0;j<=15;j=j+1)begin
			y=j;
			#1;
		end
	end
$stop;	 
end
endmodule
