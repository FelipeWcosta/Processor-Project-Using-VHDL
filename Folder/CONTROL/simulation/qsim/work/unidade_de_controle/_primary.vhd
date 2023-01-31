library verilog;
use verilog.vl_types.all;
entity unidade_de_controle is
    port(
        RF_Rp_zero_uc   : in     vl_logic;
        clk_uc          : in     vl_logic;
        rst             : in     vl_logic;
        addr_uc         : out    vl_logic_vector(15 downto 0);
        data_uc         : in     vl_logic_vector(15 downto 0);
        D_rd_uc         : out    vl_logic;
        D_wr_uc         : out    vl_logic;
        RF_s0_uc        : out    vl_logic;
        RF_s1_uc        : out    vl_logic;
        RF_W_wr_uc      : out    vl_logic;
        RF_Rp_rd_uc     : out    vl_logic;
        RF_Rq_rd_uc     : out    vl_logic;
        alu_s1_uc       : out    vl_logic;
        alu_s0_uc       : out    vl_logic;
        I_rd_uc         : out    vl_logic;
        D_addr_uc       : out    vl_logic_vector(7 downto 0);
        RF_W_data_uc    : out    vl_logic_vector(7 downto 0);
        RF_W_addr_uc    : out    vl_logic_vector(3 downto 0);
        RF_Rp_addr_uc   : out    vl_logic_vector(3 downto 0);
        RF_Rq_addr_uc   : out    vl_logic_vector(3 downto 0);
        saida_uc        : out    vl_logic_vector(3 downto 0)
    );
end unidade_de_controle;
