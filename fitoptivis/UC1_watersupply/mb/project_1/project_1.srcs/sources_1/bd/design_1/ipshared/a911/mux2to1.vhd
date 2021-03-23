----------------------------------------------------------------------------------
-- Company: University of L'Aquila
-- Engineer: Giacomo Valente
-- 
-- Create Date: 11/28/2020 06:16:58 PM
-- Design Name: 
-- Module Name: mux2to1 - Behavioral
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

entity mux2to1 is
    generic (
            size_port: positive:= 1
    );
  Port ( 
        in0_mux: in std_logic_vector(size_port-1 downto 0);
        in1_mux: in std_logic_vector(size_port-1 downto 0);
        sel_mux: in std_logic;
        out_mux: out std_logic_vector(size_port-1 downto 0)
        );
end mux2to1;

architecture Behavioral of mux2to1 is

begin
    mux: process (in0_mux,in1_mux,sel_mux)
    begin
       case sel_mux is
            when '0' =>
               out_mux <= in0_mux;
            when others =>
                out_mux <= in1_mux;
        end case;

    end process;

end Behavioral;
