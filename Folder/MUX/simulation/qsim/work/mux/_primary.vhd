library verilog;
use verilog.vl_types.all;
entity mux is
    port(
        m2              : in     vl_logic_vector(15 downto 0);
        m1              : in     vl_logic_vector(15 downto 0);
        m0              : in     vl_logic_vector(15 downto 0);
        mo              : out    vl_logic_vector(15 downto 0);
        s               : in     vl_logic_vector(1 downto 0)
    );
end mux;
