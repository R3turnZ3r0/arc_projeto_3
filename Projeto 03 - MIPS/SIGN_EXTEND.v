/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estatística e Informática
 * Disciplina: Arquitetura e Organização de Computadores
 * 
 * Extensor de singal de 16 para 32 bits.
 *
 * @author André Aziz (andre.caraujo@ufrpe.br)
 */
module SIGN_EXTEND(
  A,
  O
);

input A;
output O;

wire [15:0] A;
wire [31:0] O;

assign O[31:16] = (A[15] == 0) ? 0 : -1;
assign O[15:0] = A;

endmodule
