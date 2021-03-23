----------------------------------------------------------------------------------
-- Company: University of L'Aquila
-- Engineer: Giacomo Valente
-- 
-- Create Date: 11/28/2020 11:35:18 PM
-- Design Name: 
-- Module Name: event_data_manager - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity event_data_manager is
    generic (
         dim_event_g: positive:=32
          );
  Port ( 
        event_data_good: in std_logic; 
        event_data: in std_logic_vector(dim_event_g-1 downto 0);
        prog: in std_logic_vector(1 downto 0);
        event_data_filtered: out std_logic_vector(dim_event_g-1 downto 0);
        value_sup: in std_logic_vector(31 downto 0);
        value_inf: in std_logic_vector(31 downto 0);
        value_sup_filtered: out std_logic_vector(31 downto 0);
        value_inf_filtered: out std_logic_vector(31 downto 0);   
        clk: in std_logic;
        rst_asynch: in std_logic;
        rst_synch: in std_logic        

    );
end event_data_manager;

architecture Behavioral of event_data_manager is

signal sig_and8: std_logic;
signal sig_sel3: std_logic;
signal sig_and9: std_logic;
signal sig_and10: std_logic;
signal sig_out_mux1: std_logic;
signal sig_ff2: std_logic;

begin

   counter4: smart_counter 
        generic map (
            dim_bit_g => 1,
            reset_value_g => 0,
            increment_size_g => 1
        )
        port map(
            rst_synch => rst_synch,
            rst_asynch => rst_asynch,
             clk => clk,
             increment(0) => '1',
             en_count => sig_and8,
             overflow => open,
             counter_out(0) => sig_sel3
            );                                                                                      
            
        sig_and8 <= prog(1) and prog(0) and event_data_good and not sig_sel3;
        
    mux3:mux2to1 
          Port map( 
                in0_mux(0) => sig_and9,
                in1_mux(0) => '1',
                sel_mux => sig_sel3,
                out_mux(0) => event_data_filtered(0)
                );

    sig_and9 <= event_data(0) and not sig_and10;
    
    sig_and10 <= prog(1) and prog(0);
    
    -- and 11
    event_data_filtered (dim_event_g-1 downto 1) <= (others=>'0') when sig_and10 = '1'
                                                   else event_data(dim_event_g-1 downto 1);
  
    
        -- and 12
   value_sup_filtered <= (others=>'0') when sig_and10 = '1'
                                                  else value_sup;
                                                                         
   value_inf_filtered <= (others=>'0') when sig_and10 = '1'
                                                 else value_inf; 
end Behavioral;
