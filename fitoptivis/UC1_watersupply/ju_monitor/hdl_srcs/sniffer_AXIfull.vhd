----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2021 05:23:28 PM
-- Design Name: 
-- Module Name: sniffer_AXIfull - Behavioral
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

entity sniffer_AXIfull is

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
        
        
            -- Ports to monitor the AXIfull port 
        -- 1st level
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

            
        -- port to provide result to lmic, the size will be configurable
        result: out std_logic_vector (size_AXIfull_sniffer_result-1 downto 0);
                write_ack: out std_logic;
        catch: out std_logic

        
        );
end sniffer_AXIfull;



architecture Behavioral of sniffer_AXIfull is

signal sig_event_in_range: std_logic;
signal sig_control: std_logic_vector (31 downto 0);
signal sig_event_increment_new: std_logic_vector (31 downto 0);
signal sig_event_data_new: std_logic_vector (31 downto 0);
signal sig_event_data_good_new: std_logic;
signal sig_load_sup1: std_logic;
signal sig_load_inf1: std_logic;

    signal sig_catch_event: std_logic;
    signal sig_write_ack_event: std_logic;
    signal sig_catch_time: std_logic;
    signal sig_write_ack_time: std_logic;
    signal sig_event_data_good: std_logic;
    signal sig_event_increment: std_logic;
    signal sig_overflow_event: std_logic;
    signal sig_overflow_time: std_logic;
    
    signal sig_sniffer_ID: std_logic_vector (1 downto 0);   
    signal sig_event_attr: std_logic_vector (1 downto 0); 
    signal sig_event_data: std_logic_vector (31 downto 0);
    signal sig_count_out_event: std_logic_vector (size_AXIFULL_count_out_event-1 downto 0);
    signal sig_count_out_time: std_logic_vector (size_AXIFULL_count_out_time-1 downto 0);
    signal sig_ack_input: std_logic_vector(4 downto 0);
    
begin

eig: eig_AXIfull

--	generic map (dim_mon_data_g: positive:=32;
--	        size_custom_input_adapt	 : positive := 1;
--	        size_custom_output_adapt : positive := 11
--	       ); --dimension of data from monitored bus

	port map (
	   rst_asynch => rst_asynch,
	   rst_synch => rst_synch,
	   clk => clk,
	   
		-- interconnection dependent signals --
		wready  => write_ready,
		wvalid  => write_valid,
		awaddr => awrite_addr,
		awvalid => awrite_valid,
		awready => awrite_ready,
		awburst => awrite_burst,
		wstrb => write_strb,
		bvalid => bwrite_valid,
		bready => bwrite_ready,
		bresp => bwrite_resp,
		timing => clk,
		wlast  => write_last, -- siamo sicuri che ci serva?
		awlen => awrite_len,
		
			
		------ interconnection independent signals-------
		event_ok  => open,
		event_ok_end => open,
		event_data  => open,
		event_sample  => open,
		event_write  => open,
		event_read  => open,
		time_quantum => open,
		custom_input_adapt(0) => sig_event_in_range,
		custom_output_adapt => open,
		control  => sig_control, --completely unused
		
		-- ports for the new monitor
		event_increment_new => sig_event_increment_new,
		event_data_new => sig_event_data_new,
		event_data_good_new => sig_event_data_good_new,
		event_in_range => sig_event_in_range
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
                
                

    dcapf_AXFull: dcapf_axifull
                generic map (
                         dim_event_g => 32,
                         incr_size_g => 32,
                         config_string => "00100", -- abilito solo event monitor
                         dim_event_out => size_AXIFULL_count_out_event,
                         dim_time_out => size_AXIFULL_count_out_time,
                         ack_input_size => TIMEMON_AXI_ACKSIZE_CONFIG
                          )
                          
                port map (
                      clk => clk,
                      rst_asynch => rst_asynch,
                      rst_synch => rst_synch,
                      event_data => sig_event_data_new,
                      event_data_good => sig_event_data_good_new,
                      event_increment => sig_event_increment_new,
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
                      ack_input => sig_ack_input,
                      event_in_range => sig_event_in_range
                  );
                  
                  
    aggregator: aggregator_AXIfull 
                    Port map ( 
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
