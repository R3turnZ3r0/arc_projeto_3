/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estatística e Informática
 * Disciplina: Arquitetura e Organização de Computadores
 * 
 * Controle
 *
 * @author André Aziz (andre.caraujo@ufrpe.br)
 */

`define OPCODE_TIPO_R 6'b000000
`define OPCODE_ADDI   6'b001000
`define OPCODE_LW     6'b100011
`define OPCODE_SW     6'b101011
`define OPCODE_BEQ    6'b000100
`define OPCODE_J      6'b000010

`define ALUOP_ADDI   2'b00
`define ALUOP_LW     2'b00
`define ALUOP_SW     2'b00
`define ALUOP_BEQ    2'b01
`define ALUOP_TIPO_R 2'b10

module CONTROL(
  nrst,
  opcode,
  branch,
  read_mem,
  write_mem,
  write_reg,
  mux_write_rt_rd,
  mux_alu_src_reg_imm,
  alu_op,
  mux_branch_jump,
  mux_pc_branch,
  mux_reg_src_alu_mem
);

input nrst;
input opcode;
output branch;
output read_mem;
output write_mem;
output write_reg;
output  mux_write_rt_rd;
output mux_alu_src_reg_imm;
output alu_op;
output mux_branch_jump;
output mux_pc_branch;
output mux_reg_src_alu_mem;

wire nrst;
wire [5:0] opcode;
reg branch;
reg read_mem;
reg write_mem;
reg write_reg;
reg  mux_write_rt_rd;
reg mux_alu_src_reg_imm;
reg [1:0] alu_op;
reg mux_branch_jump;
reg mux_pc_branch;
reg mux_reg_src_alu_mem;

initial begin
  branch 		= 0;
  read_mem 		= 0;
  write_mem 		= 0;
  write_reg 		= 0;
  alu_op 		= `ALUOP_TIPO_R;
  mux_write_rt_rd 	= 1;
  mux_alu_src_reg_imm 	= 0;
  mux_branch_jump 	= 1;
  mux_pc_branch 	= 0;
  mux_reg_src_alu_mem 	= 1;
end

always @(nrst, opcode) begin : decode_thread

  if (nrst == 0) begin
    branch 		= 0;
    read_mem 		= 0;
    write_mem 		= 0;
    write_reg 		= 0;
    alu_op 		= `ALUOP_TIPO_R;
    mux_write_rt_rd 	= 1;
    mux_alu_src_reg_imm = 0;
    mux_branch_jump 	= 1;
    mux_pc_branch 	= 0;
    mux_reg_src_alu_mem = 1;  
  end
  else begin
    case (opcode)
 
    `OPCODE_TIPO_R: begin
      branch 			= 0;
      read_mem 			= 0;
      write_mem 		= 0;
      write_reg 		= 1;
      alu_op 			= `ALUOP_TIPO_R;
      mux_write_rt_rd 		= 1;
      mux_alu_src_reg_imm 	= 0;
      mux_branch_jump 		= 1;
      mux_pc_branch 		= 0;
      mux_reg_src_alu_mem 	= 1;  
    end
  
    `OPCODE_ADDI: begin
      branch 			= 0;
      read_mem 			= 0;
      write_mem 		= 0;
      write_reg 		= 1;
      alu_op 			= `ALUOP_ADDI;
      mux_write_rt_rd 		= 0;
      mux_alu_src_reg_imm 	= 1;
      mux_branch_jump 		= 1;
      mux_pc_branch 		= 0;
      mux_reg_src_alu_mem 	= 1;  
    end
 
    `OPCODE_LW: begin
      branch 			= 0;
      read_mem 			= 1;
      write_mem 		= 0;
      write_reg 		= 1;
      alu_op 			= `ALUOP_LW;
      mux_write_rt_rd 		= 0;
      mux_alu_src_reg_imm 	= 1;
      mux_branch_jump 		= 1;
      mux_pc_branch 		= 0;
      mux_reg_src_alu_mem 	= 0;  
    end

    `OPCODE_SW: begin
      branch 			= 0;
      read_mem 			= 0;
      write_mem 		= 1;
      write_reg 		= 0;
      alu_op 			= `ALUOP_SW;
      mux_write_rt_rd 		= 0;
      mux_alu_src_reg_imm 	= 1;
      mux_branch_jump 		= 1;
      mux_pc_branch 		= 0;
      mux_reg_src_alu_mem 	= 0;  
    end

    `OPCODE_BEQ: begin
      branch 			= 1;
      read_mem 			= 0;
      write_mem 		= 0;
      write_reg 		= 0;
      alu_op 			= `ALUOP_BEQ;
      mux_write_rt_rd 		= 0;
      mux_alu_src_reg_imm 	= 0;
      mux_branch_jump 		= 1;
      mux_pc_branch 		= 1;
      mux_reg_src_alu_mem 	= 0;  
    end

    `OPCODE_J: begin
      branch 			= 0;
      read_mem 			= 0;
      write_mem 		= 0;
      write_reg 		= 0;
      alu_op 			= `ALUOP_TIPO_R;
      mux_write_rt_rd 		= 0;
      mux_alu_src_reg_imm 	= 0;
      mux_branch_jump 		= 0;
      mux_pc_branch 		= 0;
      mux_reg_src_alu_mem 	= 0;  
    end
    endcase
  end
end

endmodule
