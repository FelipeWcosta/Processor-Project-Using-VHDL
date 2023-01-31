library verilog;
use verilog.vl_types.all;
entity data_i_vlg_sample_tst is
    port(
        addr            : in     vl_logic_vector(15 downto 0);
        rd              : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end data_i_vlg_sample_tst;
