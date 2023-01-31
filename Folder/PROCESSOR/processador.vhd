library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity processador is port(
	clk, rst_principal : in std_logic;
	nibble_IR_msb_out : out std_logic_vector(3 downto 0);
	addr_z, W_data_z, R_data_z, data_I_z : out std_logic_vector(15 downto 0);
	D_addr_z, RF_W_data_z : out std_logic_vector(7 downto 0);
	saida_p, RF_W_addr_z, RF_Rp_addr_z, RF_Rq_addr_z : out std_logic_vector(3 downto 0);
	PC_up_z, PC_clr_z, PC_ld_z, D_rd_z, D_wr_z, I_rd_z, RF_s1_z, RF_s0_z, RF_W_wr_z, RF_Rp_rd_z, RF_Rq_rd_z, RF_Rp_zero_z, alu_s0_z, alu_s1_z : out std_logic);
end processador;
architecture behavior_processador of processador is
component data_i port(
	data : out std_logic_vector(15 downto 0);
	rd : in std_logic;
	addr : in std_logic_vector(15 downto 0)
);
end component data_i;
component data_d port(
	clk_d : in std_logic;
	addr : in std_logic_vector(7 downto 0);
	rd : in std_logic;
	wr : in std_logic;
	W_data : in std_logic_vector(15 downto 0);
	R_data : out std_logic_vector(15 downto 0)
);
end component data_d;
component unidade_de_controle port(
	RF_Rp_zero_uc, clk_uc, rst : in std_logic;
	addr_uc : out std_logic_vector(15 downto 0);
	data_uc : in std_logic_vector(15 downto 0);
	D_rd_uc, D_wr_uc, RF_s0_uc, RF_s1_uc, RF_W_wr_uc, RF_Rp_rd_uc, RF_Rq_rd_uc, alu_s1_uc, alu_s0_uc, I_rd_uc, PC_clr_f, PC_ld_f, PC_up_f : out std_logic;
	D_addr_uc, RF_W_data_uc : out std_logic_vector(7 downto 0);
	RF_W_addr_uc, RF_Rp_addr_uc, RF_Rq_addr_uc, saida_uc, nibble_IR_msb_uc : out std_logic_vector(3 downto 0));
end component unidade_de_controle;
component bloco_operacional port(
	R_data_op : in std_logic_vector(15 downto 0);
	W_data_op : out std_logic_vector(15 downto 0);
	RF_W_data_op : in std_logic_vector(7 downto 0);
	RF_W_addr_op, RF_Rp_addr_op, RF_Rq_addr_op : in std_logic_vector(3 downto 0);
	RF_s1_op, RF_s0_op, RF_W_wr_op, RF_Rp_rd_op, RF_Rq_rd_op, alu_s0_op, alu_s1_op, clk_op : in std_logic;
	RF_Rp_zero_op : out std_logic);
end component bloco_operacional;
signal Data_I_x, addr_x, W_data_x, R_data_x : std_logic_vector(15 downto 0);
signal RF_W_data_x, D_addr_x : std_logic_vector(7 downto 0);
signal RF_Rp_addr_x, RF_Rq_addr_x, RF_W_addr_x : std_logic_vector(3 downto 0);
signal I_rd_x, D_rd_x, D_wr_x, RF_s1_x, RF_s0_x, RF_W_wr_x, RF_Rp_rd_x, RF_Rq_rd_x, RF_Rp_zero_x, alu_s1_x, alu_s0_x : std_logic;
begin
	Memoria_Instruncao : Data_i port map(
		data => data_I_x,
		rd => I_rd_x,
		addr => addr_x
	);
	Memoria_Dados : data_d port map(
		clk_d => clk,
		addr => D_addr_x,
		rd => D_rd_x,
		wr => D_wr_x,
		W_data => W_data_x,
		R_data => R_data_x
	);
	Unidade_Controle : unidade_de_controle port map(
		RF_Rp_zero_uc => RF_Rp_zero_x,
		clk_uc => clk,
		rst => rst_principal,
		addr_uc => addr_x,
		data_uc => Data_I_x,
		D_addr_uc => D_addr_x,
		RF_W_data_uc => RF_W_data_x,
		RF_W_addr_uc => RF_W_addr_x,
		RF_Rp_addr_uc => RF_Rp_addr_x, 
		RF_Rq_addr_uc => RF_Rq_addr_x, 
		saida_uc => saida_p,
		D_rd_uc => D_rd_x,
		D_wr_uc => D_wr_x,
		RF_s0_uc => RF_s0_x,
		RF_s1_uc => RF_s1_x,
		RF_W_wr_uc => RF_W_wr_x,
		RF_Rp_rd_uc => RF_Rp_rd_x,
		RF_Rq_rd_uc => RF_Rq_rd_x,
		alu_s1_uc => alu_s1_x,
		alu_s0_uc => alu_s0_x,
		PC_clr_f => PC_clr_z,
		PC_ld_f => PC_ld_z,
		PC_up_f => PC_up_z,
		nibble_IR_msb_uc => nibble_IR_msb_out,
		I_rd_uc => I_rd_x
	);
	Bloco_OP : bloco_operacional port map(
		R_data_op => R_data_x,
		W_data_op => W_data_x,
		RF_W_data_op => RF_W_data_x,
		RF_W_addr_op => RF_W_addr_x,
		RF_Rp_addr_op => RF_Rp_addr_x,
		RF_Rq_addr_op => RF_Rq_addr_x,
		RF_s1_op => RF_s1_x,
		RF_s0_op => RF_s0_x,
		RF_W_wr_op => RF_W_wr_x,
		RF_Rp_rd_op => RF_Rp_rd_x,
		RF_Rq_rd_op => RF_Rq_rd_x,
		alu_s0_op => alu_s0_x,
		alu_s1_op => alu_s1_x,
		clk_op => clk,
		RF_Rp_zero_op => RF_Rp_zero_x
		);
		addr_z <= addr_x;
		W_data_z <= W_data_x;
		R_data_z <= R_data_x;
		D_addr_z <= D_addr_x;
		D_rd_z <= D_rd_x;
		D_wr_z <= D_wr_x;
		data_I_z <= data_I_x;
		I_rd_z <= I_rd_x;
		RF_W_data_z <= RF_W_data_x;
		RF_s0_z <= RF_s0_x;
		RF_s1_z <= RF_s1_x;
		RF_W_addr_z <= RF_W_addr_x;
		RF_Rp_addr_z <= RF_Rp_addr_x;
		RF_Rq_addr_z <= RF_Rq_addr_x;
		RF_W_wr_z <= RF_W_wr_x;
		RF_Rp_rd_z <= RF_Rp_rd_x;
		RF_Rq_rd_z <= RF_Rq_rd_x;
		RF_Rp_zero_z <= RF_Rp_zero_x;
		alu_s0_z <= alu_s0_x;
		alu_s1_z <= alu_s1_x;
end behavior_processador;










-----------------------------------------------------------------------------------
--                       MEMÓRIA DE INSTRUÇÃO (ROM)                              --
-----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity data_i is port(
	data : out std_logic_vector(15 downto 0);
	rd : in std_logic;
	addr : in std_logic_vector(15 downto 0)
);
end data_i;
architecture behavior_data_i of data_i is
type memory_i is array (0 to 100) of std_logic_vector(15 downto 0);
signal mem_i : memory_i; 
signal addr_s : integer;
begin
addr_s <= to_integer(unsigned(addr));
process (rd) begin
	mem_i(0) <= "0011100000000000"; -- INSTRUÇÃO PARA INICIALIZAÇÃO
	mem_i(1) <= "0000000000000111"; -- CARREGAR O DADO(7) EM RF(0)
	mem_i(2) <= "0011111100000000"; -- CARREGAR 0 EM RF(15)
	mem_i(3) <= "0011000100000101"; -- CARREGAR 5 EM RF(1)
	mem_i(4) <= "0011001000000000"; -- CARREGAR 0 EM RF(2) E USAR COMO UM CONTADOR
	mem_i(5) <= "0011001100000001"; -- CARREGAR 1 EM RF(3) E USAR PARA INCREMENTAR
	mem_i(6) <= "0011010000000011"; -- CARREGAR 3 EM RF(4) E USAR COMO DECREMENTO
	mem_i(7) <= "0000010100001010"; -- CARREGAR O DADO(10) EM RF(5)
	mem_i(8) <= "0100111001010001"; -- RF(5) - RF(1) => RF(14)
	mem_i(9) <= "0101111000011110"; -- SE FOR IGUAL 0 ENTÃO, PC <= 39 = 9 + 30 
	mem_i(10) <= "0000010100001011"; -- CARREGAR DADO(11) EM RF(5)
	mem_i(11) <= "0100111001010001"; -- RF(5) - RF(1) => RF(14)
	mem_i(12) <= "0101111100101000"; -- SE FOR IGUAL A 0 ENTÃO, PC <= 52 = 12 + 40
	mem_i(13) <= "0000010100001100"; -- CARREGAR DADO(12) EM RF(5)
	mem_i(14) <= "0100111001010001"; -- RF(5) - RF(1) => RF(14)
	mem_i(15) <= "0101110000110010"; -- SE FOR IGUAL A 0 ENTÃO, PC <= 65 = 15 + 50
	mem_i(16) <= "0001001000000000"; -- ARMAZENA RF(2) NO DADO(0)
	mem_i(17) <= "0101111101010011"; -- SALTA PARA O FINAL
	mem_i(39) <= "0010101000100011"; -- RF(2) + RF(3) => RF(10)
	mem_i(40) <= "0001101000010000"; -- ARMAZENAR RF(10) EM DADO(16)
	mem_i(41) <= "0000001000010000"; -- CARREGAR EM RF(2) O DADO(16)
	mem_i(42) <= "0101111111100000"; -- SALTAR PARA 42 - 32 = 10
	mem_i(52) <= "0010101000100011"; -- RF(2) + RF(3) => RF(10)
	mem_i(53) <= "0001101000100000"; -- ARMAZENAR RF(10) EM DADO(16)
	mem_i(54) <= "0000001000010000"; -- CARREGAR EM RF(2) O DADO(16)
	mem_i(55) <= "0101111111010110"; -- SALTA PARA 55 - 42 = 13
	mem_i(65) <= "0010101000100011"; -- RF(2) + RF(3) => RF(10)
	mem_i(66) <= "0001101000100000"; -- ARMAZENAR RF(10) EM DADO(16)
	mem_i(67) <= "0000001000010000"; -- CARREGAR EM RF(2) O DADO(16)
	mem_i(68) <= "0101111111001100"; -- SALTA PARA 68 - 52 = 16
	if (rd = '1') then
		data <= mem_i(addr_s);
	end if;
end process;
end behavior_data_i;

-----------------------------------------------------------------------------------
--                         MEMÓRIA DE DADOS (RAM)                                --
-----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity data_d is port(
	clk_d : in std_logic;
	addr : in std_logic_vector(7 downto 0);
	rd : in std_logic;
	wr : in std_logic;
	W_data : in std_logic_vector(15 downto 0);
	R_data : out std_logic_vector(15 downto 0)
);
end data_d;
architecture behavior_data_d of data_d is
type memory_d is array (0 to 255) of std_logic_vector(15 downto 0);
signal mem : memory_d := (0 => "0000000000000101",
								  1 => "0000000000000111",
								  2 => "0000000000001000",
								  3 => "0000000000000001",
								  4 => "0000000000000011",
								  5 => "0000000000000101",
								  6 => "0000000000000110",
								  7 => "0000000000000011",
								  8 => "0000000000001000",
								  9 => "0000000000000001",
								  10 => "0000000000001001",
								  11 => "0000000000000001",
								  12 => "0000000000000010",
								  13 => "0000000000000100",
								  14 => "0000000000000001",
								  15 => "0000000000000011",
								  16 => "0000000000000101",
								  17 => "0000000000000110",
								  18 => "0000000000001001",
								  19 => "0000000000000100",
								  20 => "0000000000000011",
								  others => "0000000000000000");
signal addr_s : integer;
begin
	process (clk_d) begin
		addr_s <= to_integer(unsigned(addr));
		if (rising_edge(clk_d) and wr = '1') then
			mem(addr_s) <= W_data;
		elsif (rising_edge(clk_d) and rd = '1') then
			R_data <= mem(addr_s);
		end if;
	end process;
end behavior_data_d;

-----------------------------------------------------------------------------------
--                            UNIDADE DE CONTROLE                                --
-----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
entity unidade_de_controle is port(
	RF_Rp_zero_uc, clk_uc, rst : in std_logic;
	addr_uc : out std_logic_vector(15 downto 0);
	data_uc : in std_logic_vector(15 downto 0);
	D_rd_uc, D_wr_uc, RF_s0_uc, RF_s1_uc, RF_W_wr_uc, RF_Rp_rd_uc, RF_Rq_rd_uc, alu_s1_uc, alu_s0_uc, I_rd_uc, PC_clr_f, PC_ld_f, PC_up_f : out std_logic;
	D_addr_uc, RF_W_data_uc : out std_logic_vector(7 downto 0);
	RF_W_addr_uc, RF_Rp_addr_uc, RF_Rq_addr_uc, saida_uc, nibble_IR_msb_uc : out std_logic_vector(3 downto 0));
end unidade_de_controle;
architecture behavior_uc of unidade_de_controle is
	component sum port(
		a, b : in std_logic_vector(15 downto 0);
		o : out std_logic_vector(15 downto 0));
	end component sum;
	component ir port(
		IR_in : in std_logic_vector(15 downto 0);
		nibble_IR_msb : out std_logic_vector(3 downto 0);
		IR_out : out std_logic_vector(15 downto 0);
		IR_ld, clk_ir : in std_logic);
	end component ir;
	component PC port(
		PC_ld, PC_clr, PC_up, clk_PC : in std_logic;
		PC_in : in std_logic_vector(15 downto 0);
		PC_out : out std_logic_vector(15 downto 0));
	end component PC;
	component FSM port(
		d : in std_logic_vector(15 downto 0);
		clk_FSM, rst_FSM : in std_logic;
		PC_clr : out std_logic;
		I_rd, PC_inc, IR_ld, RF_s1, RF_s0, RF_W_wr, D_wr, RF_Rp_rd, PC_ld, alu_s0, alu_s1, D_rd, RF_Rq_rd : out std_logic;
		RF_w_addr, RF_Rp_addr, RF_Rq_addr : out std_logic_vector(3 downto 0);
		D_addr, RF_W_data : out std_logic_vector(7 downto 0);
		saida_FSM : out std_logic_vector(3 downto 0);
		RF_Rp_zero : in std_logic);
	end component FSM;
	signal PC_to_addr_uc, PC_to_sum, IR_to_FSM, sum_to_PC, IR_to_sum : std_logic_vector(15 downto 0);
	signal FSM_to_PC_ld, FSM_to_PC_clr, FSM_to_PC_up, FSM_to_IR_ld : std_logic;
	begin
		IR_to_sum <= ("00000000" & IR_to_FSM(7 downto 0));
		addr_uc <= PC_to_addr_uc;
		somador : sum port map(
			a => IR_to_sum,
			b => PC_to_addr_uc,
			o => SUM_to_PC);
		reg_ir : ir port map(
			IR_in => data_uc,
			IR_out => IR_to_FSM,
			nibble_IR_msb => nibble_IR_msb_uc,
			clk_ir => clk_uc,
			IR_ld => FSM_to_IR_ld);
		count_PC : PC port map(
			PC_ld => FSM_to_PC_ld,
			PC_clr => FSM_to_PC_clr,
			PC_up => FSM_to_PC_up,
			PC_in => SUM_to_PC,
			PC_out => PC_to_addr_uc,
			clk_PC => clk_uc);
		FSM_c : FSM port map(
			d => IR_to_FSM,
			clk_FSM => clk_uc,
			rst_FSM => rst,
			PC_clr => FSM_to_PC_clr,
			PC_ld => FSM_to_PC_ld,
			PC_inc => FSM_to_PC_up,
			IR_ld => FSM_to_IR_ld,
			I_rd => I_rd_uc,
			D_addr => D_addr_uc,
			D_rd => D_rd_uc,
			D_wr => D_wr_uc,
			RF_W_data => RF_W_data_uc,
			RF_s1 => RF_s1_uc,
			RF_s0 => RF_s0_uc,
			RF_W_addr => RF_W_addr_uc,
			RF_W_wr => RF_W_wr_uc,
			RF_Rp_addr => RF_Rp_addr_uc,
			RF_Rp_rd => RF_Rp_rd_uc,
			RF_Rq_addr => RF_Rq_addr_uc,
			RF_Rq_rd => RF_Rq_rd_uc,
			RF_Rp_zero => RF_Rp_zero_uc,
			alu_s0 => alu_s0_uc,
			saida_FSM => saida_uc,
			alu_s1 => alu_s1_uc);
			PC_clr_f <= FSM_to_PC_clr;
			PC_ld_f <= FSM_to_PC_ld;
			PC_up_f <= FSM_to_PC_up;
end behavior_uc;		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
-- SOMADOR A + B - 1
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity sum is port(
	a, b : in std_logic_vector(15 downto 0);
	o : out std_logic_vector(15 downto 0)
);
end sum;
architecture behavior_sum of sum is
begin
	o <= a + b - "0000000000000001";
end behavior_sum;

--REGISTRADOR DE INSTRUÇÃO IR
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity ir is port(
	IR_in : in std_logic_vector(15 downto 0);
	IR_out : buffer std_logic_vector(15 downto 0);
	nibble_IR_msb : out std_logic_vector(3 downto 0);
	IR_ld, clk_ir : in std_logic
);
end ir;
architecture behavior_ir of ir is
begin
process (clk_ir, IR_ld) begin
	if (clk_ir'event and clk_ir = '1') then
		if (IR_ld = '1') then
			IR_out <= IR_in;
		end if;
	end if;
	nibble_IR_msb <= IR_out(15 downto 12);
end process;
end behavior_ir;

-- CONTADOR DE INSTRUÇÃO PC
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use Ieee.numeric_std.all;
entity PC is port(
	PC_ld, PC_clr, PC_up, clk_PC : in std_logic;
	PC_in : in std_logic_vector(15 downto 0);
	PC_out : out std_logic_vector(15 downto 0)
);
end PC;
architecture behavior_pc of PC is
signal contador : std_logic_vector(15 downto 0);
begin
	process (clk_PC, PC_ld, PC_clr, PC_up) begin
		if (PC_clr = '1') then
			contador <= "0000000000000000";
		elsif (clk_PC'event and clk_PC = '1') then
			if (PC_up = '1') then
				contador <= contador + "0000000000000001";
			elsif (PC_ld = '1') then
				contador <= PC_in;
			end if;
		end if;
		PC_out <= contador;
	end process;
end behavior_pc;

-- MÁQUINDA DE ESTADOS FINITOS DA PARTE DE CONTROLE
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity FSM is port(
	d : in std_logic_vector(15 downto 0);
	clk_FSM, rst_FSM : in std_logic;
	PC_clr : out std_logic;
	I_rd, PC_inc, IR_ld, RF_s1, RF_s0, RF_W_wr, D_wr, RF_Rp_rd, PC_ld, alu_s0, alu_s1, D_rd, RF_Rq_rd : out std_logic;
	RF_w_addr, RF_Rp_addr, RF_Rq_addr : out std_logic_vector(3 downto 0);
	D_addr, RF_W_data : out std_logic_vector(7 downto 0);
	saida_FSM : out std_logic_vector(3 downto 0);
	RF_Rp_zero : in std_logic
);
end FSM;
architecture behavior of FSM is
	type e is (inicio, carregar, armazenar, somar, carregar_constante, subtrair, saltar_se_zero, saltar, busca, decodificacao);
	signal estado : e;
	signal OP_code : std_logic_vector(3 downto 0);
	begin 
		OP_code <= d(15 downto 12);
		RF_W_data <= d(7 downto 0);
	process(clk_FSM, rst_FSM)
		begin
		if (rst_FSM = '1') then
			estado <= inicio;
		elsif (clk_FSM'event and clk_FSM = '1') then
			case estado is 
				when inicio => 
					PC_clr <= '1';
					PC_ld <= '0';
					PC_inc <= '0';
					I_rd <= '0'; 
					PC_inc <= '0'; 
					IR_ld <= '0';
					RF_s1 <= 'Z';
					RF_s0 <= 'Z';
					RF_W_wr <= '0';
					D_wr <= '0';
					RF_Rp_rd <= '0';
					PC_ld <= '0'; 
					alu_s0 <= 'Z';
					alu_s1 <= 'Z';
					D_rd <= '0';
					RF_Rq_rd <= '0';
					estado <= busca;
				when busca =>
					I_rd <= '1';
					PC_clr <= '0';
					PC_ld <= '0';
					PC_inc <= '1';
					IR_ld <= '1';
					RF_s1 <= 'Z';
					RF_s0 <= 'Z';
					RF_W_wr <= '0';
					D_wr <= '0';
					RF_Rp_rd <= '0';
					alu_s0 <= 'Z';
					alu_s1 <= 'Z';
					D_rd <= '0';
					RF_Rq_rd <= '0';
					estado <= decodificacao;
				when decodificacao =>
					if (OP_code = "0000") then
						PC_inc <= '0';
						PC_clr <= '0';
						PC_ld <= '0';
						estado <= carregar;
					elsif (OP_code = "0001") then
						PC_inc <= '0';
						PC_clr <= '0';
						PC_ld <= '0';
						estado <= armazenar;
					elsif (OP_code = "0010") then
						PC_inc <= '0';
						PC_clr <= '0';
						PC_ld <= '0';
						estado <= somar;
					elsif (OP_code = "0011") then
						PC_inc <= '0';
						PC_clr <= '0';
						PC_ld <= '0';
						estado <= carregar_constante;
					elsif (OP_code = "0100") then
						PC_inc <= '0';
						PC_clr <= '0';
						PC_ld <= '0';
						estado <= subtrair;
					elsif (OP_code = "0101") then
						PC_inc <= '0';
						PC_clr <= '0';
						PC_ld <= '0';
						estado <= saltar_se_zero;
					end if;
				when carregar =>
						D_addr <= d(7 downto 0);
						D_rd <= '1';
						RF_s1 <= '0';
						RF_s0 <= '1';
						RF_W_addr <= d(11 downto 8);
						RF_W_wr <= '1';
						PC_inc <= '0';
						PC_clr <= '0';
						PC_ld <= '0';
						I_rd <= '0'; 
						IR_ld <= '0';
						D_wr <= '0';
						RF_Rp_rd <= '0';
						alu_s0 <= 'Z';
						alu_s1 <= 'Z';
						RF_Rq_rd <= '0';
					estado <= busca;
				when armazenar =>
						D_addr <= d(7 downto 0);
						D_wr <= '1';
						RF_s1 <= 'Z';
						RF_s0 <= 'Z';
						RF_Rp_addr <= d(11 downto 8);
						RF_rp_rd <= '1';
						PC_inc <= '0';
						PC_clr <= '0';
						PC_ld <= '0';
						I_rd <= '0';  
						IR_ld <= '0';
						RF_W_wr <= '0';
						alu_s0 <= 'Z';
						alu_s1 <= 'Z';
						D_rd <= '0';
						RF_Rq_rd <= '0';
					estado <= busca;
				when somar =>
						RF_Rp_addr <= d(7 downto 4);
						RF_Rp_rd <= '1';
						RF_s1 <= '0';
						RF_s0 <= '0';
						RF_Rq_addr <= d(3 downto 0);
						RF_Rq_rd <= '1';
						RF_W_addr <= d(11 downto 8);
						RF_W_wr <= '1';
						alu_s1 <= '0';
						alu_s0 <= '1';
						PC_inc <= '0';
						PC_clr <= '0';
						PC_ld <= '0';
						I_rd <= '0'; 
						IR_ld <= '0';
						D_wr <= '0';
						D_rd <= '0';
					estado <= busca;
				when (carregar_constante) =>
						RF_s1 <= '1';
						RF_s0 <= '0';
						RF_W_addr <= d(11 downto 8);
						RF_W_wr <= '1';
						PC_inc <= '0';
						PC_clr <= '0';
						PC_ld <= '0';
						I_rd <= '0'; 
						IR_ld <= '0';
						D_wr <= '0';
						RF_Rp_rd <= '0';
						alu_s0 <= 'Z';
						alu_s1 <= 'Z';
						D_rd <= '0';
						RF_Rq_rd <= '0';
					estado <= busca;
				when subtrair =>
						RF_Rp_addr <= d(7 downto 4);
						RF_Rp_rd <= '1';
						RF_s1 <= '0';
						RF_s0 <= '0';
						RF_Rq_addr <= d(3 downto 0);
						RF_Rq_rd <= '1';
						RF_W_addr <= d(11 downto 8);
						RF_W_wr <= '1';
						alu_s1 <= '1';
						alu_s0 <= '0';
						PC_inc <= '0';
						PC_clr <= '0';
						PC_ld <= '0';
						IR_ld <= '0';
						I_rd <= '0';
					estado <= busca;
				when saltar_se_zero =>
						RF_Rp_addr <= d(11 downto 8);
						RF_Rp_rd <= '1';
						PC_inc <= '0';
						PC_clr <= '0';
						PC_ld <= '0';
						I_rd <= '0'; 
						IR_ld <= '0';
						RF_s1 <= 'Z';
						RF_s0 <= 'Z';
						RF_W_wr <= '0';
						D_wr <= '0';
						alu_s0 <= 'Z';
						alu_s1 <= 'Z';
						D_rd <= '0';
						RF_Rq_rd <= '0';
					if (RF_Rp_zero = '0') then
						estado <= busca;
					else
						estado <= saltar;
					end if;
				when saltar =>
					PC_clr <= '0';
					PC_ld <= '1';
					PC_inc <= '0';
					I_rd <= '0';  
					IR_ld <= '0';
					RF_s1 <= 'Z';
					RF_s0 <= 'Z';
					RF_W_wr <= '0';
					D_wr <= '0';
					RF_Rp_rd <= '0';
					alu_s0 <= 'Z';
					alu_s1 <= 'Z';
					D_rd <= '0';
					RF_Rq_rd <= '0';
					estado <= busca;
				end case;
			end if;
		end process;
		with estado select
		saida_FSM <= "0000" when carregar,
					"0001" when armazenar,
					"0010" when somar,
					"0011" when carregar_constante,
					"0100" when subtrair,
					"0101" when saltar_se_zero,
					"0110" when saltar,
					"1101" when decodificacao,
					"1110" when busca,
					"1111" when inicio;
end behavior;

-----------------------------------------------------------------------------------
--                            BLOCO OPERACIONAL                                  --
-----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity bloco_operacional is port(
	R_data_op : in std_logic_vector(15 downto 0);
	W_data_op : out std_logic_vector(15 downto 0);
	RF_W_data_op : in std_logic_vector(7 downto 0);
	RF_W_addr_op, RF_Rp_addr_op, RF_Rq_addr_op : in std_logic_vector(3 downto 0);
	RF_s1_op, RF_s0_op, RF_W_wr_op, RF_Rp_rd_op, RF_Rq_rd_op, alu_s0_op, alu_s1_op, clk_op : in std_logic;
	RF_Rp_zero_op : out std_logic);
end bloco_operacional;
architecture behavior_bloco_operacional of bloco_operacional is
component mux port(
	m2 : in std_logic_vector(7 downto 0);
	m1, m0 : in std_logic_vector(15 downto 0);
	mo : out std_logic_vector(15 downto 0);
	s0 : in std_logic;
	s1 : in std_logic
);
end component mux;
component data_op port(
	clk_RF : in std_logic;
	W_data : in std_logic_vector(15 downto 0);
	W_addr : in std_logic_vector(3 downto 0);
	W_wr : in std_logic;
	Rp_addr : in std_logic_vector(3 downto 0);
	Rp_rd : in std_logic;
	Rq_addr : in std_logic_vector(3 downto 0);
	Rq_rd : in std_logic;
	Rp_data : out std_logic_vector(15 downto 0);
	Rq_data : out std_logic_vector(15 downto 0));
end component data_op;
component ULA port(
	A, B : in std_logic_vector(15 downto 0);
	O : out std_logic_vector(15 downto 0);
	alu_s : in std_logic_vector(1 downto 0));
end component ULA;
component RF_Rp is port (
	a : in std_logic_vector(15 downto 0);
	o : out std_logic);
end component RF_Rp;
signal Rp_to_alu, Rq_to_alu, alu_to_mux0, Rp_to_W_data, Rp_to_Nor, mux_to_W_data : std_logic_vector(15 downto 0);
begin
	Rp_to_W_data <= Rp_to_alu;
	Rp_to_Nor <= Rp_to_alu;
	W_data_op <= Rp_to_W_data;
	m : mux port map(
		m2 => RF_W_data_op,
		m1 => R_data_op,
		m0 => alu_to_mux0,
		mo => mux_to_W_data,
		s0 => RF_s0_op,
		s1 => RF_s1_op
	);
	RF : data_op port map(
		clk_RF => clk_op,
		w_data => mux_to_W_data,
		W_addr => RF_W_addr_op,
		W_wr => RF_W_wr_op,
		Rp_addr => RF_Rp_addr_op,
		Rp_rd => RF_Rp_rd_op,
		Rq_addr => RF_Rq_addr_op,
		Rq_rd => RF_Rq_rd_op,
		Rp_data => Rp_to_alu,
		Rq_data => Rq_to_alu
	);
	OP : ULA port map(
		A => RP_to_alu,
		B => Rq_to_alu,
		O => alu_to_mux0,
		alu_s(0) => alu_s0_op,
		alu_s(1) => alu_s1_op
	);
	Porta_nor : RF_Rp port map(
		a => Rp_to_Nor,
		o => RF_Rp_zero_op
	);
end behavior_bloco_operacional;



-- MUX 3X1 DO BLOCO OPERACIONAL COM 16 BITS DE LARGURA
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity mux is port(
	m2 : in std_logic_vector(7 downto 0);
	m1, m0 : in std_logic_vector(15 downto 0);
	mo : out std_logic_vector(15 downto 0);
	s0 : in std_logic;
	s1 : in std_logic
);
end mux;
architecture behavior_mux of mux is
begin
	process (s0, s1) begin
	if (s1 = '0' and s0 ='0') then
		mo <= m0;
	elsif (s1 = '0' and s0 ='1') then
		mo <= m1;
	elsif (s1 = '1' and s0 ='0') then
		mo <= ("00000000") & (m2);
	end if;
	end process;
end behavior_mux;

-- MEMÓRIA DO BLOCO OPERACIONAL RF
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity data_op is port(
	clk_RF : in std_logic;
	W_data : in std_logic_vector(15 downto 0);
	W_addr : in std_logic_vector(3 downto 0);
	W_wr : in std_logic;
	Rp_addr : in std_logic_vector(3 downto 0);
	Rp_rd : in std_logic;
	Rq_addr : in std_logic_vector(3 downto 0);
	Rq_rd : in std_logic;
	Rp_data : out std_logic_vector(15 downto 0);
	Rq_data : out std_logic_vector(15 downto 0));
end data_op;
architecture behavior_data_op of data_op is
	type data_reg is array (0 to 15) of std_logic_vector(15 downto 0);
	signal reg : data_reg;
	signal addr_w : integer;
	signal addr_Rp : integer;
	signal addr_Rq : integer;
	begin
		process (clk_RF) begin
			addr_w <= to_integer(unsigned(W_addr));
			addr_Rp <= to_integer(unsigned(Rp_addr));
			addr_Rq <= to_integer(unsigned(Rq_addr));
			if (rising_edge(clk_RF) and Rq_rd = '1') then
				Rq_data <= reg(addr_Rq);
			elsif (rising_edge(clk_RF) and Rp_rd = '1') then
				Rp_data <= reg(addr_Rq);
			elsif (rising_edge(clk_RF) and W_wr = '1') then
				reg(addr_w) <= W_data;
			end if;
		end process;
end behavior_data_op;

-- ALU DO BLOCO OPERACIONAL
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity ULA is port(
	A, B : in std_logic_vector(15 downto 0);
	O : out std_logic_vector(15 downto 0);
	alu_s : in std_logic_vector(1 downto 0));
end ULA;
architecture Behavior of ULA is
	begin
	process(alu_s)
		begin
		case alu_s is
			when "00" =>
				O <= A;
			when "01" =>
				O <= A + B;
			When "10" =>
				O <= A - B;
			when others =>
				O <= "ZZZZZZZZZZZZZZZZ";
		end case;
	end process;
end Behavior;

-- PORTA NOR PARA O SINAL RF_Rp_zero_op
library ieee;
use ieee.std_logic_1164.all;
entity RF_Rp is port (
	a : in std_logic_vector(15 downto 0);
	o : out std_logic);
end RF_Rp;
architecture behavior_RF_Rp of RF_Rp is
begin
	O <= not(a(15) or a(14) or a(13) or a(12) or a(11) or a(10) or a(9) or a(8) or a(7) or a(6) or a(5) or a(4) or a(3) or a(2) or a(1) or a(0));
end behavior_RF_Rp;