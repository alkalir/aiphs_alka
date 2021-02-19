----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Giacomo Valente
-- 
-- Create Date: 01/25/2021 11:16:32 AM
-- Design Name: 
-- Module Name: dispenser_dcapf - Behavioral
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

entity dispenser_dcapf is
  Port ( 
        sel: in std_logic;
        init_good: in std_logic;
        prog: in std_logic_vector (1 downto 0);
        -- soft and synch reset, that here acts only when prog=01
        rst_synch: in std_logic;
        rst_asynch: in std_logic;
        clk: in std_logic;
        
        load_sup1: out std_logic;
        load_inf1: out std_logic
        
        );
end dispenser_dcapf;

architecture Behavioral of dispenser_dcapf is

    signal sig_sel1: std_logic;
    signal sig_out0_demux1: std_logic;
    signal sig_out1_demux1: std_logic;
    signal sig_count1: std_logic;
    signal sig_en_count1: std_logic;
    signal sig_counter1: std_logic;
    signal sig_and1: std_logic;
    signal sig_and2: std_logic;
    signal sig_and3: std_logic;


begin
    
    demux1: smart_demux
    port map(
            in1_demux => sig_and1,
            sel_demux => sig_sel1,
            out0_demux => load_inf1,
            out1_demux => load_sup1
            );
            
    -- and1
        sig_and1 <= init_good and sig_and2 and sel;
    
    -- and2
        sig_and2 <= not prog(1) and prog(0);
        
    -- and3
    sig_and3 <= sig_and2 and rst_synch;
        
        counter1: smart_counter 
            generic map (
                dim_bit_g => 1,
                reset_value_g => 0,
                increment_size_g => 1
            )
            port map(
                rst_synch => sig_and3,
                rst_asynch => rst_asynch,
                 clk => clk,
                 increment(0) => '1',
                 en_count => sig_and1,
                 overflow => open,
                 counter_out(0) => sig_sel1
                );                                                                                      
                
        
end Behavioral;
