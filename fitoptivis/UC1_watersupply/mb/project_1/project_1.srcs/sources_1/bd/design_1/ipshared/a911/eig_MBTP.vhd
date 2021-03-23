----------------------------------------------------------------------------------
-- Company: University of L'Aquila
-- Engineer: Giacomo Valente
-- 
-- Create Date: 11/29/2020 12:21:55 PM
-- Design Name: 
-- Module Name: eig - Behavioral
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

entity eig_MBTP is
  Port ( 
        uclk: in std_logic;
        utrace_valid_instr: in std_logic;
        utrace_PC: in std_logic_vector (31 downto 0);
        utrace_opcode: in std_logic_vector (31 downto 0);
        utrace_PID_reg: in std_logic_vector (7 downto 0);
        utrace_jump_taken: in std_logic;
        utrace_icachehit: in std_logic;
        utrace_dcachehit: in std_logic;
        utrace_icachereq: in std_logic;
        utrace_dcachereq: in std_logic;
                
        event_attr: out std_logic_vector (1 downto 0);
        event_data: out std_logic_vector (31 downto 0);
        event_data_good: out std_logic;
        event_increment: out std_logic
        
        );
end eig_MBTP;

architecture Behavioral of eig_MBTP is

    
begin

    -- interfacer
    
    -- checker branch taken
    event_data_good <= utrace_valid_instr;
    event_increment <= '1';
    event_attr <= "11";
    event_data <= (others=>'1');
    
end Behavioral;
