module MUX41_tb;
	reg [31:0] A, B, C, D;
	reg [1:0] S;
	wire [31:0] O;

initial begin
	A <= 32'b111;
	B <= 32'b101;
	C <= 32'b110;
	D <= 32'b000;
	S <= 2'b00;
	#1
	$monitor("A = %b | B = %b | C = %b | D = %b | O = %b | S = %b", A,B,C,D,O, S);
	#1
	S <= 2'b01;
	$monitor("A = %b | B = %b | C = %b | D = %b | O = %b | S = %b", A,B,C,D,O, S);
	#1
	S <= 2'b10;
	$monitor("A = %b | B = %b | C = %b | D = %b | O = %b | S = %b", A,B,C,D,O, S);
	#1
	S <= 2'b11;
	$monitor("A = %b | B = %b | C = %b | D = %b | O = %b | S = %b", A,B,C,D,O, S);
	#1
	$finish;
end

initial begin
	$dumpfile("MUX41_tc.vcd");
	$dumpvars(0,MUX41_tb,mux41);
end

MUX41 mux41(
	.A(A),
	.B(B),
	.C(C),
	.D(D),
	.S(S),
	.O(O)
);

endmodule
