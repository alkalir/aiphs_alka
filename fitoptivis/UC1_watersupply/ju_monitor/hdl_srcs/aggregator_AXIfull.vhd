----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2021 12:31:19 PM
-- Design Name: 
-- Module Name: aggregator_AXIfull - Behavioral
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
use work.config.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



entity aggregator_AXIfull is
  Port ( 
          write_ack_time: in std_logic;
          catch_time: in std_logic;
          write_ack_event: in std_logic;
          catch_event: in std_logic;
          count_out_event: in std_logic_vector (31 downto 0);
          count_out_time: in std_logic_vector (31 downto 0);
          event_attr: in std_logic_Vector (1 downto 0);
          result: out std_logic_vector(size_AXIfull_sniffer_result-1 downto 0);
          catch: out std_logic;
          write_ack: out std_logic       
        );
end aggregator_AXIfull;

architecture Behavioral of aggregator_AXIfull is

    constant sniffer_id: std_logic_vector (1 downto 0) := "10";
    constant metric_id: std_logic_vector (1 downto 0) := "10";
    
begin

    -- only event here
    result <=  event_attr & metric_id & sniffer_id & count_out_event & count_out_time;
    write_ack <= write_ack_time and write_ack_event;
    catch <= catch_time and catch_event;
    
end Behavioral;
