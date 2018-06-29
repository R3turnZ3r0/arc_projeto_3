/*
 * Mux 4 para 1
 *
 * @author Jonas Freire (jonasfreireperson@gmail.com)
 */
module MUX41 (
  A,
  B,
  C,
  D,
  O,
  S
);

parameter DATA_WIDTH = 32;

input A;
input B;
input C;
input D;
input S;
output O;


wire [DATA_WIDTH-1:0] A;
wire [DATA_WIDTH-1:0] B;
wire [DATA_WIDTH-1:0] C;
wire [DATA_WIDTH-1:0] D;
wire [1:0] S;
reg  [DATA_WIDTH-1:0] O;

assign O = (S == 2'b00) ? A :
           (S == 2'b01) ? B :
           (S == 2'b10) ? C :
           (S == 2'b11) ? D;

endmodule
