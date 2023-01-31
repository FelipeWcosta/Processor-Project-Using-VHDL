library verilog;
use verilog.vl_types.all;
entity processador_demonstracao_vlg_check_tst is
    port(
        nibble_IR_msb_out: in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end processador_demonstracao_vlg_check_tst;
