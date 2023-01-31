library verilog;
use verilog.vl_types.all;
entity mux_vlg_sample_tst is
    port(
        m0              : in     vl_logic_vector(15 downto 0);
        m1              : in     vl_logic_vector(15 downto 0);
        m2              : in     vl_logic_vector(15 downto 0);
        s               : in     vl_logic_vector(1 downto 0);
        sampler_tx      : out    vl_logic
    );
end mux_vlg_sample_tst;
