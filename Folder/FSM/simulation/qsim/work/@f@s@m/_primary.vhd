library verilog;
use verilog.vl_types.all;
entity FSM is
    port(
        d               : in     vl_logic_vector(15 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        PC_clr          : out    vl_logic;
        I_rd            : out    vl_logic;
        PC_inc          : out    vl_logic;
        IR_ld           : out    vl_logic;
        RF_s1           : out    vl_logic;
        RF_s0           : out    vl_logic;
        RF_W_wr         : out    vl_logic;
        D_wr            : out    vl_logic;
        RF_Rp_rd        : out    vl_logic;
        PC_ld           : out    vl_logic;
        alu_s0          : out    vl_logic;
        alu_s1          : out    vl_logic;
        D_rd            : out    vl_logic;
        RF_Rq_rd        : out    vl_logic;
        RF_w_addr       : out    vl_logic_vector(3 downto 0);
        RF_Rp_addr      : out    vl_logic_vector(3 downto 0);
        RF_Rq_addr      : out    vl_logic_vector(3 downto 0);
        D_addr          : out    vl_logic_vector(7 downto 0);
        saida           : out    vl_logic_vector(3 downto 0);
        RF_Rp_zero      : in     vl_logic
    );
end FSM;
