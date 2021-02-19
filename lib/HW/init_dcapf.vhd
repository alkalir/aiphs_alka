----------------------------------------------------------------------------------
-- Company: University of L'Aquila
-- Engineer: Giacomo Valente
-- 
-- Create Date: 11/28/2020 12:20:15 PM
-- Design Name: 
-- Module Name: init_dcapf - Behavioral
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

entity init_dcapf is
  Port ( 
        init: in std_logic_vector (31 downto 0);
        load_sup: in std_logic;
        load_inf: in std_logic;
        prog: in std_logic_vector (1 downto 0);
        
        clk: in std_logic;
        rst_synch: in std_logic;
        rst_asynch: in std_logic;
        
        value_sup: out std_logic_vector (31 downto 0);
        value_inf: out std_logic_vector (31 downto 0)
  );
end init_dcapf;

architecture Behavioral of init_dcapf is

signal sig_sel1: std_logic;
signal sig_out0_demux1: std_logic;
signal sig_out1_demux1: std_logic;
signal sig_count1: std_logic;
signal sig_en_count1: std_logic;
signal sig_counter1: std_logic;
signal sig_and1: std_logic;
signal sig_and2: std_logic;
signal sig_and4: std_logic;
    
begin
    

    sig_and4 <= not prog(1) and prog(0) and rst_synch;
    
    --
    reg_inf: pipo_reg
    generic map (size_g => 32)
    port map (
              clk => clk,
                rst_asynch => rst_asynch,
                rst_synch => sig_and4, 
                en => load_inf,
                data_in => init,
                data_out => value_inf
                );
    
 
     reg_sup: pipo_reg
                generic map (size_g => 32)
                port map (
                          clk => clk,
                            rst_asynch => rst_asynch,
                            rst_synch => sig_and4, 
                            en => load_sup,
                            data_in => init,
                            data_out => value_sup
                            );   

    

 
end Behavioral;
