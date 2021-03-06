-- -------------------------------------------------------------------------------
-- This file has been automatically generated by the Caph compiler (version 2.8.4d)
-- from file main.cph, on 2018-11-14 at 10:14:07, by <unknown>
-- For more information, see : http://caph.univ-bpclermont.fr
-- -------------------------------------------------------------------------------

library ieee,caph;
use ieee.std_logic_1164.all;
use caph.core.all;
use caph.data_types.all;
use ieee.numeric_std.all;

entity mac_16 is
   port (
    in_data_empty: in std_logic;
    in_data: in std_logic_vector(31 downto 0);
    in_data_rd: out std_logic;
    out_data_full: in std_logic;
    out_data: out std_logic_vector(63 downto 0);
    out_data_wr: out std_logic;
    clock: in std_logic;
    reset: in std_logic
    );
end mac_16;

architecture FSM of mac_16 is
    type t_enum1 is (MUL,ACC,SEND);
    signal state : t_enum1;
    signal n_state : t_enum1;
    signal en_state : boolean;
    signal p_acc : signed(63 downto 0);
    signal n_acc : signed(63 downto 0);
    signal en_acc : boolean;
    signal prod : signed(63 downto 0);
    signal n_prod : signed(63 downto 0);
    signal en_prod : boolean;
    signal idx : unsigned(3 downto 0);
    signal n_idx : unsigned(3 downto 0);
    signal en_idx : boolean;
begin
  comb: process(in_data, in_data_empty, out_data_full, idx, prod, p_acc, state)
    variable p_data : signed(31 downto 0);
  begin
    -- in_data.rdy, state=MUL / p_data=in_data, state:=ACC, prod:=(p_data : signed<64>)*1
    if in_data_empty='0' and state=MUL then
      p_data := from_std_logic_vector(in_data,32);
      in_data_rd <= '1';
      n_state <= ACC;
      en_state <= true;
      n_prod <= mul(conv_signed(p_data,64),to_signed(1,64));
      en_prod <= true;
      out_data <= (others => 'X');
      out_data_wr <= '0';
      n_acc <= p_acc;
      en_acc <= false;
      n_idx <= idx;
      en_idx <= false;
    -- state=ACC, idx = 15, out_data.rdy / state:=MUL, p_acc:=0, wr(out_data,acc+prod), idx:=0
    elsif state=ACC and ((idx) = (to_unsigned(15,4))) and out_data_full='0' then
      n_state <= MUL;
      en_state <= true;
      n_acc <= to_signed(0,64);
      en_acc <= true;
      out_data <= std_logic_vector((p_acc) + (prod));
      out_data_wr <= '1';
      n_idx <= to_unsigned(0,4);
      en_idx <= true;
      in_data_rd <= '0';
      n_prod <= prod;
      en_prod <= false;
    -- state=ACC / state:=MUL, p_acc:=acc+prod, idx:=idx+1
    elsif state=ACC then
      n_state <= MUL;
      en_state <= true;
      n_acc <= (p_acc) + (prod);
      en_acc <= true;
      n_idx <= (idx) + (to_unsigned(1,4));
      en_idx <= true;
      out_data <= (others => 'X');
      out_data_wr <= '0';
      in_data_rd <= '0';
      n_prod <= prod;
      en_prod <= false;
    else
      in_data_rd <= '0';
      out_data_wr <= '0';
      out_data <= (others => 'X');
      en_state <= false;
      en_acc <= false;
      en_prod <= false;
      en_idx <= false;
      n_state <= state;
      n_acc <= p_acc;
      n_prod <= prod;
      n_idx <= idx;
    end if;
  end process;
  seq: process(clock, reset)
  begin
    if (reset='0') then
      state <= MUL;
      p_acc <= "0000000000000000000000000000000000000000000000000000000000000000";
      prod <= "0000000000000000000000000000000000000000000000000000000000000000";
      idx <= "0000";
    elsif rising_edge(clock) then
      if ( en_state ) then
        state <= n_state after 1 ns;
      end if;
      if ( en_acc ) then
        p_acc <= n_acc after 1 ns;
      end if;
      if ( en_prod ) then
        prod <= n_prod after 1 ns;
      end if;
      if ( en_idx ) then
        idx <= n_idx after 1 ns;
      end if;
    end if;
  end process;
end FSM;
