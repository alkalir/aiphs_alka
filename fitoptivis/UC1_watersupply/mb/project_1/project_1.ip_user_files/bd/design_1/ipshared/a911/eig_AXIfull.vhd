----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2021 06:11:20 PM
-- Design Name: 
-- Module Name: eig_AXIfull - Behavioral
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
use work.common_pack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity eig_AXIfull is

	generic (dim_mon_data_g: positive:=32;
	        size_custom_input_adapt	 : positive := 1;
	        size_custom_output_adapt : positive := 11
	       ); --dimension of data from monitored bus

	port (
	   rst_asynch: in std_logic;
	   rst_synch: in std_logic;
	   clk: in std_logic;
	   
		-- interconnection dependent signals --
		wready : in std_logic;
		wvalid : in std_logic;
		awaddr: in std_logic_vector (dim_mon_data_g-1 downto 0);
		awvalid: in std_logic;
		awready: in std_logic;
		awburst: in std_logic_vector (1 downto 0);
		wstrb: in std_logic_vector (3 downto 0);
		bvalid: in std_logic;
		bready: in std_logic;
		bresp: in std_logic_vector (1 downto 0);
		timing: in std_logic;
		wlast : in std_logic;
		awlen: in std_logic_vector (7 downto 0);
		
			
		------ interconnection independent signals-------
		event_ok : out std_logic; --event_ok signalation
		event_ok_end: out std_logic; -- signalation of end of event, used by time monitor to take timestamps
		event_data : out std_logic_vector (dim_mon_data_g-1 downto 0); --data monitored from the bus
		event_sample : out std_logic;--high when events must be sampled
		event_write : out std_logic;--to be refined
		event_read : out std_logic; --to be refined
		time_quantum: out std_logic; --gives the timing signal to make time measurements
		custom_input_adapt: in std_logic_vector (size_custom_input_adapt-1 downto 0);
		custom_output_adapt: out std_logic_vector (size_custom_output_adapt-1 downto 0);
		control : in std_logic_vector(31 downto 0);
		
		-- ports for the new monitor
		event_increment_new: out std_logic_vector (31 downto 0); -- to decrease the size!
		event_data_new: out std_logic_vector (31 downto 0);
		event_data_good_new: out std_logic;
		event_in_range: in std_logic
	);


end eig_AXIfull;

architecture Behavioral of eig_AXIfull is

	signal sig_rst : std_logic;
	signal sig_addr1 : std_logic_vector(dim_mon_data_g-1 downto 0);
	signal sig_en_addr1 : std_logic;
	signal sig_in_addr1 : std_logic_vector(dim_mon_data_g-1 downto 0);
	signal sig_addr0 : std_logic_vector(dim_mon_data_g-1 downto 0);
	signal sig_en_addr0 : std_logic;
	signal sig_in_addr0 : std_logic_vector(dim_mon_data_g-1 downto 0);
	signal sig_out_sum_addr : std_logic_vector(dim_mon_data_g-1 downto 0);
	signal sig_a1 : std_logic;
	signal sig_a0 : std_logic;
	signal sig_in1_sum_addr : unsigned(2 downto 0);
	signal sig_in2_sum_addr : std_logic_vector(dim_mon_data_g-1 downto 0);
	signal sig_awsize_1 : unsigned(2 downto 0);
	signal sig_counter2 : std_logic;
	signal sig_awsize_0 : unsigned(2 downto 0);
	signal sig_event_ok : std_logic;
	signal sig_out1_demux1 : std_logic;
	signal sig_out0_demux1 : std_logic;
	signal sig_counter1 : std_logic;
	signal sig_addr : std_logic;
	signal sig_wr : std_logic;
	signal sig_in_demux2 : std_logic;
	signal sig_out1_demux2 : std_logic;
	signal sig_out0_demux2 : std_logic;
	signal sig_out_mux5 : std_logic;
	signal sig_wstrb1 : unsigned(3 downto 0);
	signal sig_en_wstrb1: std_logic;
	signal sig_wstrb0 : unsigned(3 downto 0);
	signal sig_en_wstrb0: std_logic;
	signal sig_num_ones : unsigned(2 downto 0);
	signal sig_out_sum_res : unsigned (size_custom_output_adapt -1 downto 1);
	signal sig_in1_sum_res : unsigned(2 downto 0);
	signal sig_in2_sum_res : unsigned (size_custom_output_adapt -1 downto 1);
	signal sig_out_mux6 : unsigned(3 downto 0);
	signal sig_out_mux7 : unsigned (size_custom_output_adapt -1 downto 1);
	signal sig_result1 : unsigned (size_custom_output_adapt -1 downto 1);
	signal sig_result0 : unsigned (size_custom_output_adapt -1 downto 1);
	signal sig_en_res1 : std_logic;
	signal sig_en_res0 : std_logic;
	signal sig_out1_demux3 : unsigned (size_custom_output_adapt -1 downto 1);
	signal sig_out0_demux3 : unsigned (size_custom_output_adapt -1 downto 1);
	signal sig_out_mux8 : unsigned (size_custom_output_adapt -1 downto 1);
	signal sig_en_mux8 : std_logic;
	signal sig_b : std_logic;
	signal sig_out_mux9 : unsigned (size_custom_output_adapt -1 downto 1);
	signal sig_counter3 : std_logic;
	signal sig_resp : unsigned (1 downto 0);
	signal sig_in_a0 : std_logic;
	signal sig_in_a1 : std_logic;
	signal sig_out0_demux4 : std_logic;
	signal sig_out1_demux4 : std_logic;
	signal sig_out0_demux5 : std_logic;
	signal sig_out1_demux5 : std_logic;
	signal sig_en_a1 : std_logic;
	signal sig_en_a0 : std_logic;
	signal sig_in_w0 : std_logic;
	signal sig_in_w1 : std_logic;
	signal sig_en_w0 : std_logic;
	signal sig_en_w1 : std_logic;
	signal sig_w0 : std_logic;
	signal sig_w1 : std_logic;
	signal sig_out1_demux6 : std_logic;
	signal sig_out0_demux6 : std_logic;
	signal sig_out1_demux7 : std_logic;
	signal sig_out0_demux7 : std_logic;
	signal sig_out_mux18 : std_logic;
	signal sig_out0_demux8: std_logic;
	signal sig_out1_demux8: std_logic;
	signal sig_wlast : std_logic;
	signal sig_len0 : unsigned (3 downto 0);
	signal sig_len1 : unsigned (3 downto 0);
	signal sig_en_len0 : std_logic;
	signal sig_en_len1 : std_logic;
	signal sig_len0_vec : std_logic_vector (3 downto 0);
	signal sig_len1_vec : std_logic_vector (3 downto 0);
	signal sig_in2_comp1 : std_logic_vector (3 downto 0);
	signal sig_counter4 : unsigned(3 downto 0);
	signal sig_counter4_vec: std_logic_vector (3 downto 0);
    signal sig_out_mux19 : std_logic;
    signal sig_out_comp1 : std_logic;
    signal sig_en_count2: std_logic;
    
begin

	sig_rst <=  rst_asynch or rst_synch;



	-- storage of addresses
	
    store_addr1: pipo_reg
    generic map (size_g => 32)
    port map (
              clk => clk,
                rst_asynch => rst_asynch,
                rst_synch => rst_synch, 
                en => sig_en_addr1,
                data_in => sig_in_addr1,
                data_out => sig_addr1
                );

    store_addr0: pipo_reg
    generic map (size_g => 32)
    port map (
              clk => clk,
                rst_asynch => rst_asynch,
                rst_synch => rst_synch, 
                en => sig_en_addr0,
                data_in => sig_in_addr0,
                data_out => sig_addr0
                );



	-- mux_in_addr
	sig_in_addr1 <= awaddr when sig_a1 = '0' else
				sig_out_sum_addr;

	sig_in_addr0 <= awaddr when sig_a0 = '0' else
				sig_out_sum_addr;

	-- adder_addr
	sig_out_sum_addr <= std_logic_vector(unsigned(sig_in1_sum_addr) + unsigned(sig_in2_sum_addr));

	-- mux_in_adder_size
	sig_in1_sum_addr <= sig_awsize_1 when sig_counter2 = '1' else
					sig_awsize_0;

	-- mux_in_adder_address
	sig_in2_sum_addr <= sig_addr1 when sig_counter2 = '1' else
					sig_addr0;

	-- counter2
	   counter2: smart_counter 
      generic map (
          dim_bit_g => 1,
          reset_value_g => 0,
          increment_size_g => 1
      )
      port map(
          rst_synch => rst_synch,
          rst_asynch => rst_asynch,
           clk => clk,
           increment(0) => '1',
           en_count => sig_en_count2,
           overflow => open,
           counter_out(0) => sig_counter2
           );
           

	
sig_en_count2 <= sig_wlast and sig_wr;
    
-- mux3 and mux4
	sig_en_addr1 <= sig_out1_demux8 when sig_a1 = '1' else
				sig_out1_demux1;

	sig_en_addr0 <= sig_out0_demux8 when sig_a0 = '1' else
				sig_out0_demux1;

	-- demux1
	demux1: process(sig_counter1, sig_addr)
	begin
		if sig_counter1 = '1' then
			sig_out1_demux1 <= sig_addr;
			sig_out0_demux1 <= '0';
		else
			sig_out0_demux1 <= sig_addr;
			sig_out1_demux1 <= '0';
		end if;
	end process;
					
					
-- counter1
	   counter1: smart_counter 
      generic map (
          dim_bit_g => 1,
          reset_value_g => 0,
          increment_size_g => 1
      )
      port map(
          rst_synch => rst_synch,
          rst_asynch => rst_asynch,
           clk => clk,
           increment(0) => '1',
           en_count => sig_addr,
           overflow => open,
           counter_out(0) => sig_counter1
           );
           
	-- propagate the sampled address output to nucleus
	event_data <= std_logic_vector(sig_in2_sum_addr);

	-- sig_addr and sig_wr
	sig_addr <= not awburst(1) and awburst(0) and awvalid and awready;
	sig_wr <= wready and wvalid;
	sig_event_ok <= sig_wr;

	
-- demux2
	demux2: process(sig_counter2, sig_in_demux2)
	begin
		if sig_counter2 = '1' then
			sig_out1_demux2 <= sig_in_demux2;
			sig_out0_demux2 <= '0';
		else
			sig_out0_demux2 <= sig_in_demux2;
			sig_out1_demux2 <= '0';
		end if;
	end process;

	sig_in_demux2 <= sig_event_ok and custom_input_adapt(0) and sig_out_mux5;

	-- mux5
	sig_out_mux5 <= sig_a1 when sig_counter2 = '1' else
				sig_a0;

	-- storage of strobes
	sig_wstrb1 <= "1111";
	sig_wstrb0 <= "1111";

	--store_wstrb1: process (timing, sig_rst)
	--begin
	--	if sig_rst = 1 then
	--		sig_wstrb1 <= (others => '0');
	--	elsif
	--		rising_edge(timing) then
	--		if sig_en_wstrb1 = 0 then
	--			sig_wstrb1 <= unsigned(wstrb);
	--		end if;
	--	end if;
	--end process;
	--
	--
	--store_wstrb0: process (timing, sig_rst)
	--begin
	--	if sig_rst = 1 then
	--		sig_wstrb0 <= (others => '0');
	--	elsif
	--		rising_edge(timing) then
	--		if sig_en_wstrb0 = 0 then
	--			sig_wstrb0 <= unsigned(wstrb);
	--		end if;
	--	end if;
	--end process;

	-- adder ones
	adder_ones: process(sig_out_mux6) -- cascade of 1 bit adders
		variable count : unsigned(2 downto 0) := (others => '0');
	begin
		count := (others => '0');
		for i in 0 to 3 loop
			count := count + ("00" & sig_out_mux6(i));
		end loop;
		sig_num_ones <= count;
	end process;

	-- mux6
	sig_out_mux6 <= sig_wstrb0 when sig_counter2 = '0' else
				sig_wstrb1;


-- adder result
	sig_out_sum_res <= sig_in1_sum_res + sig_in2_sum_res;
	sig_in1_sum_res <= sig_num_ones;
	sig_in2_sum_res <= sig_out_mux7;

	-- mux7
	sig_out_mux7 <= sig_result1 when sig_counter2 = '1' else
				sig_result0;

	-- storage of results
	store_result1: process (timing, sig_rst)
	begin
		if sig_rst = '1' then
			sig_result1 <= (others => '0');
		elsif
		rising_edge(timing) then
			if sig_en_res1 = '1' then
				sig_result1 <= sig_out1_demux3;
			end if;
		end if;
	end process;

	store_result0: process (timing, sig_rst)
	begin
		if sig_rst = '1' then
			sig_result0 <= (others => '0');
		elsif
		rising_edge(timing) then
			if sig_en_res0 = '1' then
				sig_result0 <= sig_out0_demux3;
			end if;
		end if;
	end process;

	sig_en_res1 <= sig_out1_demux2;
	sig_en_res0 <= sig_out0_demux2;

	-- demux3
	demux3: process(sig_counter2, sig_out_sum_res)
	begin
		if sig_counter2 = '1' then
			sig_out1_demux3 <= sig_out_sum_res;
			sig_out0_demux3 <= (others => '0');
		else
			sig_out0_demux3 <= sig_out_sum_res;
			sig_out1_demux3 <= (others => '0');
		end if;
	end process;

	-- mux8
	sig_out_mux8 <= sig_result1 when sig_en_mux8 = '1' else
				sig_result0;

	sig_en_mux8 <= sig_counter3;

	-- counter 3
		   counter3: smart_counter 
   generic map (
       dim_bit_g => 1,
       reset_value_g => 0,
       increment_size_g => 1
   )
   port map(
       rst_synch => rst_synch,
       rst_asynch => rst_asynch,
        clk => clk,
        increment(0) => '1',
        en_count => sig_b,
        overflow => open,
        counter_out(0) => sig_counter3
        );
        


	sig_b <= bvalid and bready and sig_out_mux18;

	-- mux18
	sig_out_mux18 <= sig_w0 when sig_counter3 = '0' else
sig_w1;

	-- mux9
	with sig_resp select sig_out_mux9 <=
		sig_out_mux8 when "00",
		(others=>'0') when "01",
	sig_out_mux8 when "10",
	(others=>'0') when "11",
	(others=>'0') when others;

	sig_resp <= bresp(1) & bresp(0);

	custom_output_adapt(0) <= sig_b;
	custom_output_adapt(size_custom_output_adapt -1 downto 1) <= std_logic_vector(sig_out_mux9);

	-- storage bit a
	store_a1: process (timing, sig_rst)
	begin
		if sig_rst = '1' then
			sig_a1 <= '0';
		elsif
		rising_edge(timing) then
			if sig_en_a1 = '1' then
				sig_a1 <= sig_in_a1;
			end if;
		end if;
	end process;


store_a0: process (timing, sig_rst)
	begin
		if sig_rst = '1' then
			sig_a0 <= '0';
		elsif
		rising_edge(timing) then
			if sig_en_a0 = '1' then
				sig_a0 <= sig_in_a0;
			end if;
		end if;
	end process;

	-- mux10
	sig_en_a1 <= sig_out1_demux4 when sig_a1 = '0' else
sig_out1_demux5;

	-- mux11
	sig_in_a1 <= '1' when sig_a1 = '0' else
'0';

	-- mux12
	sig_en_a0 <= sig_out0_demux4 when sig_a0 = '0' else
sig_out0_demux5;

	-- mux13
	sig_in_a0 <= '1' when sig_a0 = '0' else
'0';

	-- demux4
	demux4: process(sig_counter1, sig_addr)
	begin
		if sig_counter1 = '1' then
			sig_out1_demux4 <= sig_addr;
			sig_out0_demux4 <= '0';
		else
			sig_out0_demux4 <= sig_addr;
			sig_out1_demux4 <= '0';
		end if;
	end process;

	-- demux5
	demux5: process(sig_counter3, sig_b)
	begin
		if sig_counter3 = '1' then
			sig_out1_demux5 <= sig_b;
			sig_out0_demux5 <= '0';
		else
			sig_out0_demux5 <= sig_b;
			sig_out1_demux5 <= '0';
		end if;
	end process;

	-- storage bit w
	store_w0: process (timing, sig_rst)
	begin
		if sig_rst = '1' then
			sig_w0 <= '0';
		elsif
		rising_edge(timing) then
			if sig_en_w0 = '1' then
				sig_w0 <= sig_in_w0;
			end if;
		end if;
	end process;

	store_w1: process (timing, sig_rst)
	begin
		if sig_rst = '1' then
			sig_w1 <= '0';
		elsif
		rising_edge(timing) then
			if sig_en_w1 = '1' then
				sig_w1 <= sig_in_w1;
			end if;
		end if;
	end process;

	-- mux14
	sig_en_w1 <= sig_out1_demux6 when sig_w1 = '0' else
sig_out1_demux7;

	-- mux15
	sig_en_w0 <= sig_out0_demux6 when sig_w0 = '0' else
sig_out0_demux7;

	-- mux16
	sig_in_w1 <= '1' when sig_w1 = '0' else
'0';

	-- mux17
	sig_in_w0 <= '1' when sig_w0 = '0' else
'0';

	-- demux6
	demux6: process(sig_counter2, sig_wlast)
	begin
		if sig_counter2 = '1' then
			sig_out1_demux6 <= sig_wlast;
			sig_out0_demux6 <= '0';
		else
			sig_out0_demux6 <= sig_wlast;
			sig_out1_demux6 <= '0';
		end if;
	end process;

	-- demux7
	demux7: process(sig_counter3, sig_b)
	begin
		if sig_counter3 = '1' then
			sig_out1_demux7 <= sig_b;
			sig_out0_demux7 <= '0';
		else
			sig_out0_demux7 <= sig_b;
			sig_out1_demux7 <= '0';
		end if;
	end process;

	-- demux8
	demux8: process(sig_counter2, sig_event_ok)
	begin
		if sig_counter2 = '1' then
			sig_out1_demux8 <= sig_event_ok;
			sig_out0_demux8 <= '0';
		else
			sig_out0_demux8 <= sig_event_ok;
			sig_out1_demux8 <= '0';
		end if;
	end process;



-- storage awsize
	sig_awsize_1 <= to_unsigned(4,3);
	sig_awsize_0 <= to_unsigned(4,3);


-- generation of sig_wlast
	-- storage of awlen
	store_awlen0: process (timing, sig_rst)
	begin
		if sig_rst = '1' then
			sig_len0 <= (others => '0');
		elsif
		rising_edge(timing) then
			if sig_en_len0 = '1' then
				sig_len0 <= unsigned(awlen(3 downto 0));
			end if;
		end if;
	end process;

	store_awlen1: process (timing, sig_rst)
	begin
		if sig_rst = '1' then
			sig_len1 <= (others => '0');
		elsif
		rising_edge(timing) then
			if sig_en_len1 = '1' then
				sig_len1 <= unsigned(awlen(3 downto 0));
			end if;
		end if;
	end process;

	sig_len0_vec <= std_logic_vector(sig_len0);
	sig_len1_vec <= std_logic_vector(sig_len1);

	-- demux9
	demux9: process(sig_counter1, sig_addr)
	begin
		if sig_counter1 = '0' then
			sig_en_len0 <= sig_addr;
			sig_en_len1 <= '0';
		else
			sig_en_len1 <= sig_addr;
			sig_en_len0 <= '0';
		end if;
	end process;

	-- mux18
	sig_in2_comp1 <= sig_len0_vec when sig_counter2 = '0' else
sig_len1_vec;

	comp_eq1: component comp_prog
		generic map(
			dim_bus_g => 4
		)
		port map(
			data_in1 => sig_counter4_vec,
			data_in2 => sig_in2_comp1,
			sel      => "10",
			data_out => sig_out_comp1
		);
	
-- mux19
sig_out_mux19 <= sig_a0 when sig_counter2 = '0' else
sig_a1;

sig_wlast <= sig_out_comp1 and sig_out_mux19;


-- counter4
	inst_counter4: process (sig_rst, timing)
	begin
		if (sig_rst = '1') then
			sig_counter4 <= (others => '0');
		elsif rising_edge(timing) then
			if (sig_wlast = '1') then
				sig_counter4 <= (others => '0');
			elsif ((sig_out_mux19 and sig_wr) = '1') then
				sig_counter4 <= sig_counter4 + 1;
			end if;
		end if;
	end process;

	sig_counter4_vec <= std_logic_vector(sig_counter4);

    
    -- porto la size di increment a 32, ma la dovrò ridurre
    event_increment_new <= std_logic_vector(to_unsigned(to_integer(sig_out_mux8),32)); -- resize
    
    -- l'event data good è chiaramente il sig b
    event_data_good_new <= sig_b; -- when high, consider event_increment_new
    
    
    -- used to send data to be analyzed by the filter in dcapf
    event_data_new <= std_logic_vector(sig_in2_sum_addr);
    


end Behavioral;
