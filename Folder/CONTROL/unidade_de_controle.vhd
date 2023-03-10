library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
entity unidade_de_controle is port(
	RF_Rp_zero_uc, clk_uc, rst : in std_logic;
	addr_uc : out std_logic_vector(15 downto 0);
	data_uc : in std_logic_vector(15 downto 0);
	D_rd_uc, D_wr_uc, RF_s0_uc, RF_s1_uc, RF_W_wr_uc, RF_Rp_rd_uc, RF_Rq_rd_uc, alu_s1_uc, alu_s0_uc, I_rd_uc : out std_logic;
	D_addr_uc, RF_W_data_uc : out std_logic_vector(7 downto 0);
	RF_W_addr_uc, RF_Rp_addr_uc, RF_Rq_addr_uc, saida_uc : out std_logic_vector(3 downto 0));
end unidade_de_controle;
architecture behavior_uc of unidade_de_controle is
	component sum port(
		a, b : in std_logic_vector(15 downto 0);
		o : out std_logic_vector(15 downto 0));
	end component sum;
	component ir port(
		IR_in : in std_logic_vector(15 downto 0);
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

--REGISTRADOR DE INSTRU????O IR
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity ir is port(
	IR_in : in std_logic_vector(15 downto 0);
	IR_out : out std_logic_vector(15 downto 0);
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
end process;
end behavior_ir;

-- CONTADOR DE INSTRU????O PC
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;
entity PC is port(
	PC_ld, PC_clr, PC_up, clk_PC : in std_logic;
	PC_in : in std_logic_vector(15 downto 0);
	PC_out : buffer std_logic_vector(15 downto 0)
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
				contador <= contador + 1;
			elsif (PC_ld = '1') then
				contador <= PC_in;
			end if;
		end if;
		PC_out <= contador;
	end process;
end behavior_pc;

-- M??QUINDA DE ESTADOS FINITOS DA PARTE DE CONTROLE
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
	--OP_code: in std_logic_vector(3 downto 0);
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
					estado <= busca;
				when busca =>
					I_rd <= '1';
					PC_clr <= '0';
					PC_ld <= '0';
					PC_inc <= '1';
					IR_ld <= '1';
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
					estado <= busca;
				when (carregar_constante) =>
						RF_s1 <= '1';
						RF_s0 <= '0';
						RF_W_addr <= d(11 downto 8);
						RF_W_wr <= '1';
						PC_inc <= '0';
						PC_clr <= '0';
						PC_ld <= '0';
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
					estado <= busca;
				when saltar_se_zero =>
					RF_Rp_addr <= d(11 downto 8);
					RF_Rp_rd <= '1';
					PC_inc <= '0';
					PC_clr <= '0';
					PC_ld <= '0';
					if (RF_Rp_zero = '0') then
						estado <= busca;
					else
						estado <= saltar;
					end if;
				when saltar =>
					PC_clr <= '0';
					PC_ld <= '1';
					PC_inc <= '0';
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