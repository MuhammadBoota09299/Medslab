module fifo_queue #(parameter depth = 3 ,parameter width =3)(input logic [width-1:0]q_in ,
input logic reset,clock,enqueue,dequeue,
output logic [width-1:0]q_out ,logic full,empty    
);
    logic [depth:0]count=0;
    logic [width-1:0]queue[depth-1:0]='{default:0};
    always_ff @( posedge clock ) begin 
        if (reset) begin
            count <=0;
            queue <= '{default:0};
        end
        else if (enqueue && !(count==depth)) begin
            queue[count]<=q_in;
            count <=count+1;
        end
        else if (dequeue && !(count==0)) begin
            for (int i =0 ;i<width-1 ;i++ ) begin
               queue[i]<=queue[i+1];
            end
            queue[width-1]=0;
            count<=count-1;
        end
    end
    always_comb begin
      if (count==depth) begin
        full=1'b1;
      end 
      else full=1'b0; 
    end
    always_comb begin
        if (count==0) begin
            empty=1'b1;
        end else begin
            empty=1'b0;
        end
    end
    always_comb begin 
        if (dequeue && !(count==0)) begin
            q_out=queue[0];
        end
        else begin
            q_out=0;
        end
    end
endmodule