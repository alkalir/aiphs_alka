----------------------------------------------------------------------------------
-- Company: University of L'Aquila
-- Engineer: Giacomo Valente
-- 
-- Create Date: 11/28/2020 11:32:41 PM
-- Design Name: 
-- Module Name: time_monitor - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity time_monitor is
    generic (
             dim_event_g: positive:=32;
             incr_size_g: positive:= 1;
             dim_time_out: positive := 64;
             config_string: unsigned(4 downto 0);
             ack_input_size: positive := 1
              );
    port (
          clk: in std_logic;
          rst_asynch: in std_logic;
          rst_synch: in std_logic;
          event_data: in std_logic_Vector (dim_event_g-1 downto 0); -- monitored data to be processed
          event_data_good: in std_logic; -- when high, guarantees validity of event_data
          event_increment: in std_logic_vector (incr_size_g-1 downto 0); -- indicates the increment value 
            value_sup: in std_logic_vector (31 downto 0);
            value_inf_single: in std_logic_vector (31 downto 0);
          prog: in std_logic_vector(1 downto 0);
          run_monitor: in std_logic;
          overflow: out std_logic;
          count_out: out std_logic_vector (dim_time_out-1 downto 0);
          -- port to order the storage of count_out of time_monitor
          catch_time: out std_logic;
          -- port to indicate the writing of the result from DCI toward an external module
          write_ack_time: out std_logic;
          ack_input: in std_logic_vector(4 downto 0)
          );
end time_monitor;

architecture Behavioral of time_monitor is

--------------------------------------signals -----------------------------------------------------
signal sig_write_ack: std_logic;
signal sig_ack_input: std_logic_vector (5 downto 0);
signal sig_ld_range:std_logic:='0'; --intermediate signal of the range side
signal sig_ld_single:std_logic:='0';--intermediate signal of the single side
signal sig_min:std_logic:='0';--output of the minority comparator
signal sig_sel_gt_eq:std_logic_vector(1 downto 0);
signal sig_gr_eq:std_logic:='0';
signal sig_rst_monitor: std_logic;
signal sig_run_monitor: std_logic;
signal sig_and1: std_logic;
signal sig_and2: std_logic;
signal sig_or1: std_logic;
signal sig_and3: std_logic;
signal sig_sel1: std_logic;
signal sig_count1: std_logic;
signal sig_demux1_out0: std_logic;
signal sig_demux1_out1: std_logic;
signal sig_inf_single: std_logic_vector(31 downto 0);
signal sig_sup: std_logic_vector(31 downto 0);
signal sig_out_mux2: std_logic_vector (1 downto 0);
signal sig_event_in_range: std_logic;
signal sig_no_filt: std_logic;
signal sig_en_count: std_logic;
signal sig_catch: std_logic;

begin

  
   yes_observer: if config_string(0) /= '0' generate
   
   
 core:filter 
     generic map(
              dim_event_g => 32
             )
   port map( 
         value_sup => value_sup,
         value_inf_single => value_inf_single,
         prog => prog,
         run_monitor => run_monitor,
         event_data => event_data,
         event_in_range => sig_event_in_range
         );

end generate;

no_observer: if config_string(0) = '0' generate
    sig_event_in_range <= run_monitor;   
end generate;








   counter3: smart_counter 
     generic map (
         dim_bit_g => dim_time_out,
         reset_value_g => 0,
         increment_size_g => incr_size_g
     )
     port map(
         rst_synch => rst_synch,
         rst_asynch => rst_asynch,
          clk => clk,
          increment => event_increment,
          en_count => sig_en_count,
          overflow => overflow,
          counter_out => count_out
          );
             
             
             
             
             
             
             
             
yes_capturer: if config_string(1) /= '0' generate
    capturer: timing_capturer
      Port map ( 
            event_data_good => event_data_good,
            en_event => sig_event_in_range,
            en_count => sig_en_count,
            clk => clk,
            rst_asynch => rst_asynch,
            rst_synch => rst_synch,
            run_monitor => run_monitor,
            prog => prog
        
            );
  end generate;
    
    no_capturer: if config_string(1) = '0' generate
        sig_en_count <= run_monitor;
        end generate;
        
        
        
        
      
      -- the catcher allows to define a custom condition to catch the result of dcapf
      -- inside a register of the dci.
      -- In order words, the catch signal allows to order when the count_out of time monitor 
      -- is good and must be stored in a register        
      yes_catcher: if config_string(2) /= '0' generate
      
      catch: catcher
      generic map(
                 catcher_input_size => 2
              )
              
        Port map( 
              catcher_input(0) => event_data_good,
              catcher_input(1) => run_monitor,
              catch => sig_catch
              
              );

      end generate;
      
      no_catcher: if config_string(2) = '0' generate
      
        sig_catch <= '1';
        
      end generate;
      
      catch_time <= sig_catch and run_monitor and prog(1);
      
      
      -- nester generated for acknowledger. This is necessary to understand which module of acknowledger we need
      -- to connect. This choice to avoid using configuration files that can give issues.
    yes_acknowledger: if config_string(3) /= '0' generate
    
    -- check if we need to get the acknowledger for AXI
    set_AXI_ACK: if AXI_sniffer_en /= 0 generate
    
    sig_ack_input <= ack_input & sig_event_in_range;
    
        ack_block: acknowledger_AXI
        generic map(
            ack_input_size => 6
            )
            
      Port map ( 
            clk => clk,
            rst_synch =>rst_synch,
            rst_asynch =>rst_asynch,
            ack_input => sig_ack_input,
            write_ack=>sig_write_ack
            );
            
      end generate;
      
      end generate;
      
      no_acknowledger: if config_string(3) = '0' generate
      
      sig_write_ack <= '1';
      
      end generate;
      
      write_ack_time <= sig_write_ack and run_monitor and prog(1);
      
end Behavioral;
