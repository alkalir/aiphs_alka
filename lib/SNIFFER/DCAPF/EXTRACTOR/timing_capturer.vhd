----------------------------------------------------------------------------------
-- Company: University of L'Aquila
-- Engineer: Giacomo Valente
-- 
-- Create Date: 11/28/2020 11:35:18 PM
-- Design Name: 
-- Module Name: timing_capturer - Behavioral
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

entity timing_capturer is
  Port ( 
        event_data_good: in std_logic; 
        en_event: in std_logic;
        en_count: out std_logic;
        clk: in std_logic;
        rst_asynch: in std_logic;
        rst_synch: in std_logic;
        run_monitor: in std_logic;
        prog: in std_logic_vector(1 downto 0)

    );
end timing_capturer;

architecture Behavioral of timing_capturer is

    signal sig_out_mux1: std_logic;
    signal sig_out_mux2: std_logic;
    signal sig_and5: std_logic;
    signal sig_and6: std_logic;
    signal sig_and8: std_logic;
    signal sig_or1: std_logic;
    signal sig_ff2: std_logic;
    
begin

    ff2: pipo_reg
    generic map (size_g => 1)
    port map (
              clk => clk,
                rst_asynch => rst_asynch,
                rst_synch => rst_synch, 
                en => '1',
                data_in(0) => sig_out_mux1,
                data_out(0) => sig_ff2
                );
    
    --and5
    sig_and5 <= event_data_good and en_event;
    
    -- mux1
    mux1: mux2to1
    generic map ( size_port => 1)
      port map ( 
            in0_mux(0) => sig_out_mux2,
            in1_mux(0) => '1', 
            sel_mux => sig_and5,
            out_mux(0) => sig_out_mux1
            );
            
    -- mux2
    mux2: mux2to1
    generic map ( size_port => 1)
      port map ( 
            in0_mux(0) => sig_ff2,
            in1_mux(0) => '0', 
            sel_mux => sig_and6,
            out_mux(0) => sig_out_mux2
            );
    
    --and6
    sig_and6 <= event_data_good and not en_event;
    
    --or1
    sig_or1 <= sig_ff2 or sig_and5;
    
    -- and7
    en_count <= sig_or1 and prog(1) and run_monitor;
    
end Behavioral;
