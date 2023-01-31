library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity PC is port(
	PC_ld, PC_clr, PC_up, clk : in std_logic;
	PC_in : in std_logic_vector(15 downto 0);
	PC_out : inout std_logic_vector(15 downto 0)
);
end PC;
architecture behavior_pc of PC is
signal contador : std_logic_vector(15 downto 0);
begin
	process (clk, PC_ld, PC_clr, PC_up) begin
		if (PC_clr = '1') then
			contador <= "0000000000000000";
		elsif (clk'event and clk = '1') then
			if (PC_up = '1') then
				contador <= contador + "000000000000001";
			elsif (PC_ld = '1') then
				contador <= PC_in;
			end if;
		end if;
		PC_out <= contador;
	end process;
end behavior_pc;