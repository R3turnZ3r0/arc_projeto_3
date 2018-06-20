/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estatística e Informática
 * Disciplina: Arquitetura e Organização de Computadores
 * 
 * Registrador de 32 bits.
 *
 * @author André Aziz (andre.caraujo@ufrpe.br)
 */
module REGISTER(
  clk,
  nrst,
  A,
  O
);

input clk;
input nrst;
input A;
output O;

wire clk;
wire nrst;
wire [31:0] A;
reg [31:0] O;

initial begin : start_block
  O = 0;
end

always @(posedge clk) begin : register_block
  if (nrst == 0) begin
    O = 0;
  end
  else begin
    O = A;
  end
end

endmodule
  