library verilog;
use verilog.vl_types.all;
entity processador_demonstracao_vlg_sample_tst is
    port(
        clk_1           : in     vl_logic;
        rst_principal   : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end processador_demonstracao_vlg_sample_tst;
