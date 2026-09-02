`timescale 1ns/1ps

module reg_8bit_tb;

logic clk;
logic reset;
logic clear;
logic load;
logic [7:0] d;
logic [7:0] q;

reg_8bit dut (
    .clk(clk),
    .rst(reset),
    .clear(clear),
    .load(load),
    .d(d),
    .q(q)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    // 1. Reset
    reset = 1;
    clear = 0;
    load  = 0;
    d = 8'b00000000;
    #10;

    // 2. Load data
    reset = 0;
    clear = 0;
    load  = 1;
    d = 8'b10110110;
    #10;

    // 3. Load another data
    d = 8'b11110000;
    #10;

    // 4. Hold previous value
    load = 0;
    d = 8'b00001111;
    #10;

    // 5. Clear
    clear = 1;
    load = 0;
    #10;

    // 6. Clear OFF and load again
    clear = 0;
    load = 1;
    d = 8'b11001100;
    #10;

    // 7. Reset again
    reset = 1;
    load = 1;
    d = 8'b01010101;
    #10;

    
end

endmodule