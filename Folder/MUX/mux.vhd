library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity mux is port(
	m2 : in std_logic_vector(7 downto 0);
	m1, m0 : in std_logic_vector(15 downto 0);
	mo : out std_logic_vector(15 downto 0);
	s : in std_logic_vector(1 downto 0)
);
end mux;
architecture behavior_mux of mux is
begin
	process (s) begin
	if (s = "00") then
		mo <= m0;
	elsif (s = "01") then
		mo <= m1;
	elsif (s = "10") then
		mo <= ("00000000") & (m2);
	end if;
	end process;
end behavior_mux;