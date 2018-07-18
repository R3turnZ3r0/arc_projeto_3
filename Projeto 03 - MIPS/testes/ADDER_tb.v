`include "../ADDER.v"

module ADDER_tb;

reg		[31:0]	A;
reg		[31:0]	B;
wire	[31:0]	O;

initial begin
	$monitor ("A = %d | B = %d | O = %d", A, B, O);
	A = 31'd0;
	B = 31'd0;
	#500 $finish;
end

initial begin
	$dumpfile("ADDER_tb.vcd");
	$dumpvars(0, ADDER_tb, adder);
end

always begin
	#100 A = A + 100000000;
end

always begin
	#10 B = B + 100;
end

ADDER adder (
	.A(A),
	.B(B),
	.O(O)
);

endmodule
