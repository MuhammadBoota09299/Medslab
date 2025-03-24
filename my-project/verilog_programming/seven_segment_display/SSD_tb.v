module SSD_tb ();
    wire[6:0]segments;
    reg [3:0]no;
    reg [6:0]expected_value_segments[15:0];
    integer i;
SSD uut(.segments(segments),.no(no)); 
initial begin
expected_value_segments[0]=7'b0000001;
expected_value_segments[1]=7'b1001111;
expected_value_segments[2]=7'b0010010;
expected_value_segments[3]=7'b0000110;
expected_value_segments[4]=7'b1001100;
expected_value_segments[5]=7'b0100100;
expected_value_segments[6]=7'b0100000;
expected_value_segments[7]=7'b0001111;
expected_value_segments[8]=7'b0000000;
expected_value_segments[9]=7'b0000100;
expected_value_segments[10]=7'b0001000;
expected_value_segments[11]=7'b1100000;
expected_value_segments[12]=7'b0110001;
expected_value_segments[13]=7'b1000010;
expected_value_segments[14]=7'b0110000;
expected_value_segments[15]=7'b0111000;
    $dumpfile("SSD.vcd");
    $dumpvars(0,SSD_tb);
    for (i=0;i<=15;i++) begin 
         no=i;
         #1;
        if (segments == expected_value_segments[i]) begin
            $display("%h     matched",no);
        end
        else begin
           $display("%h    not matched",no); 

        end

    end 
end

endmodule

