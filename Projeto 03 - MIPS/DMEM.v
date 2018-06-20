/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estatística e Informática
 * Disciplina: Arquitetura e Organização de Computadores
 * 
 * Memória de dados.
 *
 * @author André Aziz (andreaziz@deinfo.ufrpe.br)
 */
 
module DMEM (
  clk,
  write_data,
  read_data,
  write,
  read,
  address
);

parameter SIZE = 32'h8000;

input clk;
input write_data;
output read_data;
input write;
input read;
input address;

wire clk;
wire [31:0] write_data;
reg [31:0] read_data;
wire write;
wire read;
wire [31:0] address;

reg [7:0] RAM [0:SIZE-1];

initial begin :  clear_memory
  integer   index;
  
  for (index = 0; index < SIZE; index = index + 1)
	RAM[index] = 0;
	
  read_data = 0;
end

always @(negedge clk) begin
  
  // Big endian	
  if (write == 1'b1) begin
    RAM[address+0] = write_data[31:24];    
    RAM[address+1] = write_data[23:16];
    RAM[address+2] = write_data[15:8];
    RAM[address+3] = write_data[7:0];
  end

end

always @(posedge read) begin  

  // Big endian	
  if (read == 1'b1) begin
    read_data = {RAM[address+0], RAM[address+1], RAM[address+2], RAM[address+3]};  
  end
end

endmodule