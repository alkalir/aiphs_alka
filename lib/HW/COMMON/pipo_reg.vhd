

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pipo_reg is
    generic ( 
            size_g: positive := 1
            );
    Port ( 
          clk: in std_logic;
          rst_asynch: in std_logic;
          rst_synch: in std_logic;
          en: in std_logic;
          data_in: in std_logic_vector (size_g-1 downto 0);
          
          data_out: out std_logic_vector (size_g-1 downto 0)
          
   );
end pipo_reg;

architecture Behavioral of pipo_reg is

begin

pipo_inst: process (clk, rst_asynch)
begin
    if (rst_asynch = '1') then
        data_out <= (others => '0');
    elsif rising_edge(clk) then
        if (rst_synch = '1') then
            data_out <= (others => '0');
        elsif (en = '1') then
            data_out <= data_in;
        end if;
    end if;
end process;

end Behavioral;
