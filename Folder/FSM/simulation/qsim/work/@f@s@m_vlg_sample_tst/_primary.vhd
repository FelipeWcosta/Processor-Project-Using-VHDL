library verilog;
use verilog.vl_types.all;
entity FSM_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        d               : in     vl_logic_vector(15 downto 0);
        RF_Rp_zero      : in     vl_logic;
        rst             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end FSM_vlg_sample_tst;
