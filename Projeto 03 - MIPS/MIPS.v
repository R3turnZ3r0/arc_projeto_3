/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estatística e Informática
 * Disciplina: Arquitetura e Organização de Computadores
 * 
 * MIPS Top Level
 *
 * @author André Aziz (andre.caraujo@ufrpe.br)
 */
module MIPS (
  clk, 
  nrst
);

input clk;
input nrst;

wire clk;
wire nrst;

wire [31:0] FOUR_CONST;

// adicionado
wire [4:0] THIRTY_ONE_CONST;

wire [31:0] PC_out;

wire [31:0] ADDER_PC_INCR_out;

wire [31:0] IMEM_instr;

wire [31:0] MUX_PC_BRANCH_out;
wire [31:0] MUX_BRANCH_JUMP_out;
wire [31:0] MUX_ALU_SRC_REG_IMM_out;
wire [31:0] MUX_REG_SRC_ALU_MEM_out;
wire [4:0] MUX_WRITE_RS_RD_out;

wire [31:0] REGISTER_BANK_read_data_1_out;
wire [31:0] REGISTER_BANK_read_data_2_out;

wire [31:0] SIGN_EXTEND_out;

wire [31:0] SHIFT_BRANCH_out;

wire [31:0] ADDER_BRANCH_out;

wire [31:0] ULA_out;
wire ULA_zero;

wire [3:0] ALU_CONTROL_out;

wire [31:0] DMEM_out;

wire [31:0] SHIFT_JUMP_out;

// adicionado
wire AND_out;

wire CONTROL_branch;
wire CONTROL_read_mem;
wire CONTROL_write_mem;
wire CONTROL_write_reg;
wire CONTROL_mux_write_rt_rd_cnst;      // modificado, nomenclatura
wire CONTROL_mux_alu_src_reg_imm;
wire [3:0] CONTROL_alu_op;              // Alteracao de barramento, novo
wire CONTROL_mux_branch_jump;
wire CONTROL_mux_pc_branch;             // Provavelmente existe um bug aqui
wire [1:0] CONTROL_mux_reg_src_alu_mem_pc;    // Alteracao de barramento para 2 bits // TODO alterar barramento no control

assign FOUR_CONST = 4;

// adicionado
assign THIRTY_ONE_CONST = 31; // valor do 'return address' register

CONTROL control (
  .nrst(nrst),
  .opcode(IMEM_instr[31:26]),
  .branch(CONTROL_branch),
  .read_mem(CONTROL_read_mem),
  .write_mem(CONTROL_write_mem),
  .write_reg(CONTROL_write_reg),
  .mux_write_rt_rd_cnst(CONTROL_mux_write_rt_rd_cnst),
  .mux_alu_src_reg_imm(CONTROL_mux_alu_src_reg_imm),
  .alu_op(CONTROL_alu_op),
  .mux_branch_jump(CONTROL_mux_branch_jump),
  .mux_pc_branch(CONTROL_mux_pc_branch),
  .mux_reg_src_alu_mem(CONTROL_mux_reg_src_alu_mem_pc)
);

REGISTER pc (
  .clk(clk),
  .nrst(nrst),
  .A(MUX_BRANCH_JUMP_out),
  .O(PC_out)
);

IMEM imem (
  .address(PC_out),
  .instruction(IMEM_instr)
);

// modificado, antes era mux21
MUX41 #(
  .DATA_WIDTH(5)
) 
mux_write_rs_rd_cnst (
  .A(IMEM_instr[20:16]),
  .B(IMEM_instr[15:11]),
  .C(THIRTY_ONE_CONST),
  .D(THIRTY_ONE_CONST),     // repetido
  .O(MUX_WRITE_RS_RD_out),
  .S(CONTROL_mux_write_rt_rd_cnst)
);

REGISTER_BANK register_bank (
  .clk(clk),
  .write(CONTROL_write_reg),
  .write_data(MUX_REG_SRC_ALU_MEM_out),
  .write_address(MUX_WRITE_RS_RD_out),
  .read_address_1(IMEM_instr[25:21]),
  .read_address_2(IMEM_instr[20:16]),
  .read_data_1(REGISTER_BANK_read_data_1_out),
  .read_data_2(REGISTER_BANK_read_data_2_out)
);

SIGN_EXTEND sign_extend (
  .A(IMEM_instr[15:0]),
  .O(SIGN_EXTEND_out)
);

MUX21 mux_alu_src_reg_imm (
  .A(REGISTER_BANK_read_data_2_out),
  .B(SIGN_EXTEND_out),
  .O(MUX_ALU_SRC_REG_IMM_out),
  .S(CONTROL_mux_alu_src_reg_imm)
);

ULA ula (
  .A(REGISTER_BANK_read_data_1_out),   	       
  .B(MUX_ALU_SRC_REG_IMM_out),           
  .S(ULA_out),           
  .OP(ALU_CONTROL_out),          
  .Z(ULA_zero)            
);

ALU_CONTROL alu_control (
  .funct(IMEM_instr[5:0]),
  .op(CONTROL_alu_op),
  .control(ALU_CONTROL_out)
);

DMEM dmem (
  .clk(clk),
  .write_data(REGISTER_BANK_read_data_2_out),
  .read_data(DMEM_out),
  .write(CONTROL_write_mem),
  .read(CONTROL_read_mem),
  .address(ULA_out)
);

// modificado
MUX41 mux_reg_src_alu_mem (
  .A(DMEM_out),
  .B(ULA_out),
  .C(ADDER_PC_INCR_out),    // pc + 4
  .D(ADDER_PC_INCR_out),    // pc + 4
  .O(MUX_REG_SRC_ALU_MEM_out),
  .S(CONTROL_mux_reg_src_alu_mem_pc)
);

ADDER adder_pc_incr (
  .A(PC_out),
  .B(FOUR_CONST),
  .O(ADDER_PC_INCR_out)
);

SHIFT_LEFT_2 shift_branch (
  .A(SIGN_EXTEND_out),
  .O(SHIFT_BRANCH_out)
);

ADDER adder_branch (
  .A(ADDER_PC_INCR_out),
  .B(SHIFT_BRANCH_out),
  .O(ADDER_BRANCH_out)
);

MUX21 mux_pc_branch (
  .A(ADDER_PC_INCR_out),
  .B(ADDER_BRANCH_out),
  .O(MUX_PC_BRANCH_out),
  // .S(CONTROL_mux_pc_branch)  // alterado - removido
  .S(AND_out)                   // adicionado
);

// adicionado
AND and_branch_jump (
  .A(CONTROL_branch),
  .B(ULA_zero),
  .O(AND_out)
);

SHIFT_LEFT_2 shift_jump (
  .A({6'b000000, IMEM_instr[25:0]}),
  .O(SHIFT_JUMP_out)
);

MUX21 branch_jump (
  .A({PC_out[31:28], SHIFT_JUMP_out[27:0]}),
  .B(MUX_PC_BRANCH_out),
  .O(MUX_BRANCH_JUMP_out),
  .S(CONTROL_mux_branch_jump)
);

endmodule
