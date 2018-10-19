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
-- File : flip_flop_t.vhd
-- Project Name : CRAFTERS 
-- FPGA : 
-- Function : t flip flop
-- Date, Author, Revision id, Comments
-- 20/3/15 Giacomo Valente / 0.0 Creation 

-- JJ-MM-AA [DESIGNER_NAME] / x.x insert comments
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity flip_flop_t is
    Port ( clk_t : in  STD_LOGIC;
			  rst_t_in : in  STD_LOGIC;
			  t_in : in  STD_LOGIC;
    
           t_out : out  STD_LOGIC);
end flip_flop_t;






architecture Behavioral of flip_flop_t is

signal sig_app_t: std_logic:='0';

begin

evoluzione: process (clk_t, rst_t_in)
begin
	if rst_t_in='1' then
		sig_app_t<='0';
	else
		if rising_edge (clk_t) then
			if t_in ='1' then
				sig_app_t<=not sig_app_t;
			else
				sig_app_t<=sig_app_t;
			end if;
		end if;
	end if;
end process;

t_out<=sig_app_t;

end Behavioral;

