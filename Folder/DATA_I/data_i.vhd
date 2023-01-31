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
type memory_i is array (0 to 65535) of std_logic_vector(15 downto 0);
signal mem_i : memory_i; 
signal addr_s : integer;
begin
addr_s <= to_integer(unsigned(addr));
process (rd) begin
	mem_i(0) <= "0000000000000011";
	mem_i(1) <= "0001000000000111";
	if (rd = '1') then
		data <= mem_i(addr_s);
	end if;
end process;
end behavior_data_i;