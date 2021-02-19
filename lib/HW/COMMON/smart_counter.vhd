-- Author: Giacomo Valente, Università degli Studi dell'Aquila


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity smart_counter is
	generic (
		dim_bit_g:integer := 64; --set the dimension of the counter
		reset_value_g: integer:=0; --set the value of the reset, the counter will start from this value
		increment_size_g: positive := 10
	);
	port(
	   rst_synch : in std_logic; 
	   rst_asynch: in std_logic;
	     clk : in std_logic; --clock of the counter
	     increment: in std_logic_vector (increment_size_g -1 downto 0); 
	     en_count: in std_logic; --enable the counting
	     overflow : out std_logic; --signals overflow
	     counter_out : out std_logic_vector(dim_bit_g-1 downto 0) --output
	    );
end smart_counter;

architecture Behavioral of smart_counter is
	signal sig_app_counter : unsigned(dim_bit_g downto 0) := (others=>'0'); --bigger than real output to manage overflow
begin
	counting_proc : process (rst_asynch, clk)
	begin
		if rst_asynch = '1' then
			sig_app_counter <=  to_unsigned(reset_value_g,(dim_bit_g+1));
		elsif rising_edge(clk) then
            if (rst_synch = '1') then
              sig_app_counter <=  to_unsigned(reset_value_g,(dim_bit_g+1));
            elsif en_count = '1' then
              sig_app_counter <= sig_app_counter + unsigned(increment);
            end if;
        end if;
	end process;
	counter_out <= std_logic_vector(sig_app_counter (dim_bit_g-1 downto 0));
	overflow <= sig_app_counter (dim_bit_g);

end Behavioral;

