----------------------------------------------------------------------------------
-- Company: University of L'Aquila
-- Engineer: Giacomo Valente
-- 
-- Create Date: 11/28/2020 12:29:15 PM
-- Design Name: 
-- Module Name: smart_demux - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity smart_demux is
  Port ( 
         in1_demux: in std_logic;
         sel_demux: in std_logic;
         out0_demux: out std_logic;
         out1_demux: out std_logic
         
    );
end smart_demux;

architecture Behavioral of smart_demux is

begin

    demux: process (in1_demux, sel_demux)
    begin
        if (sel_demux = '0') then
            out0_demux <= in1_demux;
            out1_demux <= '0';
        else
            out0_demux <= '0';
            out1_demux <=in1_demux;
            
        end if;
    end process;
    
end Behavioral;
