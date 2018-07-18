  
module MUX21_tb;
    reg    [31:0] A, B;
    reg    S;
    wire    [31:0] O;
initial begin
    A <= 31'b01; //value of A
    B <= 31'b10; //value of B
    S <= 0; // delay
    #1 
    $monitor("A = %d | B = %d | O = %b", A,B,O);
    #1
    S <= 1;
    $monitor("A = %d | B = %d | O = %b", A,B,O);
    
    $finish;
end

//waveform display
initial begin
    $dumpfile("MUX21_tb.vcd");
    $dumpvars(0,MUX21_tb,mux21);
end

MUX21 mux21(
	.A(A),
	.B(B),
	.O(O),
	.S(S)
);

endmodule
