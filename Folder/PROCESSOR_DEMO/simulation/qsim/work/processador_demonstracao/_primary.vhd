library verilog;
use verilog.vl_types.all;
entity processador_demonstracao is
    port(
        clk_1           : in     vl_logic;
        rst_principal   : in     vl_logic;
        nibble_IR_msb_out: out    vl_logic_vector(3 downto 0)
    );
end processador_demonstracao;
