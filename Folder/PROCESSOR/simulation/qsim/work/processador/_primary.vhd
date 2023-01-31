library verilog;
use verilog.vl_types.all;
entity processador is
    port(
        clk             : in     vl_logic;
        rst_principal   : in     vl_logic;
        nibble_IR_msb_out: out    vl_logic_vector(3 downto 0);
        addr_z          : out    vl_logic_vector(15 downto 0);
        W_data_z        : out    vl_logic_vector(15 downto 0);
        R_data_z        : out    vl_logic_vector(15 downto 0);
        data_I_z        : out    vl_logic_vector(15 downto 0);
        D_addr_z        : out    vl_logic_vector(7 downto 0);
        RF_W_data_z     : out    vl_logic_vector(7 downto 0);
        saida_p         : out    vl_logic_vector(3 downto 0);
        RF_W_addr_z     : out    vl_logic_vector(3 downto 0);
        RF_Rp_addr_z    : out    vl_logic_vector(3 downto 0);
        RF_Rq_addr_z    : out    vl_logic_vector(3 downto 0);
        PC_up_z         : out    vl_logic;
        PC_clr_z        : out    vl_logic;
        PC_ld_z         : out    vl_logic;
        D_rd_z          : out    vl_logic;
        D_wr_z          : out    vl_logic;
        I_rd_z          : out    vl_logic;
        RF_s1_z         : out    vl_logic;
        RF_s0_z         : out    vl_logic;
        RF_W_wr_z       : out    vl_logic;
        RF_Rp_rd_z      : out    vl_logic;
        RF_Rq_rd_z      : out    vl_logic;
        RF_Rp_zero_z    : out    vl_logic;
        alu_s0_z        : out    vl_logic;
        alu_s1_z        : out    vl_logic
    );
end processador;
