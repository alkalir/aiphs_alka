--
-- Copyright 2018 Giacomo Valente, Luigi Pomante
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
-- Company: University of l'Aquila
-- File : counter.vhd
-- Project Name : CRAFTERS 
-- FPGA : 
-- Function : generic counter. 
			-- with dim_bit_g the dimension of the counter is selected
			-- it signals overflow by means of error_out signal
			-- 
-- Date, Author / Revision id / Comments
-- 26/3/15 Giacomo / 0.0 / Creation 
-- 09/04/15 Andrea Moro / 0.0 / --new signal to clock the counter and use ld_ac_in as enable
--                             -- change upper case to lower case for signals
-- 30/4/15 Giacomo / 1.0 / only clock signal leaved
							--deleted ld_ac_in, because it is redundant with the functionality of the profiler
-- JJ-MM-AA [DESIGNER_NAME] / x.x insert comments
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;



entity counter is
  generic (dim_bit_g:positive := 16); --set the dimension of the counter
  port(reset_a : in std_logic; --resets counter
       clk : in std_logic;
       error_out : out std_logic; --signals overflow
       counter_out : out std_logic_vector(dim_bit_g-1 downto 0) --output
    );
end counter;

architecture Behavioral of counter is
  signal sig_app_counter : std_logic_vector(dim_bit_g downto 0) := (others=>'0'); --bigger than real output to manage overflow
begin
  counting_proc : process (reset_a, clk)
  begin
    if reset_a = '1' then
      sig_app_counter <= (others=>'0');
    elsif rising_edge(clk) then
        sig_app_counter <= sig_app_counter + "1";
    end if;
  end process;
  counter_out <= sig_app_counter (dim_bit_g-1 downto 0);
  error_out <= sig_app_counter (dim_bit_g);

end Behavioral;

