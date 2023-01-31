library verilog;
use verilog.vl_types.all;
entity ULA is
    port(
        A               : in     vl_logic_vector(15 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        O               : out    vl_logic_vector(15 downto 0);
        RF_Rp_zero      : out    vl_logic;
        alu_s           : in     vl_logic_vector(1 downto 0)
    );
end ULA;
