module parametric_counter #(parameter int width = 4) (
    input logic reset , up,down,clock,
    input logic [width-1:0]initial_value,
    output logic [width-1:0]count=0
);

    always_ff @( clock ) begin 
        if (reset) begin
            count<=initial_value;
        end
        else if (up) begin
            count<=count+1'b1;
        end
        else if (down)begin
            count <=count - 1'b1;
        end
    end
endmodule