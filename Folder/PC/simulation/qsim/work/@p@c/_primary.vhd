library verilog;
use verilog.vl_types.all;
entity PC is
    port(
        PC_ld           : in     vl_logic;
        PC_clr          : in     vl_logic;
        PC_up           : in     vl_logic;
        clk             : in     vl_logic;
        PC_in           : in     vl_logic_vector(15 downto 0);
        PC_out          : inout  vl_logic_vector(15 downto 0)
    );
end PC;
