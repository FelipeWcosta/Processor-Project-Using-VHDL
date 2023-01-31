library verilog;
use verilog.vl_types.all;
entity mux_vlg_check_tst is
    port(
        mo              : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end mux_vlg_check_tst;
