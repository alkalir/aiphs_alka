library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package config is

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
