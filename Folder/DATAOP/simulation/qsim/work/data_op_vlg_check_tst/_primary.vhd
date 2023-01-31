library verilog;
use verilog.vl_types.all;
entity data_op_vlg_check_tst is
    port(
        Rp_data         : in     vl_logic_vector(15 downto 0);
        Rq_data         : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end data_op_vlg_check_tst;
