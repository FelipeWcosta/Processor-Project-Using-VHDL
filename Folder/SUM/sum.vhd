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