-- Codificação das saídas
--0000 => carregar
--0001 => armazenar
--0010 => somar
--0011 => carregar_constante
--0100 => subtrair
--0101 => saltar_se_zero
--0110 => saltar
--0111
--1000
--1001
--1010
--1011
--1100
--1101 => decodificacao
--1110 => busca
--1111 => inicio
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