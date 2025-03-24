module parametric_counter_tb #(parameter width=4)();
    logic up,down,reset,clock;
    logic [width-1:0]initial_value,count;
    parametric_counter uut1(.up(up),.down(down),.reset(reset),.clock(clock),.initial_value(initial_value),.count(count));
    always #0.5 clock=~clock ; 
    initial begin
        clock=0;
        up=0;
        down=0;
        reset=0;
        initial_value=3'd7;
        #2;
        for (int i=0 ;i<=16;i++) begin
        up=$random;
        #2;
        down=$random;
        #2;
        reset=$random;
        #2;
        initial_value=$random;
        #2;
        end
        $finish;
       end
    initial begin
        $dumpfile("parameteric_counter.vcd");
        $dumpvars(0,parametric_counter_tb);
    end
endmodule