-- Author: Giacomo Valente, Università degli Studi dell'Aquila

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity comp_prog is
	generic (dim_bus_g:positive:=32); --dimension of the lt comparator

	port(data_in1:in std_logic_vector(dim_bus_g-1 downto 0); -- first input, if this input is lower than  another, output is high
	     data_in2:in std_logic_vector(dim_bus_g-1 downto 0); -- second input
	     sel: in std_logic_vector (1 downto 0); -- selection input
	     data_out:out std_logic); --output

end comp_prog;



architecture arc_comp_lt of comp_prog is

	signal sig_app: std_logic:='0';
    
begin
	comb:process (data_in1, data_in2, sel)
	begin
		case sel is
			when "00" => -- lower comparator, data_in1<data_in2
				if (unsigned(data_in1) <= unsigned(data_in2)) then
					sig_app<='1';
				else
					sig_app<='0';
				end if;

			when "01" => -- greater comparator, data_in1>data_in2
				if (unsigned(data_in1) >= unsigned(data_in2)) then
					sig_app<='1';
				else
					sig_app<='0';
				end if;

			when "10" => -- equal comparator, data_in1=data_in2
				if (unsigned(data_in1) = unsigned(data_in2)) then
					sig_app<='1';
				else
					sig_app<='0';
				end if;

			when others =>
				sig_app<='0';
		end case;

	end process;

	data_out<= sig_app;

end arc_comp_lt;
