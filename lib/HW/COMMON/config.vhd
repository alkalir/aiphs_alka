library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package config is

-- Parameters of Axi Slave Bus Interface S00_AXI
constant axi_data_width	: integer	:= 32;
constant axi_addr_width	: integer	:= 6;
		
------ sniffer for Microblaze AXI 
constant AXI_sniffer_en: integer := 1;
-- starting from the LSB
-- 0 bit is event data manager yes or not
-- 1 bit is for the time monitor yes or not
-- 2 bit is for the event monitor yes or not
constant DCAPF_AXI_CONFIG: unsigned(4 downto 0) := "01011";
-- starting from the LSB
-- 0 bit is for core_observe yes or not
-- 1 bit is for timing_capturer block yes or not
-- 2 bit is for catcher block yes or not
-- 3 bit is for acknowledger block yes or not
constant TIMEMON_AXI_CONFIG: unsigned(4 downto 0) := "11101";
constant TIMEMON_AXI_ACKSIZE_CONFIG: positive := 5;
constant size_AXI_count_out_event: integer := 64;
constant size_AXI_count_out_time: integer := 64;
constant size_AXI_sniffer_id: integer := 2;
constant size_AXI_event_attr: integer := 8;
constant size_AXI_metricID: integer := 2;
constant size_AXI_sniffer_result: integer := size_AXI_count_out_event + size_AXI_count_out_time + size_AXI_sniffer_id + size_AXI_event_attr + size_AXI_metricID;







------ sniffer for Microblaze trace port
constant MBTP_sniffer_en: integer := 0;
constant DCAPF_MBTP_CONFIG: unsigned(4 downto 0) := "00011";
-- starting from the LSB
-- 0 bit is for core_observe yes or not
-- 1 bit is for timing_capturer block yes or not
-- 2 bit is for catcher block yes or not
-- 3 bit is for acknowledger block yes or not
constant TIMEMON_MBTP_CONFIG: unsigned(4 downto 0) := "01101";
constant TIMEMON_MBTP_ACKSIZE_CONFIG: positive := 1;
constant size_MBTP_count_out_event: integer := 64;
constant size_MBTP_count_out_time: integer := 64;
constant size_MBTP_sniffer_id: integer := 2;
constant size_MBTP_event_attr: integer := 2;
constant size_MBTP_metricID: integer := 2;
constant size_MBTP_sniffer_result: integer := size_MBTP_count_out_event + size_MBTP_count_out_time + size_MBTP_sniffer_id + size_MBTP_event_attr + size_MBTP_metricID;



-- compute values for lmic1
constant size1_DCI: integer := 2+size_MBTP_sniffer_result + 2+size_AXI_sniffer_result;




--- other values

constant MON_1ST : integer := 0;
constant mon_2nd : integer := 0;
constant mon_3rd : integer := 0;

-- first level parts
constant EN_EVMON_1ST: integer := 1;
constant EN_TIMEMON_1ST: integer := 0;
constant EN_CUSTOM_PART_1ST: integer := 0;

-- second level parts
constant EN_EVMON_2ND: integer := 0;
constant EN_TIMEMON_2ND: integer := 1;
constant EN_CUSTOM_PART_2ND: integer := 0;

-- third level parts
constant EN_EVMON_3RD: integer := 0;
constant EN_TIMEMON_3RD: integer := 0;
constant EN_CUSTOM_PART_3RD: integer := 1;

-- id area
constant EVENT_ATTR: std_logic_vector(4 downto 0) := "11100"; --1C
constant ACC_ID: std_logic_vector(3 downto 0) := "0001";


----- new
-- development of third level
constant EN_CUSTOM_PART_VAL : integer := 1;
constant NUM_EVENTS : integer := 4;
type array_of_integers is array(natural range <>) of integer;

-- tipo che definisce il banco di registri per il terzo livello
constant NUM_REGS_THIRD: natural := 9; 
constant SIZE_THIRD: natural := 32; 

type out_third is array (NUM_REGS_THIRD-1 downto 0) of
    std_logic_vector(SIZE_THIRD-1 downto 0);


-- numero del registro relativo associato allo storage del risultato di ogni evento
constant NRR_VAL: array_of_integers := (1, 1, 2); --richiesta all'utente

-- size del risultato associata ad ogni evento, deve essere multiplo di 5 (in realtà non necessariamente, può essere anche non multiplo di 5, ma da testare)
constant SIZE_COUNTERS_VAL: array_of_integers := (5, 10, 15); --richiesta all'utente

-- array a stessa size del numero di eventi, quindi a stessa size degli array NRR_VAL e SIZE_COUNTERS_VAL, in cui ogni posizione contiene
-- la somma degli elementi precedenti più quello di quella posizione
constant SUM_PREVIOUS_VAL: array_of_integers := (5, 15, 30); -- calcolata da python
  
-- array con dimensione sempre fissa a 9 elementi (cioè numero di registri relativi sul quale possiamo scrivere i risultati del terzo livello)
-- che contiene la somma delle dimensioni associate a ogni relative register. Quindi per esempio in questo caso nel relative register 1 abbiamo 5 + 10 = 15, nel 2 abbiamo 15.
-- Questo lo si può notare dall'array NRR_VAL comparato con l'array SIZE_COUNTERS_VAL.
constant SUM_RR_VAL: array_of_integers := (15, 15, 0, 0, 0, 0, 0, 0, 0); -- calcolata da python

-- array a dimensione sempre di 9 elementi 
-- che contiene il valore di SUM_RR_VAL incrementato di 1, ma solo per i valori diversi da 0. Quelli uguali a 0 restano 0.
constant MISS_21_VAL: array_of_integers := (16, 16, 0, 0, 0, 0, 0, 0, 0); -- calcolata da python


-- array di 9 elementi (come il numero di relative registers) che contiene l'ultimo elemento dell'array SUM_PREVIOUS_VAL associato ad ogni relative register.
-- Per ex, 15 è l'ultimo elemento associato a NRR=1, 30 è l'ultimo elemento associato a NRR=2 (lo si capisce comparando NRR_VAL e SUM_PREVIOUS_VAL)
constant LAST_NRR_VAL: array_of_integers := (15, 30, 0, 0, 0, 0, 0, 0, 0); -- calcolata da python



end;