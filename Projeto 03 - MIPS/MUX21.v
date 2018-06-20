/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estatística e Informática
 * Disciplina: Arquitetura e Organização de Computadores
 * 
 * Mux 2 para 1.
 *
 * @author André Aziz (andre.caraujo@ufrpe.br)
 */
module MUX21(
  A,
  B,
  O,
  S
);

parameter DATA_WIDTH = 32;

input A;
input B;
input S;
output O;

wire [DATA_WIDTH-1:0] A;
wire [DATA_WIDTH-1:0] B;
wire [DATA_WIDTH-1:0] O;
wire S;

assign O = (S == 0) ? A : B;

endmodule
  