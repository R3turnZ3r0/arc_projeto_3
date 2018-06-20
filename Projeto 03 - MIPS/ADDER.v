/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estatística e Informática
 * Disciplina: Arquitetura e Organização de Computadores
 * 
 * Somador de 32 bits.
 *
 * @author André Aziz (andre.caraujo@ufrpe.br)
 */
module ADDER(
  A,
  B,
  O
);

input A;
input B;
output O;

wire [31:0] A;
wire [31:0] B;
wire [31:0] O;

assign O = A + B;

endmodule
  