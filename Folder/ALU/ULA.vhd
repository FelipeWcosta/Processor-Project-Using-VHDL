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