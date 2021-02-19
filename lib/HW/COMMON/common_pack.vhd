----------------------------------------------------------------------------------
-- Company: University of L'Aquila
-- Engineer: Giacomo Valente
-- 
-- Create Date: 11/28/2020 03:32:37 PM
-- Design Name: 
-- Module Name: common_pack - Behavioral
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
use work.config.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package common_pack is
    

component catcher is

generic (
           catcher_input_size: positive := 2
        );
        
  Port ( 
        catcher_input: in std_logic_vector (catcher_input_size - 1 downto 0);
        
        catch: out std_logic
        
        );
        
end component;

    component smart_demux is
  Port ( 
           in1_demux: in std_logic;
           sel_demux: in std_logic;
           out0_demux: out std_logic;
           out1_demux: out std_logic
           
      );
  end component;


    component smart_counter is
        generic (
            dim_bit_g:integer := 64; --set the dimension of the counter
            reset_value_g: integer:=0; --set the value of the reset, the counter will start from this value
            increment_size_g: positive := 10
        );
        port(
           rst_synch : in std_logic; 
           rst_asynch: in std_logic;
             clk : in std_logic; --clock of the counter
             increment: in std_logic_vector (increment_size_g -1 downto 0); 
             en_count: in std_logic; --enable the counting
             overflow : out std_logic; --signals overflow
             counter_out : out std_logic_vector(dim_bit_g-1 downto 0) --output
            );
    end component;

    component pipo_reg is
        generic ( 
                size_g: positive := 1
                );
        Port ( 
              clk: in std_logic;
              rst_asynch: in std_logic;
              rst_synch: in std_logic;
              en: in std_logic;
              data_in: in std_logic_vector (size_g-1 downto 0);
              
              data_out: out std_logic_vector (size_g-1 downto 0)
              
       );
    end component;

    component init_dcapf is
      Port ( 
            init: in std_logic_vector (31 downto 0);
            load_sup: in std_logic;
            load_inf: in std_logic;
            prog: in std_logic_vector (1 downto 0);
            
            clk: in std_logic;
            rst_synch: in std_logic;
            rst_asynch: in std_logic;
            
            value_sup: out std_logic_vector (31 downto 0);
            value_inf: out std_logic_vector (31 downto 0)
      );
    end component;
    
    
    
    component comp_prog
        generic(dim_bus_g : positive);
        port(
            data_in1 : in  std_logic_vector(dim_bus_g - 1 downto 0);
            data_in2 : in  std_logic_vector(dim_bus_g - 1 downto 0);
            sel      : in  std_logic_vector(1 downto 0);
            data_out : out std_logic
        );
    end component comp_prog;
    
--    component mux4to1 is
        
--            generic (
--                    size_port: positive:= 1
--            );
--          Port ( 
--                in0_mux: in std_logic_vector(size_port-1 downto 0);
--                in1_mux: in std_logic_vector(size_port-1 downto 0);
--                in2_mux: in std_logic_vector(size_port-1 downto 0);
--                in3_mux: in std_logic_vector(size_port-1 downto 0);
--                sel_mux: in std_logic_vector(1 downto 0);
--                out_mux: out std_logic_vector(1 downto 0)
--                );
--        end component;
 
    component core_observe is
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
        end component;       

    component event_monitor is
        generic (
                 dim_event_g: positive:=32;
                 incr_size_g: positive:= 1;
                 dim_event_out: positive:=64
                  );
        port (
              clk: in std_logic;
              rst_asynch: in std_logic;
              rst_synch: in std_logic;
              event_data: in std_logic_Vector (dim_event_g-1 downto 0); -- monitored data to be processed
              event_data_good: in std_logic; -- when high, guarantees validity of event_data
              event_increment: in std_logic_vector (incr_size_g-1 downto 0); -- indicates the increment value 
                value_sup: in std_logic_vector (31 downto 0);
                value_inf_single: in std_logic_vector (31 downto 0);
              prog: in std_logic_vector(1 downto 0);
              run_monitor: in std_logic;
              overflow: out std_logic;
              count_out: out std_logic_vector (63 downto 0);
                        write_ack_event: out std_logic;
              catch_event: out std_logic
              );
    end component;

    component mux2to1 is
        generic (
                size_port: positive:= 1
        );
      Port ( 
            in0_mux: in std_logic_vector(size_port-1 downto 0);
            in1_mux: in std_logic_vector(size_port-1 downto 0);
            sel_mux: in std_logic;
            out_mux: out std_logic_vector(size_port-1 downto 0)
            );
    end component;
        
    component timing_capturer is
          Port ( 
                event_data_good: in std_logic; 
                en_event: in std_logic;
                en_count: out std_logic;
                clk: in std_logic;
                rst_asynch: in std_logic;
                rst_synch: in std_logic;
                run_monitor: in std_logic;
                prog: in std_logic_vector(1 downto 0)
        
            );
        end component;

    component time_monitor is
        generic (
                 dim_event_g: positive:=32;
                 incr_size_g: positive:= 1;
                 dim_time_out: positive := 64;
                 config_string: unsigned(4 downto 0);
                 ack_input_size: positive := 1
                  );
        port (
              clk: in std_logic;
              rst_asynch: in std_logic;
              rst_synch: in std_logic;
              event_data: in std_logic_Vector (dim_event_g-1 downto 0); -- monitored data to be processed
              event_data_good: in std_logic; -- when high, guarantees validity of event_data
              event_increment: in std_logic_vector (incr_size_g-1 downto 0); -- indicates the increment value 
                value_sup: in std_logic_vector (31 downto 0);
                value_inf_single: in std_logic_vector (31 downto 0);
              prog: in std_logic_vector(1 downto 0);
              run_monitor: in std_logic;
              overflow: out std_logic;
              count_out: out std_logic_vector (63 downto 0);
              catch_time: out std_logic;
              write_ack_time: out std_logic;
              ack_input: in std_logic_vector(4 downto 0)
              );
    end component;
    
    component eig_MBTP is
          Port ( 
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
                
                
                event_attr: out std_logic_vector (1 downto 0);
                event_data: out std_logic_vector (31 downto 0);
                event_data_good: out std_logic;
                event_increment: out std_logic
                
                );
        end component;

component sniffer_MBTP is
  Port ( 
        clk: in std_logic;
        rst_asynch: in std_logic;
        rst_synch: in std_logic;

        init: in std_logic_vector (31 downto 0);
        init_good: in std_logic;
        prog: in std_logic_vector (1 downto 0);
        run_monitor: in std_logic;
        sel: in std_logic;
        
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
        
        result: out std_logic_vector (size_MBTP_sniffer_result-1 downto 0);
        write_ack: out std_logic;
        catch: out std_logic
        
        );
end component;

component lmic1 is
  Port ( 
        clk: in std_logic;
        rst_asynch: in std_logic;
        -- port to receive the control string for the lmic
        control_lmic1: in std_logic_vector(31 downto 0);
        -- port to receive the initialization for sniffer1
        init1_lmic1: in std_logic_vector(31 downto 0); 
        -- port to receive the initialization for sniffer2
        init2_lmic1: in std_logic_vector(31 downto 0); 
        -- port to receive the enable to initialize sniffer 1
        sel1_rx: in std_logic;
        -- port to receive the enable to initialize sniffer 1
        sel2_rx: in std_logic;
        --ports to generate the init_good
        tr_awready: in std_logic;
        tr_awvalid: in std_logic;     
        -- provide the result toward dci
        result_dci: out std_logic_vector(size1_DCI-1 downto 0);
        
		-- ports for monitoring the microblaze trace port
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
        
        -- ports for monitoring the AXI bus
        tr_wready : in std_logic;
        tr_bresp: in std_logic_vector (1 downto 0);
        tr_bvalid : in std_logic;
        tr_bready : in std_logic;
        tr_wvalid: in std_logic;
              tr_wdata : in std_logic_vector (axi_data_width-1 downto 0);
        tr_awaddr : in std_logic_vector (axi_addr_width-1 downto 0)
  );
end component;

        component dcapf_branch_taken is
            generic (
                     dim_event_g: positive:=32;
                     incr_size_g: positive:= 1;
                     dim_event_out: positive:= 32;
                     dim_time_out: positive:= 32;
                     ack_input_size: positive := 1
                      );
            port (
                  clk: in std_logic;
                  rst_asynch: in std_logic;
                  rst_synch: in std_logic;
                  event_data: in std_logic_Vector (dim_event_g-1 downto 0); -- monitored data to be processed
                  event_data_good: in std_logic; -- when high, guarantees validity of event_data
                  event_increment: in std_logic_vector (incr_size_g-1 downto 0); -- indicates the increment value 
                    init: in std_logic_vector (31 downto 0);
                    load_sup: in std_logic;
                    load_inf: in std_logic;
                  prog: in std_logic_vector(1 downto 0);
                  run_monitor: in std_logic;
                  count_out_event: out std_logic_vector (dim_event_out-1 downto 0);
                  count_out_time: out std_logic_vector (dim_time_out-1 downto 0);
                    overflow_event: out std_logic;
                  overflow_time: out std_logic;
                            write_ack_time: out std_logic;
                  catch_time: out std_logic;
                  write_ack_event: out std_logic;
                  catch_event: out std_logic;
                  ack_input: in std_logic_vector (ack_input_size-1 downto 0)
              );
              
              end component;
              
component aggregator_MBTP is
                Port ( 
                          write_ack_time: in std_logic;
                catch_time: in std_logic;
                write_ack_event: in std_logic;
                catch_event: in std_logic;
                        count_out_event: in std_logic_vector (size_MBTP_count_out_event-1 downto 0);
                        count_out_time: in std_logic_vector (size_MBTP_count_out_time-1 downto 0);
                        event_attr: in std_logic_Vector (size_MBTP_event_attr-1 downto 0);
                        result: out std_logic_vector(size_MBTP_sniffer_result-1 downto 0);
                                  catch: out std_logic;
                        write_ack: out std_logic         
                      );
              end component;     
                  
                  
component event_data_manager is
                      generic (
                           dim_event_g: positive:=32
                            );
                    Port ( 
                          event_data_good: in std_logic; 
                          event_data: in std_logic_vector(dim_event_g-1 downto 0);
                          prog: in std_logic_vector(1 downto 0);
                          event_data_filtered: out std_logic_vector(dim_event_g-1 downto 0);
                          value_sup: in std_logic_vector(31 downto 0);
                          value_inf: in std_logic_vector(31 downto 0);
                          value_sup_filtered: out std_logic_vector(31 downto 0);
                          value_inf_filtered: out std_logic_vector(31 downto 0);   
                          clk: in std_logic;
                          rst_asynch: in std_logic;
                          rst_synch: in std_logic        
                  
                      );
                  end component;
                  

    component dispenser_dcapf is
      Port ( 
            sel: in std_logic;
            init_good: in std_logic;
            prog: in std_logic_vector (1 downto 0);
            rst_synch: in std_logic;
            rst_asynch: in std_logic;
            clk: in std_logic;
            
            load_sup1: out std_logic;
            load_inf1: out std_logic
            
            );
    end component;

        -- component declaration
        component dci is
            generic (
            C_S_AXI_DATA_WIDTH	: integer	:= 32;
            C_S_AXI_ADDR_WIDTH	: integer	:= 6
            );
            port (
            
            
            control_lmic1: out std_logic_vector(31 downto 0);
            init1_lmic1: out std_logic_vector(31 downto 0);
            init2_lmic1: out std_logic_vector(31 downto 0);
            sel1: out std_logic;
            sel2: out std_logic;
            result_lmic1: in std_logic_vector (size1_DCI-1 downto 0);
            -- interface with bram
                    addr_ram: out std_logic_vector (13 downto 0);
            din_ram: out std_logic_vector (31 downto 0);
            wea_ram: out std_logic_vector (3 downto 0);
            rsta_ram: out std_logic;
            ena_ram: out std_logic;
            
            S_AXI_ACLK	: in std_logic;
            S_AXI_ARESETN	: in std_logic;
            S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
            S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
            S_AXI_AWVALID	: in std_logic;
            S_AXI_AWREADY	: out std_logic;
            S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
            S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
            S_AXI_WVALID	: in std_logic;
            S_AXI_WREADY	: out std_logic;
            S_AXI_BRESP	: out std_logic_vector(1 downto 0);
            S_AXI_BVALID	: out std_logic;
            S_AXI_BREADY	: in std_logic;
            S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
            S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
            S_AXI_ARVALID	: in std_logic;
            S_AXI_ARREADY	: out std_logic;
            S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
            S_AXI_RRESP	: out std_logic_vector(1 downto 0);
            S_AXI_RVALID	: out std_logic;
            S_AXI_RREADY	: in std_logic
            );
        end component ;
	
	
component eig_AXI is
generic (dim_event_g: positive := 1);
          Port ( 
                    -- Ports to monitor the AXI port 
                tr_awready: in std_logic;
                    tr_awvalid: in std_logic;  
                           tr_wready : in std_logic;
                            tr_wvalid : in std_logic;
                    tr_bresp: in std_logic_vector (1 downto 0);
                    tr_bvalid : in std_logic;
                                  tr_wdata : in std_logic_vector (axi_data_width-1 downto 0);
              tr_awaddr : in std_logic_vector (axi_addr_width-1 downto 0);
          
                event_attr: out std_logic_vector (size_AXI_event_attr-1 downto 0);
                event_data: out std_logic_vector (dim_event_g-1 downto 0);
                event_data_good: out std_logic;
                event_increment: out std_logic
                );
        end component;
        
component sniffer_AXI is
generic (dim_event_g: positive := 1);
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
                
                
                    -- Ports to monitor the AXI port 
            tr_awready: in std_logic;
                tr_awvalid: in std_logic;  
                       tr_wready : in std_logic;
                        tr_wvalid : in std_logic;
                tr_bresp: in std_logic_vector (1 downto 0);
                tr_bvalid : in std_logic;
                tr_bready: in std_logic;
                              tr_wdata : in std_logic_vector (axi_data_width-1 downto 0);
          tr_awaddr : in std_logic_vector (axi_addr_width-1 downto 0);
                
                -- port to provide result to lmic, the size will be configurable
                result: out std_logic_vector (size_AXI_sniffer_result-1 downto 0);
                                            write_ack: out std_logic;
        catch: out std_logic
                
                );
        end component;
        
component dcapf_AXI is
            generic (
                     dim_event_g: positive:=32;
                     incr_size_g: positive:= 1;
                     config_string: unsigned(4 downto 0);
                     dim_event_out: positive := 64;
                     dim_time_out: positive := 64;
                     ack_input_size: positive := 1
                      );
            port (
                  clk: in std_logic;
                  rst_asynch: in std_logic;
                  rst_synch: in std_logic;
                  -- to get event instances from eig
                  event_data: in std_logic_Vector (dim_event_g-1 downto 0); 
                  -- when high, guarantees validity of event_data
                  event_data_good: in std_logic; 
                  -- indicates the increment value associated with event_data
                  event_increment: in std_logic_vector (incr_size_g-1 downto 0); 
                  -- initialization string for the dcapf
                  init: in std_logic_vector (31 downto 0);
                  -- enable the load of sup value
                  load_sup: in std_logic;
                  -- enable the load of inf value
                  load_inf: in std_logic;
                  
                  prog: in std_logic_vector(1 downto 0);
                  run_monitor: in std_logic;
                  -- output of the event monitor
                  count_out_event: out std_logic_vector (dim_event_out-1 downto 0);
                  -- output of the time monitor
                  count_out_time: out std_logic_vector (dim_time_out-1 downto 0);
                  
                  overflow_event: out std_logic;
                  overflow_time: out std_logic;
                            write_ack_time: out std_logic;
                  catch_time: out std_logic;
                  write_ack_event: out std_logic;
                  catch_event: out std_logic;
                  ack_input: in std_logic_vector (4 downto 0)
              );
              
              end component;
              
              
              
component aggregator_AXI 
                Port ( 
                        write_ack_time: in std_logic;
                        catch_time: in std_logic;
                        write_ack_event: in std_logic;
                        catch_event: in std_logic;
                        count_out_event: in std_logic_vector (size_AXI_count_out_event-1 downto 0);
                        count_out_time: in std_logic_vector (size_AXI_count_out_event-1 downto 0);
                        event_attr: in std_logic_Vector (size_AXI_event_attr-1 downto 0);
                        result: out std_logic_vector(size_AXI_sniffer_result-1 downto 0);
                        catch: out std_logic;
                        write_ack: out std_logic       
                      );
              end component;
              
              
              component acknowledger_AXI 
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
              end component;
              
              
              
component bram_writer is
                Port ( 
                      clk: in std_logic;
                      rst_synch: in std_logic;
                      rst_asynch: in std_logic;
                      data_to_write: in std_logic_vector (63 downto 0);
                      write_ack: in std_logic;        
                      addr_ram: out std_logic_vector (13 downto 0);
                      din_ram: out std_logic_vector (31 downto 0);
                      wea_ram: out std_logic_vector (3 downto 0);
                      rsta_ram: out std_logic;
                      ena_ram: out std_logic
                      );
              end component;
              
end common_pack;


