/* 
 * Modulo para efetuar AND logico
 * 
 * @author Jonas Freire (jonasfreireperson@gmail.com)
 */
 
module AND (
    A,
    B,
    O
);

input  A;
input  B;
output O;

wire A;
wire B;
reg  O;

assign O = A & B;

endmodule
