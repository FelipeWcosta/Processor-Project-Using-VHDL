library verilog;
use verilog.vl_types.all;
entity FSM_vlg_check_tst is
    port(
        alu_s0          : in     vl_logic;
        alu_s1          : in     vl_logic;
        D_addr          : in     vl_logic_vector(7 downto 0);
        D_rd            : in     vl_logic;
        D_wr            : in     vl_logic;
        I_rd            : in     vl_logic;
        IR_ld           : in     vl_logic;
        PC_clr          : in     vl_logic;
        PC_inc          : in     vl_logic;
        PC_ld           : in     vl_logic;
        RF_Rp_addr      : in     vl_logic_vector(3 downto 0);
        RF_Rp_rd        : in     vl_logic;
        RF_Rq_addr      : in     vl_logic_vector(3 downto 0);
        RF_Rq_rd        : in     vl_logic;
        RF_s0           : in     vl_logic;
        RF_s1           : in     vl_logic;
        RF_w_addr       : in     vl_logic_vector(3 downto 0);
        RF_W_wr         : in     vl_logic;
        saida           : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end FSM_vlg_check_tst;
