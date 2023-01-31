library verilog;
use verilog.vl_types.all;
entity PC_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        PC_clr          : in     vl_logic;
        PC_in           : in     vl_logic_vector(15 downto 0);
        PC_ld           : in     vl_logic;
        PC_out          : in     vl_logic_vector(15 downto 0);
        PC_up           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end PC_vlg_sample_tst;
