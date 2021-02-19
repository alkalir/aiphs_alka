----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2021 03:19:38 PM
-- Design Name: 
-- Module Name: bram_writer - Behavioral
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
use work.config.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bram_writer is
  Port ( 
        clk: in std_logic;
        rst_synch: in std_logic;
        rst_asynch: in std_logic;
        data_to_write: in std_logic_vector (63 downto 0);
        write_ack: in std_logic;        
        addr_ram: out std_logic_vector (13 downto 0);
        din_ram: out std_logic_vector (31 downto 0);
        wea_ram: out std_logic_vector (3 downto 0);
        rsta_ram: out std_logic;
        ena_ram: out std_logic
        );
end bram_writer;

architecture Behavioral of bram_writer is
signal sig_write_ack_delay: std_logic;
signal sig_and1: std_logic;
signal sig_address: std_logic_vector (13 downto 0);
signal sig_addr_ram: std_logic_vector (13 downto 0);
signal sig_din_ram: std_logic_vector (31 downto 0);
signal sig_wea_ram: std_logic_vector (3 downto 0);

begin

delay_write_ack: process (clk, rst_asynch)
begin
    if (rst_asynch = '1') then
        sig_write_ack_delay <= '0';
    elsif rising_edge(clk) then
        if (rst_synch = '1') then
            sig_write_ack_delay <= '0';
        else
            sig_write_ack_delay <= write_ack;
        end if;
    end if;
end process;


sig_and1 <= sig_write_ack_delay and not write_ack;

	inst_counter1: smart_counter
		generic map(
			dim_bit_g        => 14,
			reset_value_g    => 0,
			increment_size_g => 4 -- the size of the bus that indicate the increment value
		)
		port map(
			rst_synch         => rst_synch,
			rst_asynch => rst_asynch,
			clk         => clk,
			increment   => "1000", -- increment of 8 at each counting cycle
			en_count    => sig_write_ack_delay,
			overflow    => open,
			counter_out => sig_address
		);
		
    din_ram <= data_to_write (63 downto 32) when sig_and1 = '0' else
                  data_to_write (31 downto 0);
                  
    
    wea_ram <= "1111"; -- set to 1 the write enable, since we write words
    
    addr_ram <= sig_address when sig_and1 = '0' else
                    std_logic_vector(unsigned (sig_address) + 4) ;

    ena_ram <= write_ack or sig_write_ack_delay;
    rsta_ram <= rst_asynch;
    
end Behavioral;
