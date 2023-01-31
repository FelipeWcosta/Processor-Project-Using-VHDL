library verilog;
use verilog.vl_types.all;
entity data_i is
    port(
        data            : out    vl_logic_vector(15 downto 0);
        rd              : in     vl_logic;
        addr            : in     vl_logic_vector(15 downto 0)
    );
end data_i;
