module fifo_queue_tb#(parameter width =3) ();
    logic [width-1:0]q_in,q_out;
    logic clock,reset,enqueue,dequeue,empty,full;
    fifo_queue uut1(.q_in(q_in),.q_out(q_out),.reset(reset),.clock(clock),.empty(empty),.full(full),.enqueue(enqueue),.dequeue(dequeue));
    
    initial begin
        clock=0;
        q_in=1;
        reset=0;
        enqueue=1;
        dequeue=0;
        #5;
        for (int i=0;i<=15;i++) begin
        q_in=$random;
        #5;
        reset=$random;
        #5;
        enqueue=$random;
        #5;
        dequeue=$random;
        #5;   
        end
        $finish;
    end
    always #1 clock=~clock;
    initial begin
        $dumpfile("fifo_queue.vcd");
        $dumpvars(0,fifo_queue_tb);
    end
endmodule