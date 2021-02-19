----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/28/2021 01:03:50 PM
-- Design Name: 
-- Module Name: sniffer_AXI - Behavioral
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
use work.config.all;
use work.common_pack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sniffer_AXI is

generic (dim_event_g: positive := 1);

  Port ( 
        clk: in std_logic;
        rst_asynch: in std_logic;
        rst_synch: in std_logic;

        --port to receive initialization value from lmic
        init: in std_logic_vector (31 downto 0);
        -- port to receive signal that init value is good and stable
        init_good: in std_logic;
        -- port to receive the programming value for the sniffer
        prog: in std_logic_vector (1 downto 0);
        -- port to receive the run to monitoring actions
        run_monitor: in std_logic;
        -- port to receive the enable to initialization of sniffer1
        sel: in std_logic;
        
        
            -- Ports to monitor the AXI port 
    tr_awready: in std_logic;
        tr_awvalid: in std_logic;  
               tr_wready : in std_logic;
                tr_wvalid : in std_logic;
        tr_bresp: in std_logic_vector (1 downto 0);
        tr_bvalid : in std_logic;
        tr_bready: in std_logic;
                      tr_wdata : in std_logic_vector (axi_data_width-1 downto 0);
  tr_awaddr : in std_logic_vector (axi_addr_width-1 downto 0);
        
        -- port to provide result to lmic, the size will be configurable
        result: out std_logic_vector (size_AXI_sniffer_result-1 downto 0);
                write_ack: out std_logic;
        catch: out std_logic

        
        );
end sniffer_AXI;

architecture Behavioral of sniffer_AXI is

    signal sig_catch_event: std_logic;
    signal sig_write_ack_event: std_logic;
    signal sig_catch_time: std_logic;
    signal sig_write_ack_time: std_logic;
    signal sig_event_data_good: std_logic;
    signal sig_event_increment: std_logic;
    signal sig_overflow_event: std_logic;
    signal sig_overflow_time: std_logic;
    
    signal sig_sniffer_ID: std_logic_vector (1 downto 0);   
    signal sig_event_attr: std_logic_vector (size_AXI_event_attr-1 downto 0); 
    signal sig_event_data: std_logic_vector (dim_event_g-1 downto 0);
    signal sig_count_out_event: std_logic_vector (size_AXI_count_out_event-1 downto 0);
    signal sig_count_out_time: std_logic_vector (size_AXI_count_out_time-1 downto 0);
    signal sig_load_sup1: std_logic;
    signal sig_load_inf1: std_logic;
    signal sig_ack_input: std_logic_vector(4 downto 0);
    
begin

eig:  eig_AXI 
generic map(dim_event_g => 32)
  Port map( 
            -- Ports to monitor the AXI port 
        tr_awready => tr_awready,
            tr_awvalid => tr_awvalid,
                   tr_wready  => tr_wready,
                    tr_wvalid => tr_wvalid,
            tr_bresp => tr_bresp,
            tr_bvalid => tr_bvalid,
                          tr_wdata => tr_wdata,
      tr_awaddr  => tr_awaddr,
  
        event_attr => sig_event_attr,
        event_data => sig_event_data,
        event_data_good => sig_event_data_good,
        event_increment => sig_event_increment
        );


    -- the unique dispenser_dcapf
    dispenser: dispenser_dcapf 
          Port map( 
                sel => sel,
                init_good => init_good,
                prog => prog,
                rst_synch => rst_synch,
                rst_asynch => rst_asynch,
                clk => clk,
                
                load_sup1 => sig_load_sup1,
                load_inf1 => sig_load_inf1
                );
                
    -- the DCAPF AXI
        -- dcapf branch taken
    dcapf_AX: dcapf_AXI
            generic map (
                     dim_event_g => dim_event_g,
                     incr_size_g => 1,
                     config_string => DCAPF_AXI_CONFIG,
                     dim_event_out => size_AXI_count_out_event,
                     dim_time_out => size_AXI_count_out_time,
                     ack_input_size => TIMEMON_AXI_ACKSIZE_CONFIG
                      )
                      
            port map (
                  clk => clk,
                  rst_asynch => rst_asynch,
                  rst_synch => rst_synch,
                  event_data => sig_event_data,
                  event_data_good => sig_event_data_good,
                  event_increment(0) => sig_event_increment,
                    init => init,
                    load_sup => sig_load_sup1,
                    load_inf => sig_load_inf1,
                    
                  prog => prog,
                  run_monitor => run_monitor,
                  count_out_event => sig_count_out_event,
                  count_out_time => sig_count_out_time,
                    overflow_event => open,
                  overflow_time => open,
                            write_ack_time =>sig_write_ack_time,
                  catch_time =>sig_catch_time,
                  write_ack_event =>sig_write_ack_event,
                  catch_event =>sig_catch_event,
                  ack_input => sig_ack_input
              );
              
    -- custom assignement
    sig_ack_input <= run_monitor & tr_bvalid & tr_bready & tr_bresp;

              
          -- aggregator
         aggr: aggregator_AXI 
                Port map( 
                        write_ack_time => sig_write_ack_time,
                        catch_time => sig_catch_time,
                        write_ack_event => sig_write_ack_event,
                        catch_event => sig_catch_event,
                        count_out_event => sig_count_out_event,
                        count_out_time => sig_count_out_time,
                        event_attr => sig_event_attr,
                        result => result,
                        catch => catch,
                        write_ack => write_ack   
                      );
                      

end Behavioral;
