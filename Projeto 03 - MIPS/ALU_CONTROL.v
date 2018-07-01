/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estatística e Informática
 * Disciplina: Arquitetura e Organização de Computadores
 * 
 * Controle da ULA
 *
 * @author André Aziz (andre.caraujo@ufrpe.br)
 */
module ALU_CONTROL (
  funct,
  op,
  control
);

input funct;
input op;
output control;

wire [5:0] funct;
// wire [1:0] op;   // alteracao de barramento, antigo
wire [3:0] op;      // alteracao de barramento, novo
wire [3:0] control;

assign control = (op == 4'b0000) ? 4'b0010 :
                 (op == 4'b0001) ? 4'b0110 :
                 (op == 4'b0011) ? 4'b0000 :
                 (op == 4'b0101) ? 4'b0001 :
                 (op == 4'b0100) ? 4'b0100 :
                 (op == 4'b0010 && funct == 6'b100000) ? 4'b0010 :
                 (op == 4'b0010 && funct == 6'b100010) ? 4'b0110 :
                 (op == 4'b0010 && funct == 6'b100100) ? 4'b0000 :
                 (op == 4'b0010 && funct == 6'b100101) ? 4'b0001 :
                 (op == 4'b0010 && funct == 6'b101010) ? 4'b0111 :
                  4'b0000;

endmodule
