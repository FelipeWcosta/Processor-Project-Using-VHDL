library verilog;
use verilog.vl_types.all;
entity unidade_de_controle_vlg_sample_tst is
    port(
        clk_uc          : in     vl_logic;
        data_uc         : in     vl_logic_vector(15 downto 0);
        RF_Rp_zero_uc   : in     vl_logic;
        rst             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end unidade_de_controle_vlg_sample_tst;
