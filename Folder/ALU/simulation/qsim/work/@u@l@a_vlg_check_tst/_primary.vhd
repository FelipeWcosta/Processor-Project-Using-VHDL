library verilog;
use verilog.vl_types.all;
entity ULA_vlg_check_tst is
    port(
        O               : in     vl_logic_vector(15 downto 0);
        RF_Rp_zero      : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end ULA_vlg_check_tst;
