----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2020 03:32:54 PM
-- Design Name: 
-- Module Name: lmic1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.common_pack.all;
use work.config.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lmic1 is
  Port ( 
        clk: in std_logic;
        rst_asynch: in std_logic;
        -- port to receive the control string for the lmic
        control_lmic1: in std_logic_vector(31 downto 0);
        -- port to receive the initialization for sniffer1
        init1_lmic1: in std_logic_vector(31 downto 0); 
        -- port to receive the initialization for sniffer2
        init2_lmic1: in std_logic_vector(31 downto 0); 
        init3_lmic1: in std_logic_vector(31 downto 0); 
        -- port to receive the enable to initialize sniffer 1
        sel1_rx: in std_logic;
        -- port to receive the enable to initialize sniffer 1
        sel2_rx: in std_logic;
        sel3_rx: in std_logic;
        --ports to generate the init_good
        tr_awready: in std_logic;
        tr_awvalid: in std_logic;     
        -- provide the result toward dci (results have a well defined structure)
        result_dci: out std_logic_vector(size1_DCI-1 downto 0);
        
		-- ports for monitoring the microblaze trace port
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
        
        -- ports for monitoring the AXI bus
        tr_wvalid : in std_logic;
        tr_wready : in std_logic;
        tr_bresp: in std_logic_vector (1 downto 0);
        tr_bvalid : in std_logic;
        tr_bready : in std_logic;
              tr_wdata : in std_logic_vector (axi_data_width-1 downto 0);
        tr_awaddr : in std_logic_vector (axi_addr_width-1 downto 0);
        
        -- ports for monitoring the AXI4full bus
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
        awrite_len: in std_logic_vector(7 downto 0)
        
  );
end lmic1;

architecture Behavioral of lmic1 is
signal sig_write_ack_MBTP: std_logic;
signal sig_write_ack_AXI: std_logic;
signal sig_catch_MBTP: std_logic;
signal sig_catch_AXI: std_logic;
signal sig_and1: std_logic;
signal sig_init_good: std_logic;
signal sig_prog1: std_logic_vector(1 downto 0);
signal sig_prog2: std_logic_vector(1 downto 0);
signal sig_run_monitor: std_logic;
signal sig_sel1_tx: std_logic;
signal sig_result_sniff_MBTP: std_logic_vector(size_MBTP_sniffer_result-1 downto 0);
signal sig_result_sniff_AXI: std_logic_vector(size_AXI_sniffer_result-1 downto 0);
signal sig_rst_synch: std_logic;
signal sig_total_AXI: std_logic_vector(size_AXI_total_result-1 downto 0); --two bits wider than result
signal sig_total_MBTP: std_logic_vector(size_MBTP_total_result-1 downto 0);--two bits wider than result

signal sig_result_sniff_AXIFULL: std_logic_vector(size_AXIfull_sniffer_result-1 downto 0);
signal sig_write_ack_AXIFULL: std_logic;
signal sig_catch_AXIFULL: std_logic;
signal sig_total_AXIFULL: std_logic_vector(size_AXIfull_total_result-1 downto 0);
signal sig_prog3: std_logic_vector(1 downto 0);

begin

--##########################################
-- connect sniffer for AXI to get timestamps
--##########################################
AXI_sniffer: if AXI_sniffer_en /= 0 generate
    sniff_AXI: sniffer_AXI 
    generic map(dim_event_g => 32)
      Port map( 
            clk =>clk,
            rst_asynch =>rst_asynch,
            rst_synch =>sig_rst_synch,
            init =>init2_lmic1,
            init_good =>sig_init_good,
            prog =>sig_prog2,
            run_monitor =>sig_run_monitor,
            sel =>sel2_rx,
        tr_awready =>tr_awready,
            tr_awvalid =>tr_awvalid,
                   tr_wready =>tr_wready,
                    tr_wvalid =>tr_wvalid,
            tr_bresp =>tr_bresp,
            tr_bvalid =>tr_bvalid,
            tr_bready => tr_bready,
                          tr_wdata =>tr_wdata,
      tr_awaddr =>tr_awaddr,
            result => sig_result_sniff_AXI,
                    write_ack => sig_write_ack_AXI,
            catch=> sig_catch_AXI
            
            );
end generate;

-- contains ack, catch, and result
sig_total_AXI <= sig_write_ack_AXI & sig_catch_AXI & sig_result_sniff_AXI;

--##########################################
-- no sniffer for AXI to get timestamps
--##########################################
no_AXI_sniffer: if AXI_sniffer_en = 0 generate
    -- mettere risultato tutto a zero
    sig_result_sniff_AXI <= (others => '0');
    sig_write_ack_AXI <= '0';
    sig_catch_AXI <= '0';
    
end generate;

--##########################################
-- connect sniffer to microblaze trace port 
-- sniffer 1 instance
--##########################################
sniff_MBTP: if MBTP_sniffer_en /= 0 generate


    sniffer_MB_inst: sniffer_MBTP 
  port map ( 
        clk => clk,
        rst_asynch => rst_asynch,
        rst_synch => sig_rst_synch,

        init => init1_lmic1,
        init_good => sig_init_good,
        prog => sig_prog1,
        run_monitor => sig_run_monitor,
        sel => sel1_rx,
        
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
        
        result => sig_result_sniff_MBTP,
            write_ack => sig_write_ack_MBTP,
        catch=> sig_catch_MBTP
        
        );
        
end generate;

-- contains ack, catch, and result
sig_total_MBTP <= sig_write_ack_MBTP & sig_catch_MBTP & sig_result_sniff_MBTP;

--##########################################
-- no sniffer for microblaze trace port
--##########################################
no_MBTP_sniffer: if MBTP_sniffer_en = 0 generate
    -- mettere risultato tutto a zero
    sig_result_sniff_MBTP <= (others => '0');
    sig_write_ack_MBTP <= '0';
    sig_catch_MBTP <= '0';
    
end generate;


--##########################################
-- sniffer for AXiFull
--##########################################
sniff_AXIFULL: if AXIFULL_sniffer_en /= 0 generate


    sniffer_AXIF: sniffer_AXIfull 
  port map ( 
        clk => clk,
        rst_asynch => rst_asynch,
        rst_synch => sig_rst_synch,

        -- control and initialization of the sniffer
        init => init3_lmic1,
        init_good => sig_init_good,
        prog => sig_prog3,
        run_monitor => sig_run_monitor,
        sel => sel3_rx,
 
        -- interface with axi full
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
        
        -- results from the sniffer
        result => sig_result_sniff_AXIFULL,
        write_ack => sig_write_ack_AXIFULL,
        catch => sig_catch_AXIFULL
    );
    
end generate;

-- contains ack, catch, and result
sig_total_AXIFULL <= sig_write_ack_AXIFULL & sig_catch_AXIFULL & sig_result_sniff_AXIFULL;

--##########################################
-- no sniffer for axifull
--##########################################
no_AXIFULL_sniffer: if AXIFULL_sniffer_en = 0 generate
    -- mettere risultato tutto a zero
    sig_result_sniff_AXIFULL <= (others => '0');
    sig_write_ack_AXIFULL <= '0';
    sig_catch_AXIFULL <= '0';
    
end generate;


    -- run monitor assignment
    sig_run_monitor <= control_lmic1(0);
    
    -- program bits assignment
    sig_prog1 <= control_lmic1(3) & control_lmic1(2);
    sig_prog2 <= control_lmic1(5) & control_lmic1(4);
    sig_prog3 <= control_lmic1(7) & control_lmic1(6);
    
    --generation of init_good one clock cycle later than handshaking on AWAXI channel
    sig_and1 <=  tr_awready and tr_awvalid;    
    
    init_g_proc: process (clk, rst_asynch)
    begin
        if rst_asynch = '1' then
            sig_init_good <= '0';
        elsif rising_edge(clk) then
            if control_lmic1(1) = '1' then -- the soft and synchronous reset
                sig_init_good <= '0';
            else
                sig_init_good <= sig_and1;
            end if;
        end if;
    end process;
    
    sig_rst_synch <= control_lmic1(1);
    

    result_dci <= sig_total_AXIFULL & sig_total_MBTP & sig_total_AXI;
    
end Behavioral;
