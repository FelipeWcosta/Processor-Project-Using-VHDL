library verilog;
use verilog.vl_types.all;
entity unidade_de_controle_vlg_check_tst is
    port(
        addr_uc         : in     vl_logic_vector(15 downto 0);
        alu_s0_uc       : in     vl_logic;
        alu_s1_uc       : in     vl_logic;
        D_addr_uc       : in     vl_logic_vector(7 downto 0);
        D_rd_uc         : in     vl_logic;
        D_wr_uc         : in     vl_logic;
        I_rd_uc         : in     vl_logic;
        RF_Rp_addr_uc   : in     vl_logic_vector(3 downto 0);
        RF_Rp_rd_uc     : in     vl_logic;
        RF_Rq_addr_uc   : in     vl_logic_vector(3 downto 0);
        RF_Rq_rd_uc     : in     vl_logic;
        RF_s0_uc        : in     vl_logic;
        RF_s1_uc        : in     vl_logic;
        RF_W_addr_uc    : in     vl_logic_vector(3 downto 0);
        RF_W_data_uc    : in     vl_logic_vector(7 downto 0);
        RF_W_wr_uc      : in     vl_logic;
        saida_uc        : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end unidade_de_controle_vlg_check_tst;
