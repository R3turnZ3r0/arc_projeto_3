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
`define OPCODE_ADDIU  6'b001001
`define OPCODE_ANDI   6'b001100
`define OPCODE_ORI    6'b001101
`define OPCODE_SLTI   6'b001010
`define OPCODE_SLTIU  6'b001011
`define OPCODE_LW     6'b100011
`define OPCODE_LHU    6'b100101
`define OPCODE_LBU    6'b100100
`define OPCODE_SW     6'b101011
`define OPCODE_SH     6'b101001
`define OPCODE_SB     6'b101000
`define OPCODE_BEQ    6'b000100
`define OPCODE_BNE    6'b000101
`define OPCODE_J      6'b000010
`define OPCODE_JAL    6'b000011

/*
Vou (Jonas) alterar o tamanho deste barramento para 4 bits
`define ALUOP_ADDI   2'b00
`define ALUOP_ADDIU  2'b00
`define ALUOP_LW     2'b00
`define ALUOP_SW     2'b00
`define ALUOP_BEQ    2'b01
`define ALUOP_TIPO_R 2'b10
*/

/* Barramento de 4 bits, alterado */
`define ALUOP_ADDI   4'b0000
`define ALUOP_ADDIU  4'b0000
`define ALUOP_ANDI   4'b0011
`define ALUOP_ORI    4'b0101
`define ALUOP_SLTI   4'b0110
`define ALUOP_LW     4'b0000
`define ALUOP_SW     4'b0000
`define ALUOP_BEQ    4'b0001
`define ALUOP_BNE    4'b0100
`define ALUOP_TIPO_R 4'b0010

module CONTROL(
  nrst,
  opcode,
  branch,
  read_mem,
  write_mem,
  write_reg,
  sign_zero_extend,
  mux_write_rt_rd_cnst,
  mux_alu_src_reg_imm,
  alu_op,
  mux_branch_jump,
  mux_pc_branch,
  mux_load_byte_half_word,
  mux_reg_src_alu_mem_pc
);

input nrst;
input [5:0] opcode;
output branch;
output read_mem;
output write_mem;
output write_reg;
output sign_zero_extend;
output [1:0] mux_write_rt_rd_cnst;
output mux_alu_src_reg_imm;
output [3:0] alu_op;
output mux_branch_jump;
output mux_pc_branch;
output [1:0] mux_load_byte_half_word;
output [1:0] mux_reg_src_alu_mem_pc;

wire nrst;
wire [5:0] opcode;
reg branch;
reg read_mem;
reg write_mem;
reg write_reg;
reg sign_zero_extend;
reg [1:0] mux_write_rt_rd_cnst;
reg mux_alu_src_reg_imm;
//reg [1:0] alu_op;         // alteracao de barramento, antigo
reg [3:0] alu_op;           // alteracao de barramento, novo
reg mux_branch_jump;
reg mux_pc_branch;
reg [1:0] mux_load_byte_half_word;
reg [1:0] mux_reg_src_alu_mem_pc; // alteracao de barramento para 2 bits

initial begin
  branch 				= 0;
  read_mem 				= 0;
  write_mem 			= 0;
  write_reg 			= 0;
  sign_zero_extend 		= 1;
  alu_op 				= `ALUOP_TIPO_R;
  mux_write_rt_rd_cnst 	= 2'b01;
  mux_alu_src_reg_imm	= 0;
  mux_branch_jump 		= 1;
  mux_pc_branch			= 0;
  mux_load_byte_half_word	= 2'b00;
  mux_reg_src_alu_mem_pc	= 2'b01;
end

always @(nrst, opcode) begin : decode_thread

  if (nrst == 0) begin
    branch	    		= 0;
    read_mem			= 0;
    write_mem			= 0;
    write_reg			= 0;
    sign_zero_extend	= 1;
    alu_op				= `ALUOP_TIPO_R;
    mux_write_rt_rd_cnst	= 2'b01;
    mux_alu_src_reg_imm 	= 0;
    mux_branch_jump			= 1;
    mux_pc_branch			= 0;
    mux_load_byte_half_word	= 2'b00;
    mux_reg_src_alu_mem_pc	= 2'b01;  
  end
  else begin
    case (opcode)
 
        `OPCODE_TIPO_R: begin
        branch				= 0;
        read_mem			= 0;
        write_mem			= 0;
        write_reg			= 1;
        sign_zero_extend	= 1;
        alu_op				= `ALUOP_TIPO_R;
        mux_write_rt_rd_cnst	= 2'b01;
        mux_alu_src_reg_imm 	= 0;
        mux_branch_jump	 		= 1;
        mux_pc_branch			= 0;
        mux_load_byte_half_word	= 2'b10;
        mux_reg_src_alu_mem_pc	= 2'b01;  
        end
    
        `OPCODE_ADDI: begin
        branch				= 0;
        read_mem			= 0;
        write_mem			= 0;
        write_reg			= 1;
        sign_zero_extend	= 1;
        alu_op				= `ALUOP_ADDI;
        mux_write_rt_rd_cnst	= 2'b00;
        mux_alu_src_reg_imm 	= 1;
        mux_branch_jump			= 1;
        mux_pc_branch			= 0;
        mux_load_byte_half_word	= 2'b10;
        mux_reg_src_alu_mem_pc	= 2'b01;  
        end
        
        /* TODO falta testar */
        `OPCODE_ADDIU: begin
        branch				= 0;
        read_mem			= 0;
        write_mem			= 0;
        write_reg			= 1;
        sign_zero_extend 	= 1;
        alu_op				= `ALUOP_ADDIU;
        mux_write_rt_rd_cnst	= 2'b00;
        mux_alu_src_reg_imm 	= 1;
        mux_branch_jump			= 1;
        mux_pc_branch			= 0;
        mux_load_byte_half_word	= 2'b10;
        mux_reg_src_alu_mem_pc	= 2'b01;
        end
        
        /* TODO falta testar */
        `OPCODE_ANDI: begin
        branch				= 0;
        read_mem			= 0;
        write_mem			= 0;
        write_reg			= 1;
        sign_zero_extend 	= 0;
        alu_op				= `ALUOP_ANDI;
        mux_write_rt_rd_cnst	= 2'b00;
        mux_alu_src_reg_imm 	= 1;
        mux_branch_jump			= 1;
        mux_pc_branch			= 0;
        mux_load_byte_half_word	= 2'b10;
        mux_reg_src_alu_mem_pc	= 2'b01;
        end
        
        /* TODO falta testar */
        `OPCODE_ORI: begin
        branch				= 0;
        read_mem			= 0;
        write_mem			= 0;
        write_reg			= 1;
        sign_zero_extend 	= 0;
        alu_op				= `ALUOP_ORI;
        mux_write_rt_rd_cnst	= 2'b00;
        mux_alu_src_reg_imm 	= 1;
        mux_branch_jump			= 1;
        mux_pc_branch			= 0;
        mux_load_byte_half_word	= 2'b10;
        mux_reg_src_alu_mem_pc	= 2'b01;
        end
        
        /* TODO falta testar */
        `OPCODE_SLTI: begin
        branch				= 0;
        read_mem			= 0;
        write_mem			= 0;
        write_reg			= 1;
        sign_zero_extend	= 1;
        alu_op				= `ALUOP_SLTI;
        mux_write_rt_rd_cnst	= 2'b00;
        mux_alu_src_reg_imm		= 1;
        mux_branch_jump			= 1;
        mux_pc_branch			= 0;
        mux_load_byte_half_word	= 2'b10;
        mux_reg_src_alu_mem_pc	= 2'b01;
        end
        
        /* TODO falta testar */
        `OPCODE_SLTIU: begin
        branch				= 0;
        read_mem			= 0;
        write_mem			= 0;
        write_reg			= 1;
        sign_zero_extend	= 1;
        alu_op				= `ALUOP_SLTI;
        mux_write_rt_rd_cnst	= 2'b00;
        mux_alu_src_reg_imm 	= 1;
        mux_branch_jump			= 1;
        mux_pc_branch			= 0;
        mux_load_byte_half_word	= 2'b10;
        mux_reg_src_alu_mem_pc	= 2'b01;
        end
        
        `OPCODE_LW: begin
        branch 				= 0;
        read_mem 			= 1;
        write_mem	 		= 0;
        write_reg 			= 1;
        sign_zero_extend 	= 1;
        alu_op 				= `ALUOP_LW;
        mux_write_rt_rd_cnst	= 2'b00;
        mux_alu_src_reg_imm 	= 1;
        mux_branch_jump 		= 1;
        mux_pc_branch 			= 0;
        mux_load_byte_half_word	= 2'b10;
        mux_reg_src_alu_mem_pc	= 2'b00;  
        end
        
        /* TODO falta testar */
        `OPCODE_LHU: begin
        branch				= 0;
        read_mem			= 1;
        write_mem			= 0;
        write_reg			= 1;
        sign_zero_extend	= 1;
        alu_op				= `ALUOP_LW;
        mux_write_rt_rd_cnst	= 2'b00;
        mux_alu_src_reg_imm 	= 1;
        mux_branch_jump			= 1;
        mux_pc_branch			= 0;
        mux_load_byte_half_word	= 2'b01;
        mux_reg_src_alu_mem_pc	= 2'b00;
        end
        
        /* TODO falta testar */
        `OPCODE_LBU: begin
        branch				= 0;
        read_mem			= 1;
        write_mem			= 0;
        write_reg			= 1;
        sign_zero_extend	= 1;
        alu_op				= `ALUOP_LW;
        mux_write_rt_rd_cnst	= 2'b00;
        mux_alu_src_reg_imm 	= 1;
        mux_branch_jump			= 1;
        mux_pc_branch			= 0;
        mux_load_byte_half_word	= 2'b00;
        mux_reg_src_alu_mem_pc	= 2'b00;
        end
        
        `OPCODE_SW: begin
        branch				= 0;
        read_mem			= 0;
        write_mem			= 1;
        write_reg 			= 0;
        sign_zero_extend	= 1;
        alu_op				= `ALUOP_SW;
        mux_write_rt_rd_cnst	= 2'b00;
        mux_alu_src_reg_imm 	= 1;
        mux_branch_jump			= 1;
        mux_pc_branch			= 0;
        mux_load_byte_half_word	= 2'b10;
        mux_reg_src_alu_mem_pc	= 2'b00;  
        end

        `OPCODE_BEQ: begin
        branch				= 1;
        read_mem			= 0;
        write_mem			= 0;
        write_reg			= 0;
        sign_zero_extend	= 1;
        alu_op				= `ALUOP_BEQ;
        mux_write_rt_rd_cnst	= 2'b00;
        mux_alu_src_reg_imm 	= 0;
        mux_branch_jump			= 1;
        mux_pc_branch			= 1;
        mux_load_byte_half_word	= 2'b10;
        mux_reg_src_alu_mem_pc	= 2'b00;  
        end
        
        /* TODO falta testar */
        `OPCODE_BNE: begin
        branch				= 1;
        read_mem			= 0;
        write_mem			= 0;
        write_reg			= 0;
        sign_zero_extend	= 1;
        alu_op				= `ALUOP_BNE;
        mux_write_rt_rd_cnst	= 2'b00;
        mux_alu_src_reg_imm 	= 0;
        mux_branch_jump			= 1;
        mux_pc_branch			= 1;
        mux_load_byte_half_word	= 2'b10;
        mux_reg_src_alu_mem_pc	= 2'b00;
        end

        `OPCODE_J: begin
        branch				= 0;
        read_mem			= 0;
        write_mem			= 0;
        write_reg			= 0;
        sign_zero_extend	= 1;
        alu_op				= `ALUOP_TIPO_R;
        mux_write_rt_rd_cnst	= 2'b00;
        mux_alu_src_reg_imm 	= 0;
        mux_branch_jump			= 0;
        mux_pc_branch			= 0;
        mux_load_byte_half_word	= 2'b10;
        mux_reg_src_alu_mem_pc	= 2'b00;  
        end
        
        /* TODO falta testar */
        `OPCODE_JAL: begin
        branch				= 0;
        read_mem			= 0;
        write_mem			= 0;
        write_reg			= 1;
        sign_zero_extend	= 1;
        alu_op				= `ALUOP_TIPO_R;
        mux_write_rt_rd_cnst	= 2'b10;
        mux_alu_src_reg_imm 	= 0;
        mux_branch_jump			= 0;
        mux_pc_branch			= 0;
        mux_load_byte_half_word	= 2'b10;
        mux_reg_src_alu_mem_pc	= 2'b10;
        end
        
        
    endcase
  end
end

endmodule
