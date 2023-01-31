library verilog;
use verilog.vl_types.all;
entity sum_vlg_check_tst is
    port(
        o               : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end sum_vlg_check_tst;
