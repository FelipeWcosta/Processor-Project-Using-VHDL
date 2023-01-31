library verilog;
use verilog.vl_types.all;
entity ir_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        IR_in           : in     vl_logic_vector(15 downto 0);
        IR_ld           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end ir_vlg_sample_tst;
