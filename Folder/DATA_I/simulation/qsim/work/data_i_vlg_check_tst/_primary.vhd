library verilog;
use verilog.vl_types.all;
entity data_i_vlg_check_tst is
    port(
        data            : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end data_i_vlg_check_tst;
