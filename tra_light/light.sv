
module traffic_light(
    input logic clk,
    input logic reset,
    output logic red, green, yellow
);

logic [1:0] state;
logic [2:0] count;

always_ff @(posedge clk) begin
    if (reset) begin
        state <= 0;
        count <= 0;
    end
    else if (state == 0 && count == 4) begin
        state <= 1;
        count <= 0;
    end
    else if (state == 1 && count == 4) begin
        state <= 2;
        count <= 0;
    end
    else if (state == 2 && count == 1) begin
        state <= 0;
        count <= 0;
    end
    else
        count <= count + 1;
end

always_comb begin
    red = 0;
    green = 0;
    yellow = 0;

    if (state == 0)
        red = 1;
    else if (state == 1)
        green = 1;
    else
        yellow = 1;
end

endmodule
