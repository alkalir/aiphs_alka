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

entity papi_tb is
end papi_tb;

architecture arch of papi_tb is

component papi_net is
  port (
    w8_f: out std_logic;
    w8: in std_logic_vector(31 downto 0);
    w8_wr: in std_logic;
    w13_e: out std_logic;
    w13: out std_logic_vector(63 downto 0);
    w13_rd: in std_logic;
    w17_e: out std_logic;
    w17: out std_logic_vector(63 downto 0);
    w17_rd: in std_logic;
    w21_e: out std_logic;
    w21: out std_logic_vector(63 downto 0);
    w21_rd: in std_logic;
    clock: in std_logic;
    reset: in std_logic
    );
end component;

signal w21_e : std_logic;
signal w21 : std_logic_vector(63 downto 0);
signal w21_rd : std_logic;
signal w17_e : std_logic;
signal w17 : std_logic_vector(63 downto 0);
signal w17_rd : std_logic;
signal w13_e : std_logic;
signal w13 : std_logic_vector(63 downto 0);
signal w13_rd : std_logic;
signal w8_f : std_logic;
signal w8 : std_logic_vector(31 downto 0);
signal w8_wr : std_logic;
signal clock: std_logic;
signal reset: std_logic;

begin
  B4: stream_out generic map ("dout_2.bin",64) port map(w21_e,w21,w21_rd,clock,reset);
  B3: stream_out generic map ("dout_1.bin",64) port map(w17_e,w17,w17_rd,clock,reset);
  B2: stream_out generic map ("dout_0.bin",64) port map(w13_e,w13,w13_rd,clock,reset);
  B1: stream_in generic map ("din.bin",32,1,false,0 ns) port map(w8_f,w8,w8_wr,clock,reset);
  N: papi_net port map(w8_f,w8,w8_wr,w13_e,w13,w13_rd,w17_e,w17,w17_rd,w21_e,w21,w21_rd,clock,reset);

process                     -- Initial reset
begin
  reset <= '0';
  wait for 1 ns;
  reset <= '1';
  wait;
end process;

process                     -- Clock
begin
  clock <= '1';
  wait for 5 ns;
  clock <= '0';
  wait for 5 ns;
end process;

end arch;
