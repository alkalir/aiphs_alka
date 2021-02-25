----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/29/2021 09:28:27 AM
-- Design Name: 
-- Module Name: eig_AXI - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity eig_AXI is

generic (dim_event_g: positive := 1);

  Port ( 
            -- Ports to monitor the AXI port 
        tr_awready: in std_logic;
            tr_awvalid: in std_logic;  
                   tr_wready : in std_logic;
                    tr_wvalid : in std_logic;
            tr_bresp: in std_logic_vector (1 downto 0);
            tr_bvalid : in std_logic;
                          tr_wdata : in std_logic_vector (axi_data_width-1 downto 0);
      tr_awaddr : in std_logic_vector (axi_addr_width-1 downto 0);
  
        event_attr: out std_logic_vector (size_AXI_event_attr-1 downto 0); 
        event_data: out std_logic_vector (dim_event_g-1 downto 0);
        event_data_good: out std_logic;
        event_increment: out std_logic
        );
end eig_AXI;

architecture Behavioral of eig_AXI is

signal sig_addr: std_logic;
signal sig_wr: std_logic;
    
    
begin
    -- the event data is the address, that we will check in dcapf
    -- Here we bring the event_data to dim_event_g bit
    event_data <= std_logic_vector(to_unsigned(to_integer(unsigned(tr_awaddr)),dim_event_g));
    event_increment <= '1';
    
    -- the event attribute is the data written, resized at 8 bit
    event_attr <= tr_wdata(size_AXI_event_attr-1 downto 0); 
    
    sig_addr <= tr_awvalid and tr_awready;
    sig_wr <= tr_wready and tr_wvalid;
    event_data_good <= sig_addr and sig_wr;
    
end Behavioral;
