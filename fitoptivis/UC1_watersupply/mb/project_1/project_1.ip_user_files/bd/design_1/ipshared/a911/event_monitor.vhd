----------------------------------------------------------------------------------
-- Company: University of L'Aquila
-- Engineer: Giacomo Valente
-- 
-- Create Date: 11/28/2020 12:20:15 PM
-- Design Name: 
-- Module Name: event_monitor - Behavioral
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

entity event_monitor is
    generic (
             dim_event_g: positive:=32;
             incr_size_g: positive:= 1;
             dim_event_out: positive:=64
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
          count_out: out std_logic_vector (dim_event_out-1 downto 0);
          write_ack_event: out std_logic;
          catch_event: out std_logic;
          event_in_range: out std_logic
          );
end event_monitor;

architecture Behavioral of event_monitor is




--------------------------------------signals -----------------------------------------------------
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
signal sig_en_event: std_logic;
signal sig_no_filt: std_logic;
signal sig_en_count: std_logic;

begin

   
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
            event_in_range => sig_en_event
            );

    event_in_range <= sig_en_event;
    
    -- and4 (event capture block)
    sig_en_count <= event_data_good and sig_en_event;
    
   counter2: smart_counter 
     generic map (
         dim_bit_g => dim_event_out,
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
             
             
     write_ack_event <= '1';
     catch_event <= '1';
     

end Behavioral;
