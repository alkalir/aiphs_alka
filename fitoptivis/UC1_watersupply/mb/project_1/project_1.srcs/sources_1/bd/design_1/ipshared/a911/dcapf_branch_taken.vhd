----------------------------------------------------------------------------------
-- Company: University of L'Aquila
-- Engineer: Giacomo Valente
-- 
-- Create Date: 11/28/2020 04:05:20 PM
-- Design Name: 
-- Module Name: dcapf - Behavioral
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

entity dcapf_branch_taken is
    generic (
             dim_event_g: positive:=32;
             incr_size_g: positive:= 1;
             
             dim_event_out: positive := 64;
             dim_time_out: positive := 64;
             ack_input_size: positive := 1
              );
    port (
          clk: in std_logic;
          rst_asynch: in std_logic;
          rst_synch: in std_logic;
          -- to get event instances from eig
          event_data: in std_logic_Vector (dim_event_g-1 downto 0); 
          -- when high, guarantees validity of event_data
          event_data_good: in std_logic; 
          -- indicates the increment value associated with event_data
          event_increment: in std_logic_vector (incr_size_g-1 downto 0); 
          -- initialization string for the dcapf
          init: in std_logic_vector (31 downto 0);
          -- enable the load of sup value
          load_sup: in std_logic;
          -- enable the load of inf value
          load_inf: in std_logic;
          
          prog: in std_logic_vector(1 downto 0);
          run_monitor: in std_logic;
          -- output of the event monitor
          count_out_event: out std_logic_vector (dim_event_out-1 downto 0);
          -- output of the time monitor
          count_out_time: out std_logic_vector (dim_time_out-1 downto 0);
          
          overflow_event: out std_logic;
          overflow_time: out std_logic;
          write_ack_time: out std_logic;
          catch_time: out std_logic;
          write_ack_event: out std_logic;
          catch_event: out std_logic;
          ack_input: in std_logic_vector (ack_input_size-1 downto 0)
      );
      
      end dcapf_branch_taken;


architecture Behavioral of dcapf_branch_taken is

    signal sig_overflow_event: std_logic;
    signal sig_overflow_time: std_logic;
    
    signal sig_value_sup: std_logic_vector (31 downto 0);
    signal sig_value_inf_single: std_logic_vector (31 downto 0);
    signal sig_count_out_event: std_logic_vector (dim_event_out downto 0); --one bit more to get also overflow
    signal sig_count_out_time: std_logic_vector (dim_time_out downto 0); -- one bit more to get also overflow
    signal sig_rst_synch_filtered: std_logic;
    
    signal sig_and8: std_logic;
    signal sig_event_data_filtered: std_logic_vector(31 downto 0);
    signal sig_sel3: std_logic;
    signal sig_and9: std_logic;
    signal sig_and10: std_logic; 
    
    signal sig_value_sup_filtered: std_logic_vector(31 downto 0);   
    signal sig_value_inf_single_filtered: std_logic_vector(31 downto 0);
  
begin

    -- event data management
    event_data_manager_inst: event_data_manager 
          Port map ( 
                event_data_good => event_data_good,
                event_data => event_data,
                prog => prog,
                event_data_filtered => sig_event_data_filtered,
                value_sup => sig_value_sup,
                value_inf => sig_value_inf_single,
                value_sup_filtered => sig_value_sup_filtered,
                value_inf_filtered => sig_value_inf_single_filtered,
                clk => clk,
                rst_asynch => rst_asynch,
                rst_synch =>  rst_synch   
        
            );  
    
    
            
        
    event_mon: event_monitor
        generic map (
                 dim_event_g => 32,
                 incr_size_g => 1,
                 dim_event_out => dim_event_out
                  )
        port map (
              clk => clk,
              rst_asynch => rst_asynch,
              rst_synch => rst_synch,
              event_data => sig_event_data_filtered,
              event_data_good => event_data_good,
              event_increment =>  event_increment,
                value_sup => sig_value_sup_filtered,
                value_inf_single => sig_value_inf_single_filtered,
              prog => prog,
              run_monitor => run_monitor,
              overflow => sig_count_out_event(dim_event_out),
              count_out => sig_count_out_event(dim_event_out-1 downto 0),
              write_ack_event => write_ack_event,
              catch_event => catch_event,
              event_in_range => open
              );

    init_block: init_dcapf 
      Port map( 
            init => init,
            load_sup => load_sup,
            load_inf => load_inf,
            prog => prog,
            clk => clk,
            rst_synch => rst_synch,
            rst_asynch => rst_asynch,
            value_sup => sig_value_sup,
            value_inf => sig_value_inf_single
      );

                                                                                          
    time_mon: time_monitor
        generic map (
                 dim_event_g => 32,
                 incr_size_g => 1,
                 dim_time_out => dim_time_out,
                 config_string => TIMEMON_MBTP_CONFIG,
                 ack_input_size => ack_input_size
                  )
        port map (
              clk => clk,
              rst_asynch => rst_asynch,
              rst_synch => rst_synch,
              event_data => sig_event_data_filtered,
              event_data_good => event_data_good,
              event_increment =>  event_increment,
                value_sup => sig_value_sup_filtered,
                value_inf_single => sig_value_inf_single_filtered,
              prog => prog,
              run_monitor => run_monitor,
              overflow => sig_count_out_time(dim_time_out),
              count_out => sig_count_out_time(dim_time_out-1 downto 0),
              catch_time => catch_time,
              write_ack_time => write_ack_time     ,
              ack_input => ack_input         
              
              );    
              
      count_out_event <= sig_count_out_event(dim_event_out-1 downto 0);
      overflow_event <= sig_count_out_event(dim_event_out);
      count_out_time <= sig_count_out_time(dim_time_out-1 downto 0);
      overflow_time <= sig_count_out_time(dim_time_out);
      
end Behavioral;
