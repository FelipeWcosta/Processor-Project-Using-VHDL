library verilog;
use verilog.vl_types.all;
entity ir is
    port(
        IR_in           : in     vl_logic_vector(15 downto 0);
        IR_out          : out    vl_logic_vector(15 downto 0);
        IR_ld           : in     vl_logic;
        clk             : in     vl_logic
    );
end ir;
