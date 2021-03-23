-------------------------------------------------------------------------------
-- testbench.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

-- START USER CODE (Do not remove this line)

-- User: Put your libraries here. Code in this
--       section will not be overwritten.

-- END USER CODE (Do not remove this line)

entity mb_tb is
end mb_tb;

architecture STRUCTURE of mb_tb is

  constant CLK_P_PERIOD : time := 5000.000000 ps;
  constant CLK_N_PERIOD : time := 5000.000000 ps;
  constant RESET_LENGTH : time := 80000 ps;


component design_1_wrapper
  port (    
    led_4bits_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    push_buttons_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    reset : in STD_LOGIC;
    sys_clock : in STD_LOGIC;
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC
  );
end component;

  -- Internal signals

  signal CLK_N : std_logic;
  signal CLK_P : std_logic;
  signal LEDs_8Bits_TRI_O : std_logic_vector(7 downto 0);
  signal RESET : std_logic;
  signal RS232_Uart_1_sin : std_logic;
  signal RS232_Uart_1_sout : std_logic;
  signal sig_push_buttons_4bits_tri_i: std_logic_vector (3 downto 0) := (others => '0');
  signal sig_led_4bits_tri_o: std_logic_vector (3 downto 0);
  signal sig_sys_clock: std_logic;
  
  
  -- START USER CODE (Do not remove this line)

  -- User: Put your signals here. Code in this
  --       section will not be overwritten.

  -- END USER CODE (Do not remove this line)

begin



  dut : design_1_wrapper
    port map (
    led_4bits_tri_o => sig_led_4bits_tri_o,
    push_buttons_4bits_tri_i => sig_push_buttons_4bits_tri_i,
    sys_clock => sig_sys_clock,
      RESET => RESET,
      usb_uart_rxd => RS232_Uart_1_sin,
      usb_uart_txd => RS232_Uart_1_sout
    );

  -- Clock generator for sig_sys_clock

  process
  begin
    sig_sys_clock <= '0';
    loop
      wait for (CLK_P_PERIOD/2);
      sig_sys_clock <= not sig_sys_clock;
    end loop;
  end process;



  -- Reset Generator for RESET

  process
  begin
    RESET <= '0';
    wait for (RESET_LENGTH);
    RESET <= not RESET;
    wait;
  end process;

  -- START USER CODE (Do not remove this line)

  -- User: Put your stimulus here. Code in this
  --       section will not be overwritten.

  -- END USER CODE (Do not remove this line)

end architecture STRUCTURE;
