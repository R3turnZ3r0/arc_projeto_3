`include "../AND.v"

module AND_tb;

reg		A;
reg		B;
wire	O;

initial begin
	$monitor("A = %b | B = %b | O = %b", A, B, O);
	#0
	A = 1'b0;
	B = 1'b0;
	
	#5
	A = 1'b1;
	B = 1'b0;
	
	#5
	A = 1'b0;
	B = 1'b1;
	
	#5
	A = 1'b1;
	B = 1'b1;
end

initial begin
	$dumpfile("AND_tb.vcd");
	$dumpvars(0, AND_tb, and);
end

AND and (
	.A(A),
	.B(B),
	.O(O)
);

endmodule
