----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/29/2021 04:45:02 PM
-- Design Name: 
-- Module Name: orderer - Behavioral
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

entity catcher is

generic (
           catcher_input_size: positive := 2
        );
        
  Port ( 
        catcher_input: in std_logic_vector (catcher_input_size - 1 downto 0);
        
        catch: out std_logic
        
        );
        
end catcher;

architecture Behavioral of catcher is

begin

    catch <= catcher_input(0) and catcher_input(1);

end Behavioral;
