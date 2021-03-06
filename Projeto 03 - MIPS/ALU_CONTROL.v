/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estat�stica e Inform�tica
 * Disciplina: Arquitetura e Organiza��o de Computadores
 * 
 * Controle da ULA
 *
 * @author Andr� Aziz (andre.caraujo@ufrpe.br)
 */
module ALU_CONTROL (
  funct,
  op,
  mux_alu_src_regimm_shamt,
  control
);

input [5:0] funct;
input [3:0] op;
// adicionado
output mux_alu_src_reg_imm;
output [3:0] control;

wire [5:0] funct;
// wire [1:0] op;   // alteracao de barramento, antigo
wire [3:0] op;      // alteracao de barramento, novo
// adicionado
wire mux_alu_src_regimm_shamt;
wire [3:0] control;

// adicionado
assign mux_alu_src_regimm_shamt = (op == 4'b0010 && funct == 6'b000000) ? 1 :
                                  (op == 4'b0010 && funct == 6'b000010) ? 1 :
                                   0;

assign control = (op == 4'b0000) ? 4'b0010 :
                 (op == 4'b0001) ? 4'b0110 :
                 (op == 4'b0011) ? 4'b0000 :
                 (op == 4'b0101) ? 4'b0001 :
                 (op == 4'b0110) ? 4'b0111 :
                 (op == 4'b0100) ? 4'b0100 :
                 (op == 4'b0010 && funct == 6'b100000) ? 4'b0010 :
                 (op == 4'b0010 && funct == 6'b100010) ? 4'b0110 :
                 (op == 4'b0010 && funct == 6'b000000) ? 4'b0011 :
                 (op == 4'b0010 && funct == 6'b000010) ? 4'b0100 :
                 (op == 4'b0010 && funct == 6'b100100) ? 4'b0000 :
                 (op == 4'b0010 && funct == 6'b100101) ? 4'b0001 :
                 (op == 4'b0010 && funct == 6'b101010) ? 4'b0111 :
                  4'b0000;

endmodule
