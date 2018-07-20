`include "../SHIFT_LEFT_2.v"

module SHIFT_LEFT_2_tb;

reg [31:0] A;
wire [31:0] O;

SHIFT_LEFT_2 shift (
	.A(A),
	.O(O)
);

initial begin
	A = 31'h3fffffff;
	$monitor("A = %b", A);
	#1
	$monitor("O = %b", O);
end

endmodule
