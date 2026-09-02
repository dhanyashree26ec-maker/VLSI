`timescale 1ns/1ps
module reg_4bit_tb;

logic clk;
logic rst;
logic en;
logic [3:0] d;
logic [3:0] q;

reg_4bit dut (
    .clk(clk),
    .rst(rst),
    .en(en),
    .d(d),
    .q(q)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    // 1. Reset
    rst = 1;
    en = 0;
    d = 4'b0000;
    #10;

    // 2. Enable = 1, load 1011
    rst = 0;
    en = 1;
    d = 4'b1011;
    #10;

    // 3. Enable = 0, q should hold 1011
    rst = 0;
    en = 0;
    d = 4'b1111;
    #10;

    // 4. Reset = 1, q should become 0000
    rst = 1;
    en = 1;
    d = 4'b1000;
    #10;

    
end

endmodule