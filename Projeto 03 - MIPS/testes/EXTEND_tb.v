`include "../EXTEND.v"

module EXTEND_tb;

reg [15:0] A;
reg S;
wire [31:0] O;

EXTEND extend (
	.A(A),
	.S(S),
	.O(O)
);

initial begin
	A <= 16'hfff0;
	S <= 1'b0;
	$monitor("A = %b | S = %b | O = %b", A, S, O);
	#1
	A <= 16'h0ff0;
	S <= 1'b0;
	$monitor("A = %b | S = %b | O = %b", A, S, O);
	#1
	A <= 16'hfff0;
	S <= 1'b1;
	$monitor("A = %b | S = %b | O = %b", A, S, O);
	#1
	A <= 16'h0ff0;
	S <= 1'b1;
	$monitor("A = %b | S = %b | O = %b", A, S, O);
	
	$finish;
end

initial begin
	$dumpfile("EXTEND_tb.vcd");
	$dumpvars(0, EXTEND_tb, extend);
end

endmodule
