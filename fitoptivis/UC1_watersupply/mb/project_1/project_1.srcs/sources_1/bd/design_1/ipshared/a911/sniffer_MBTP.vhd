----------------------------------------------------------------------------------
-- Company: University of L'Aquila
-- Engineer: Giacomo Valente
-- 
-- Create Date: 11/29/2020 03:10:02 PM
-- Design Name: 
-- Module Name: sniffer_MB - Behavioral
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
use work.config.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sniffer_MBTP is
  Port ( 
        clk: in std_logic;
        rst_asynch: in std_logic;
        rst_synch: in std_logic;

        --port to receive initialization value from lmic
        init: in std_logic_vector (31 downto 0);
        -- port to receive signal that init value is good and stable
        init_good: in std_logic;
        -- port to receive the programming value for the sniffer
        prog: in std_logic_vector (1 downto 0);
        -- port to receive the run to monitoring actions
        run_monitor: in std_logic;
        -- port to receive the enable to initialization of sniffer1
        sel: in std_logic;
        
        -- ports to monitor the trace port of microblaze
        uclk: in std_logic;
        utrace_valid_instr: in std_logic;
        utrace_PC: in std_logic_vector (31 downto 0);
        utrace_opcode: in std_logic_vector (31 downto 0);
        utrace_PID_reg: in std_logic_vector (7 downto 0);
        utrace_jump_taken: in std_logic;
        utrace_icachehit: in std_logic;
        utrace_dcachehit: in std_logic;
        utrace_icachereq: in std_logic;
        utrace_dcachereq: in std_logic;
        
        -- port to provide result to lmic, the size will be configurable
        result: out std_logic_vector (size_MBTP_sniffer_result-1 downto 0);
        write_ack: out std_logic;
        catch: out std_logic
        
        );
end sniffer_MBTP;

architecture Behavioral of sniffer_MBTP is

    signal sig_event_data_good: std_logic;
    signal sig_event_increment: std_logic;
    signal sig_overflow_event: std_logic;
    signal sig_overflow_time: std_logic;

    signal sig_sniffer_ID: std_logic_vector (1 downto 0);   
    signal sig_event_attr_MBTP: std_logic_vector (size_MBTP_event_attr-1 downto 0);
    signal sig_event_data: std_logic_vector (31 downto 0);
    signal sig_count_out_event: std_logic_vector (63 downto 0);
    signal sig_count_out_time: std_logic_vector (63 downto 0);
    signal sig_load_sup1: std_logic;
    signal sig_load_inf1: std_logic;
    
    signal sig_write_ack_time: std_logic;
    signal sig_catch_time: std_logic;
    signal sig_write_ack_event: std_logic;
    signal sig_catch_event: std_logic;
    signal sig_ack_input: std_logic_vector(4 downto 0);
    
begin
    -- the unique eig 
    eig_sniffer: eig_MBTP 
          Port map ( 
                    uclk => uclk,
                    utrace_valid_instr => utrace_valid_instr,
                    utrace_PC => utrace_PC,
                    utrace_opcode => utrace_opcode,
                    utrace_PID_reg => utrace_PID_reg,
                    utrace_jump_taken => utrace_jump_taken,
                    utrace_icachehit => utrace_icachehit,
                    utrace_dcachehit => utrace_dcachehit,
                    utrace_icachereq => utrace_icachereq,
                    utrace_dcachereq => utrace_dcachereq,
                    
                    event_attr => sig_event_attr_MBTP,
                    event_data => sig_event_data,
                    event_data_good => sig_event_data_good,
                    event_increment => sig_event_increment
                );


    -- the unique dispenser_dcapf
    dispenser: dispenser_dcapf 
          Port map( 
                sel => sel,
                init_good => init_good,
                prog => prog,
                rst_synch => rst_synch,
                rst_asynch => rst_asynch,
                clk => clk,
                
                load_sup1 => sig_load_sup1,
                load_inf1 => sig_load_inf1
                );
    
    -- dcapf branch taken
    dcapf_branch_tak: dcapf_branch_taken
            generic map (
                     dim_event_g => 32,
                     incr_size_g => 1,
                     dim_event_out => 64,
                     dim_time_out => 64,
                     ack_input_size => 5
                      )
            port map (
                  clk => clk,
                  rst_asynch => rst_asynch,
                  rst_synch => rst_synch,
                  event_data => sig_event_data,
                  event_data_good => sig_event_data_good,
                  event_increment(0) => sig_event_increment,
                    init => init,
                    load_sup => sig_load_sup1,
                    load_inf => sig_load_inf1,
                    
                  prog => prog,
                  run_monitor => run_monitor,
                  count_out_event => sig_count_out_event,
                  count_out_time => sig_count_out_time,
                    overflow_event => open,
                  overflow_time => open,
                            write_ack_time =>sig_write_ack_time,
                  catch_time =>sig_catch_time,
                  write_ack_event =>sig_write_ack_event,
                  catch_event =>sig_catch_event,
                  ack_input => sig_ack_input
              );
              sig_ack_input <= (others =>'0');
              
    -- the unique aggregator
    aggr: aggregator_MBTP 
              Port map( 
                    write_ack_time => sig_write_ack_time,
                    catch_time => sig_catch_time,
                    write_ack_event => sig_write_ack_event,
                    catch_event => sig_catch_event,
                      count_out_event => sig_count_out_event,
                      count_out_time => sig_count_out_time,
                      event_attr => sig_event_attr_MBTP,
                      result => result,
                      catch => catch,
                      write_ack => write_ack
                  );
  



end Behavioral;
