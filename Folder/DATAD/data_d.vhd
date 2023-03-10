library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity data_d is port(
	clk : in std_logic;
	addr : in std_logic_vector(7 downto 0);
	rd : in std_logic;
	wr : in std_logic;
	W_data : in std_logic_vector(15 downto 0);
	R_data : out std_logic_vector(15 downto 0)
);
end data_d;
architecture behavior_data_d of data_d is
type memory_d is array (0 to 255) of std_logic_vector(15 downto 0);
signal mem : memory_d;
signal addr_s : integer;
begin
	process (clk) begin
		addr_s <= to_integer(unsigned(addr));
		if (rising_edge(clk) and wr = '1') then
			mem(addr_s) <= W_data;
		elsif (rising_edge(clk) and rd = '1') then
			R_data <= mem(addr_s);
		end if;
	end process;
end behavior_data_d;