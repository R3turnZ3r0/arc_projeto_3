/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estatística e Informática
 * Disciplina: Arquitetura e Organização de Computadores
 * 
 * Shift left de 2 bits.
 *
 * @author André Aziz (andre.caraujo@ufrpe.br)
 */
module SHIFT_LEFT_2(
  A,
  O
);

input A;
output O;

wire [31:0] A;
wire [31:0] O;

assign O[31:2] = A[29:0];
assign O[1:0] = 0;

endmodule