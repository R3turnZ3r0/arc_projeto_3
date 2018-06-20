/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estatística e Informática
 * Disciplina: Arquitetura e Organização de Computadores
 * 
 * Banco de Registradores.
 *
 * @author André Aziz (andreaziz@deinfo.ufrpe.br)
 */
 
module REGISTER_BANK (
  clk,
  write,
  write_data,
  write_address,
  read_address_1,
  read_address_2,
  read_data_1,
  read_data_2
);

input clk;
input write;
input write_data;
input write_address;
input read_address_1;
input read_address_2;
output read_data_1;
output read_data_2;

wire clk;
wire write;
wire [31:0] write_data;
wire [4:0] write_address;
wire [4:0] read_address_1;
wire [4:0] read_address_2;
wire [31:0] read_data_1;
wire [31:0] read_data_2;

reg [31:0] registers [0:31];

assign read_data_1 = registers[read_address_1];
assign read_data_2 = registers[read_address_2];  

initial begin : register_bank_reset_process
  integer i;

  for (i = 0; i < 32; i = i + 1) begin
    registers[i] = 0;
  end
end

always @(negedge clk) begin : register_bank_write_process
  if (write == 1 && write_address != 0) begin
    registers[write_address] = write_data;
  end
end

endmodule