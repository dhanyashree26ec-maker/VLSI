module reg_8bit(
input logic clk,
input logic rst,
input logic clear,
input logic load,
input logic [7:0] d,
output logic [7:0] q
);
always_ff @(posedge clk) begin
if(rst==1)
q<=8'b00000000;
else if(clear==1)
q<=8'b00000000;
else if(load==1)
q<=d;
end
endmodule
