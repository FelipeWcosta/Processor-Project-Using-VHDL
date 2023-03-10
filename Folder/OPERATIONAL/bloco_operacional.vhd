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

-- MEM??RIA DO BLOCO OPERACIONAL RF
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