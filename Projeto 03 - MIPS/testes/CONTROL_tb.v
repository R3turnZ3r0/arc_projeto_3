module CONTROL_tb;
	reg nrst;
	reg [5:0] opcode;
	wire branch;
	wire read_mem;
	wire write_mem;
	wire write_reg;
	wire sign_zero_extend;
	wire [1:0] mux_write_rt_rd_cnst;
	wire mux_alu_src_reg_imm;
	wire [3:0] alu_op;   
	wire mux_branch_jump;
	wire mux_pc_branch;
	wire [1:0] mux_load_byte_half_word;
	wire [1:0] mux_reg_src_alu_mem_pc; 
initial begin // generates the clock and reset signals
	nrst	= 1'b1;
	opcode	= 6'b000000;
	repeat(1) #10  	opcode	= 6'b000000;
	repeat(1) #10  	opcode	= 6'b001000;
	repeat(1) #10  	opcode	= 6'b001001;
	repeat(1) #10  	opcode	= 6'b001100;
	repeat(1) #10  	opcode	= 6'b001101;
	repeat(1) #10  	opcode	= 6'b001010;
	repeat(1) #10  	opcode	= 6'b001011; 	
	repeat(1) #10  	opcode	= 6'b100011;
	repeat(1) #10  	opcode	= 6'b100101;
	repeat(1) #10  	opcode	= 6'b100100;
	repeat(1) #10  	opcode	= 6'b101011;
	repeat(1) #10  	opcode	= 6'b101001;
	repeat(1) #10  	opcode	= 6'b101000;
	repeat(1) #10  	opcode	= 6'b000100;
	repeat(1) #10  	opcode	= 6'b000101;
	repeat(1) #10  	opcode	= 6'b000010;
	repeat(1) #10  	opcode	= 6'b000011;
end

initial begin //testes
	
	$monitor("nrst = %b| opcode = %b | branch = %b | read_mem = %b|  write_mem = %b| 	write_reg = %b|  sign_zero_extend = %b |  mux_write_rt_rd_cnst = %b |  mux_alu_src_reg_imm = %b |  alu_op = %b |  mux_branch_jump = %b |  mux_pc_branch = %b |  mux_load_byte_half_word = %b |	  mux_reg_src_alu_mem_pc = %b",
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
			mux_reg_src_alu_mem_pc);


end


initial begin

	$dumpfile("CONTROL_tb.vcd");
	$dumpvars(0,CONTROL_tb,control);
end

CONTROL control(
	.nrst(nrst),
	.opcode(opcode),
	.branch(branch),
	.read_mem(read_mem),
	.write_mem(write_mem),
	.write_reg(write_reg),
	.sign_zero_extend(sign_zero_extend),
	.mux_write_rt_rd_cnst(mux_write_rt_rd_cnst),
	.mux_alu_src_reg_imm(mux_alu_src_reg_imm),
	.alu_op(alu_op),
	.mux_branch_jump(mux_branch_jump),
	.mux_pc_branch(mux_pc_branch),
	.mux_load_byte_half_word(mux_load_byte_half_word),
	.mux_reg_src_alu_mem_pc(mux_reg_src_alu_mem_pc) 
);

endmodule
