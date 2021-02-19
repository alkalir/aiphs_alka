----------------------------------------------------------------------------------
-- Company: University of L'Aquila
-- Engineer: Giacomo Valente
-- 
-- Create Date: 11/28/2020 07:44:55 PM
-- Design Name: 
-- Module Name: core_observe - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity core_observe is
    generic (
             dim_event_g: positive:=32
            );
  Port ( 
        value_sup: in std_logic_vector (31 downto 0);
        value_inf_single: in std_logic_vector (31 downto 0);
        prog: in std_logic_vector(1 downto 0);
        run_monitor: in std_logic;
        event_data: in std_logic_Vector (dim_event_g-1 downto 0); 
        event_in_range: out std_logic
        );
end core_observe;

architecture Behavioral of core_observe is

    signal sig_ld_range:std_logic:='0'; --intermediate signal of the range side
    signal sig_ld_single:std_logic:='0';--intermediate signal of the single side
    signal sig_min:std_logic:='0';--output of the minority comparator
    signal sig_sel_gt_eq:std_logic_vector(1 downto 0);
    signal sig_gr:std_logic:='0';
    signal sig_rst_monitor: std_logic;
    signal sig_run_monitor: std_logic;
    signal sig_and1: std_logic;
    signal sig_and2: std_logic;
    signal sig_or1: std_logic;
    signal sig_and3: std_logic;
    signal sig_sel1: std_logic;
    signal sig_count1: std_logic;
    signal sig_demux1_out0: std_logic;
    signal sig_demux1_out1: std_logic;
    signal sig_inf_single: std_logic_vector(31 downto 0);
    signal sig_sup: std_logic_vector(31 downto 0);
    signal sig_out_mux2: std_logic_vector (1 downto 0);
    signal sig_en_event: std_logic;
    signal sig_no_filt: std_logic;
    signal sig_en_count: std_logic;
    signal sig_and4: std_logic;

begin


    -- lower comparator
    comp_lt_inst:comp_prog
        generic map(
            dim_bus_g => dim_event_g
        )
        port map(
            data_in1 => event_data,
            data_in2 => value_sup,
            sel      => "00",
            data_out => sig_min
        );



        

-- it can work either as equality comparator or greater comparator.
    i_comp_gt_eq_1:comp_prog
        generic map(
            dim_bus_g => dim_event_g
        )
        port map(
            data_in1 => event_data,
            data_in2 => value_inf_single,
            sel      => "01",
            data_out => sig_gr
        );

    
    -- and4
    event_in_range <= prog(1) and sig_min and sig_gr and run_monitor;
    



    
    
end Behavioral;
