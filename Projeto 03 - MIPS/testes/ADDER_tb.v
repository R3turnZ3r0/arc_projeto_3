`include "../ADDER.v"

module ADDER_tb;

reg		[31:0]	A;
reg		[31:0]	B;
wire	[31:0]	O;

initial begin
	$monitor ("A = %b | B = %b | O = %b", A, B, O);
end

endmodule
