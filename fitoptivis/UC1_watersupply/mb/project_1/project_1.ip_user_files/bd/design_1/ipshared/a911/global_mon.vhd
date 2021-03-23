library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.common_pack.all;
use work.config.all;

entity global_mon is
	generic (

		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= axi_data_width;
		C_S00_AXI_ADDR_WIDTH	: integer	:= axi_addr_width
	);
	port (

		-- Ports of Axi4lite Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic;
		
		-- ports to monitor the trace port of microblaze
        uclk: in std_logic;
        utrace_valid_instr: in std_logic;
        utrace_PC: in std_logic_vector (31 downto 0);
        utrace_opcode: in std_logic_vector (31 downto 0);
        utrace_PID_reg: in std_logic_vector (7 downto 0);
        utrace_jump_taken: in std_logic;
        utrace_icachehit: in std_logic;
        utrace_dcachehit: in std_logic;
        utrace_icachereq: in std_logic;
        utrace_dcachereq: in std_logic;
        
        -- ports to monitor the axifull bus
 		write_ready : in std_logic;
        write_valid : in std_logic;
        awrite_addr: in std_logic_vector (31 downto 0);
        awrite_valid: in std_logic;
        awrite_ready: in std_logic;
        awrite_burst: in std_logic_vector (1 downto 0);
        write_strb: in std_logic_vector (3 downto 0);
        bwrite_valid: in std_logic;
        bwrite_ready: in std_logic;
        bwrite_resp: in std_logic_vector (1 downto 0);
        write_last: in std_logic;
        awrite_len: in std_logic_vector(7 downto 0);
               
                -- interface with bram
                addr_ram: out std_logic_vector (13 downto 0);
        din_ram: out std_logic_vector (31 downto 0);
        wea_ram: out std_logic_vector (3 downto 0);
        rsta_ram: out std_logic;
        ena_ram: out std_logic
	); 
end global_mon;
    
architecture arch_imp of global_mon is

    signal sig_init1_lmic1: std_logic_vector (31 downto 0);
    signal sig_control_lmic1: std_logic_vector (31 downto 0);
    signal sig_rst_asynch: std_logic;
    signal sig_s00_axi_awready: std_logic;
    signal sig_run_monitor: std_logic;
    signal sig_rst_synch: std_logic;
    signal sig_init1: std_logic_vector(31 downto 0);
    signal sig_prog1: std_logic_vector(1 downto 0);
    signal sig_prog2: std_logic_vector(1 downto 0);
    signal sig_init_good: std_logic;
    signal sig_result_lmic1: std_logic_vector(size1_dci-1 downto 0);
    signal sig_result_sniff1: std_logic_vector(68 downto 0);
    signal sig_result_sniff2: std_logic_vector(68 downto 0) := (others => '0');
    signal sig_sel1: std_logic;
    signal sig_s00_axi_wready: std_logic;
    signal sig_s00_axi_bresp: std_logic_vector (1 downto 0);
    signal sig_s00_axi_bvalid: std_logic;
    
    signal sig_sel1_rx: std_logic;
    signal sig_sel2_rx: std_logic;
    signal sig_init2: std_logic_vector (31 downto 0);
    signal sig_sel1_tx: std_logic;
    signal sig_sel2_tx: std_logic;
    signal sig_init2_lmic1: std_logic_vector (31 downto 0);

    signal sig_init3_lmic1: std_logic_vector (31 downto 0);
    signal sig_sel3_rx: std_logic;
    
begin

    -- set as asynchrononus reset the not of the bus AXI reset
    sig_rst_asynch <= not s00_axi_aresetn;
    
-- dci instantiation
dci_inst : dci
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
	)
	port map (
	
	   -- control bus for lmic1
        control_lmic1 => sig_control_lmic1,
        -- init for sniffer1
        init1_lmic1 => sig_init1_lmic1,
        -- init for sniffer 2
        init2_lmic1 => sig_init2_lmic1,
        -- init for sniffer 3
        init3_lmic1 => sig_init3_lmic1,
        -- sel for sniffer 1
        sel1 => sig_sel1_rx,
        -- sel for sniffer 2
        sel2 => sig_sel2_rx,
        -- sel for sniffer 3
        sel3 => sig_sel3_rx,
        -- get result from the sniffer contained in lmic1
        result_lmic1 => sig_result_lmic1,
                -- interface with bram
                addr_ram => addr_ram,
        din_ram => din_ram,
        wea_ram => wea_ram,
        rsta_ram => rsta_ram,
        ena_ram => ena_ram,
        
        -- interface with axi4lite
		S_AXI_ACLK	=> s00_axi_aclk,
		S_AXI_ARESETN	=> s00_axi_aresetn,
		S_AXI_AWADDR	=> s00_axi_awaddr,
		S_AXI_AWPROT	=> s00_axi_awprot,
		S_AXI_AWVALID	=> s00_axi_awvalid,
		S_AXI_AWREADY	=> sig_s00_axi_awready,
		S_AXI_WDATA	=> s00_axi_wdata,
		S_AXI_WSTRB	=> s00_axi_wstrb,
		S_AXI_WVALID	=> s00_axi_wvalid,
		S_AXI_WREADY	=> sig_s00_axi_wready,
		S_AXI_BRESP	=> sig_s00_axi_bresp,
		S_AXI_BVALID	=> sig_s00_axi_bvalid,
		S_AXI_BREADY	=> s00_axi_bready,
		S_AXI_ARADDR	=> s00_axi_araddr,
		S_AXI_ARPROT	=> s00_axi_arprot,
		S_AXI_ARVALID	=> s00_axi_arvalid,
		S_AXI_ARREADY	=> s00_axi_arready,
		S_AXI_RDATA	=> s00_axi_rdata,
		S_AXI_RRESP	=> s00_axi_rresp,
		S_AXI_RVALID	=> s00_axi_rvalid,
		S_AXI_RREADY	=> s00_axi_rready
	);




-- lmic instantiation
lmic1_inst: lmic1
  Port map ( 
      clk => s00_axi_aclk,
      rst_asynch => sig_rst_asynch,
      control_lmic1 => sig_control_lmic1,
      init1_lmic1 => sig_init1_lmic1,
      init2_lmic1 => sig_init2_lmic1,
      init3_lmic1 => sig_init3_lmic1,
      sel1_rx => sig_sel1_rx,
      sel2_rx => sig_sel2_rx,
      sel3_rx => sig_sel3_rx,

    -- interface with microblaze trace port
        uclk => uclk,
        utrace_valid_instr => utrace_valid_instr,
        utrace_PC => utrace_PC,
        utrace_opcode => utrace_opcode,
        utrace_PID_reg => utrace_PID_reg,
        utrace_jump_taken => utrace_jump_taken,
        utrace_icachehit => utrace_icachehit,
        utrace_dcachehit => utrace_dcachehit,
        utrace_icachereq => utrace_icachereq,
        utrace_dcachereq => utrace_dcachereq,

    -- interface with axi4lite
      tr_awready => sig_s00_axi_awready,
      tr_awvalid => s00_axi_awvalid,
      tr_wready => sig_s00_axi_wready,
     tr_bresp => sig_s00_axi_bresp,
      tr_bvalid => sig_s00_axi_bvalid,
      tr_bready => s00_axi_bready,
     tr_wdata => s00_axi_wdata,
      tr_awaddr => s00_axi_awaddr,
      tr_wvalid => s00_axi_wvalid,
      
      
      -- interface with axi4full
                   write_ready => write_ready,
 write_valid => write_valid,
 awrite_addr  => awrite_addr,
 awrite_valid => awrite_valid,
 awrite_ready => awrite_ready,
 awrite_burst => awrite_burst,
 write_strb => write_strb,
 bwrite_valid => bwrite_valid,
 bwrite_ready => bwrite_ready,
 bwrite_resp =>  bwrite_resp,    
 write_last => write_last,
 awrite_len => awrite_len,
 
 -- result from dci
      result_dci => sig_result_lmic1
    );




s00_axi_awready <= sig_s00_axi_awready;
s00_axi_wready <= sig_s00_axi_wready;
s00_axi_bresp <= sig_s00_axi_bresp;
s00_axi_bvalid <= sig_s00_axi_bvalid;


end arch_imp;
