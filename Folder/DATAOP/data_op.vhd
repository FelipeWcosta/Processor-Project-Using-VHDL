library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity data_op is port(
	clk : in std_logic;
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
		process (clk) begin
			addr_w <= to_integer(unsigned(W_addr));
			addr_Rp <= to_integer(unsigned(Rp_addr));
			addr_Rq <= to_integer(unsigned(Rq_addr));
			if (rising_edge(clk) and Rq_rd = '1') then
				Rq_data <= reg(addr_Rq);
			elsif (rising_edge(clk) and Rp_rd = '1') then
				Rp_data <= reg(addr_Rq);
			elsif (rising_edge(clk) and W_wr = '1') then
				reg(addr_w) <= W_data;
			end if;
		end process;
end behavior_data_op;	