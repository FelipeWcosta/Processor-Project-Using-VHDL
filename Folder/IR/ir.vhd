library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity ir is port(
	IR_in : in std_logic_vector(15 downto 0);
	IR_out : out std_logic_vector(15 downto 0);
	IR_ld, clk : in std_logic
);
end ir;
architecture behavior_ir of ir is
begin
process (clk, IR_ld) begin
	if (clk'event and clk = '1') then
		if (IR_ld = '1') then
			IR_out <= IR_in;
		end if;
	end if;
end process;
end behavior_ir;
