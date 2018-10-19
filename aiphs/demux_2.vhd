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
----------------------------------------------------------------------------------
-- Company: University of l'Aquila
-- File :demux_2.vhd
-- Project Name : CRAFTERS 
-- FPGA : 
-- Function : demux
-- Date, Author, Revision id, Comments
-- 26/3/15 Giacomo Valente / 0.0 Creation 									
									-- TO DO: add comments after each instantiation, each signal and each process
-- JJ-MM-AA [DESIGNER_NAME] / x.x insert comments
----------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity demux_2 is
	port (bus_total_in:in std_logic_vector (31 downto 0);
			sel2_in: in std_logic_vector (1 downto 0);
			sup_out:out std_logic_vector(31 downto 0);
			inf_out:out std_logic_vector(31 downto 0);
			addr_s_out:out std_logic_vector (31 downto 0);
			other_out: out std_logic_vector (31 downto 0)
			);
end demux_2;



architecture arc_demux_2 of demux_2 is

begin
	sup_out<=bus_total_in when sel2_in="11" else 
	"00000000000000000000000000000000";
	
   inf_out<=bus_total_in when sel2_in="10" else 
	"00000000000000000000000000000000";
	
	addr_s_out<=bus_total_in when sel2_in="01" else
	"00000000000000000000000000000000";
	
	other_out<=bus_total_in when sel2_in="00" else
	"00000000000000000000000000000000";

	
	
end arc_demux_2;

