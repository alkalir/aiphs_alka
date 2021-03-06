-- -------------------------------------------------------------------------------
-- This file has been automatically generated by the Caph compiler (version 2.8.4d)
-- from file main.cph, on 2018-11-07 at 11:41:03, by <unknown>
-- For more information, see : http://caph.univ-bpclermont.fr
-- -------------------------------------------------------------------------------

library ieee,caph;
use ieee.std_logic_1164.all;
use caph.core.all;
use caph.data_types.all;
use ieee.numeric_std.all;

entity forward is
   port (
    in_data_empty: in std_logic;
    in_data: in std_logic_vector(31 downto 0);
    in_data_rd: out std_logic;
    out_data_0_full: in std_logic;
    out_data_0: out std_logic_vector(31 downto 0);
    out_data_0_wr: out std_logic;
    out_data_1_full: in std_logic;
    out_data_1: out std_logic_vector(31 downto 0);
    out_data_1_wr: out std_logic;
    out_data_2_full: in std_logic;
    out_data_2: out std_logic_vector(31 downto 0);
    out_data_2_wr: out std_logic;
    clock: in std_logic;
    reset: in std_logic
    );
end forward;

architecture FSM of forward is
begin
  comb: process(in_data, in_data_empty, out_data_0_full, out_data_1_full, out_data_2_full)
    variable p_data : signed(31 downto 0);
  begin
    -- in_data.rdy, in_data > 5, out_data_0.rdy / p_data=in_data, wr(out_data_0,p_data)
    if in_data_empty='0' and ((from_std_logic_vector(in_data,32)) > (to_signed(5,32))) and out_data_0_full='0' then
      p_data := from_std_logic_vector(in_data,32);
      in_data_rd <= '1';
      out_data_0 <= std_logic_vector(p_data);
      out_data_0_wr <= '1';
      out_data_1 <= (others => 'X');
      out_data_1_wr <= '0';
      out_data_2 <= (others => 'X');
      out_data_2_wr <= '0';
    -- in_data.rdy, in_data >= 0, out_data_1.rdy / p_data=in_data, wr(out_data_1,p_data)
    elsif in_data_empty='0' and ((from_std_logic_vector(in_data,32)) >= (to_signed(0,32))) and ((from_std_logic_vector(in_data,32)) < (to_signed(6,32))) and out_data_1_full='0' then
      p_data := from_std_logic_vector(in_data,32);
      in_data_rd <= '1';
      out_data_1 <= std_logic_vector(p_data);
      out_data_1_wr <= '1';
      out_data_0 <= (others => 'X');
      out_data_0_wr <= '0';
      out_data_2 <= (others => 'X');
      out_data_2_wr <= '0';
    -- in_data.rdy, in_data < 0, out_data_2.rdy / p_data=in_data, wr(out_data_2,p_data)
    elsif in_data_empty='0' and ((from_std_logic_vector(in_data,32)) < (to_signed(0,32))) and out_data_2_full='0' then
      p_data := from_std_logic_vector(in_data,32);
      in_data_rd <= '1';
      out_data_2 <= std_logic_vector(p_data);
      out_data_2_wr <= '1';
      out_data_0 <= (others => 'X');
      out_data_0_wr <= '0';
      out_data_1 <= (others => 'X');
      out_data_1_wr <= '0';
    else
      in_data_rd <= '0';
      out_data_0_wr <= '0';
      out_data_1_wr <= '0';
      out_data_2_wr <= '0';
      out_data_0 <= (others => 'X');
      out_data_1 <= (others => 'X');
      out_data_2 <= (others => 'X');
    end if;
  end process;
  seq: process(clock, reset)
  begin
    if (reset='0') then
    elsif rising_edge(clock) then
    end if;
  end process;
end FSM;

