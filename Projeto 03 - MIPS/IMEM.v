/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estatística e Informática
 * Disciplina: Arquitetura e Organização de Computadores
 * 
 * Memória de instruções.
 *
 * @author André Aziz (andreaziz@deinfo.ufrpe.br)
 */
//`define MEMORY_HEX
 
module IMEM (
  address,
  instruction
);

parameter SIZE = 32'h8000;
parameter MEMORY_FILE = "memory.bin";

input address;
output instruction;

wire [31:0] address;
wire [31:0] instruction;
reg [31:0] ROM [0:(SIZE>>2)-1];

initial begin : load_default_memory
  integer   index;
  
  for (index = 0; index < (SIZE>>2); index = index + 1)
	ROM[index] = 0;
  
  $readmemh(MEMORY_FILE, ROM);
  
end

assign instruction = ROM[address>>2];  

endmodule