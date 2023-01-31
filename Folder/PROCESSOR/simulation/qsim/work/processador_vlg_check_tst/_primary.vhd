library verilog;
use verilog.vl_types.all;
entity processador_vlg_check_tst is
    port(
        addr_z          : in     vl_logic_vector(15 downto 0);
        alu_s0_z        : in     vl_logic;
        alu_s1_z        : in     vl_logic;
        D_addr_z        : in     vl_logic_vector(7 downto 0);
        D_rd_z          : in     vl_logic;
        D_wr_z          : in     vl_logic;
        data_I_z        : in     vl_logic_vector(15 downto 0);
        I_rd_z          : in     vl_logic;
        nibble_IR_msb_out: in     vl_logic_vector(3 downto 0);
        PC_clr_z        : in     vl_logic;
        PC_ld_z         : in     vl_logic;
        PC_up_z         : in     vl_logic;
        R_data_z        : in     vl_logic_vector(15 downto 0);
        RF_Rp_addr_z    : in     vl_logic_vector(3 downto 0);
        RF_Rp_rd_z      : in     vl_logic;
        RF_Rp_zero_z    : in     vl_logic;
        RF_Rq_addr_z    : in     vl_logic_vector(3 downto 0);
        RF_Rq_rd_z      : in     vl_logic;
        RF_s0_z         : in     vl_logic;
        RF_s1_z         : in     vl_logic;
        RF_W_addr_z     : in     vl_logic_vector(3 downto 0);
        RF_W_data_z     : in     vl_logic_vector(7 downto 0);
        RF_W_wr_z       : in     vl_logic;
        saida_p         : in     vl_logic_vector(3 downto 0);
        W_data_z        : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end processador_vlg_check_tst;
