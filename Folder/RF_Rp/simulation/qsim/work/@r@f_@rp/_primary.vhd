library verilog;
use verilog.vl_types.all;
entity RF_Rp is
    port(
        a               : in     vl_logic_vector(15 downto 0);
        o               : out    vl_logic
    );
end RF_Rp;
