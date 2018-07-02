/**
 * MODIFICADO
 *
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estatística e Informática
 * Disciplina: Arquitetura e Organização de Computadores
 * 
 * Extensor de sinal de 16 para 32 bits.
 *
 * @author André Aziz (andre.caraujo@ufrpe.br)
 */
 
 // modificado para permitir funcionalidade de ZeroExtImm
module EXTEND(
  A,
  S,	// adicionado, 0 - ZeroExtImm | 1 - SignExtImm
  O
);

input A;
input S;
output O;

wire [15:0] A;
wire S;
wire [31:0] O;

always @(A, S) begin
	if(S == 0) begin
		O = {16'h0000, A};
	end else begin
		O[31:16] = (A[15 == 0]) ? 16'h0000 : 16'hffff;
		O[15:0] = A;
	end
end

// assign O[31:16] = (A[15] == 0) ? 0 : -1;
// assign O[15:0] = A;

endmodule
