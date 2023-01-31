library verilog;
use verilog.vl_types.all;
entity ULA_vlg_sample_tst is
    port(
        A               : in     vl_logic_vector(15 downto 0);
        alu_s           : in     vl_logic_vector(1 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        sampler_tx      : out    vl_logic
    );
end ULA_vlg_sample_tst;
