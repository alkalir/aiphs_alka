----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/29/2021 10:49:32 PM
-- Design Name: 
-- Module Name: acknowledger - Behavioral
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

entity acknowledger_AXI is
    generic (
        ack_input_size: positive := 1
        );
        
  Port ( 
        clk: in std_logic;
        rst_synch: in std_logic;
        rst_asynch: in std_logic;
        ack_input: in std_logic_vector (ack_input_size-1 downto 0);
        -- port to indicate that the content of the DCI
        -- can be written to the receiver
        write_ack: out std_logic
        );
end acknowledger_AXI;

architecture Behavioral of acknowledger_AXI is

    signal sig_en_event: std_logic;
    signal sig_tr_bresp: std_logic_Vector (1 downto 0);
    signal sig_tr_bready: std_logic;
    signal sig_tr_bvalid: std_logic;
    signal sig_run_monitor: std_logic;
    signal sig_status: std_logic;
    signal sig_chain: std_logic;
    signal sig_out_mux1: std_logic;
    signal sig_write_ack: std_logic;
    signal sig_or1: std_logic;
    signal sig_and1: std_logic;
    
begin

    -- custom assignments
    sig_en_Event <= ack_input(0);
    sig_tr_bresp <= ack_input (2 downto 1);
    sig_tr_bready <= ack_input(3);
    sig_tr_bvalid <= ack_input(4);
    sig_run_monitor <= ack_input(5);


    -- mux to get the status of AXI operation
    	with sig_tr_bresp select 
        sig_status <=
                '1' when "00",
                '0' when "01",
            '1' when "10",
            '0' when "11",
            '0' when others;
    
    -- generate the write acknowledge to say to DCI that it can write results
    sig_write_ack <= sig_status and sig_run_monitor and sig_tr_bvalid and sig_tr_bready and sig_chain;
    write_ack <= sig_write_ack;
    
    
    -- generate the chain signal

    mux1:mux2to1
        generic map(
                size_port => 1
        )
      Port map( 
            in0_mux(0) => sig_or1,
            in1_mux(0) => '0',
            sel_mux => sig_write_ack,
            out_mux(0) => sig_out_mux1
            );

    sig_chain_gen: pipo_reg


        generic map( 
                size_g => 1
                )
        Port map ( 
              clk => clk,
              rst_asynch => rst_asynch,
              rst_synch => rst_synch,
              en => sig_out_mux1,
              data_in(0) => sig_out_mux1,
              
              data_out(0) => sig_chain
              
       );
       
       sig_or1 <= sig_and1 or sig_chain;
       sig_and1 <= sig_en_Event and sig_run_monitor;
    
end Behavioral;
