------------------------------------------------------------------------------------------------------------
-- File name   : input_port_16x8_sync.vhd
--
-- Project     : EELE367 - Logic Design
--               uCat Final Project
--
-- Description : 	
--
-- Author(s)   : 	Matthew Handley
--
-- Note(s)     : 
--               
--
------------------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.ALL;

entity input_port_16x8_sync is
  port(
    -- Synchronous Inputs
    clock         : in STD_LOGIC;
    reset         : in STD_LOGIC;
    
    -- input control
    address       : in STD_LOGIC_VECTOR(7 downto 0);
    write         : in STD_LOGIC;
    
    -- data input
    data_in_00    : in STD_LOGIC_VECTOR(7 downto 0);
    data_in_01    : in STD_LOGIC_VECTOR(7 downto 0);
    data_in_02    : in STD_LOGIC_VECTOR(7 downto 0);
    data_in_03    : in STD_LOGIC_VECTOR(7 downto 0);
    data_in_04    : in STD_LOGIC_VECTOR(7 downto 0);
    data_in_05    : in STD_LOGIC_VECTOR(7 downto 0);
    data_in_06    : in STD_LOGIC_VECTOR(7 downto 0);
    data_in_07    : in STD_LOGIC_VECTOR(7 downto 0);
    data_in_08    : in STD_LOGIC_VECTOR(7 downto 0);
    data_in_09    : in STD_LOGIC_VECTOR(7 downto 0);
    data_in_10    : in STD_LOGIC_VECTOR(7 downto 0);
    data_in_11    : in STD_LOGIC_VECTOR(7 downto 0);
    data_in_12    : in STD_LOGIC_VECTOR(7 downto 0);
    data_in_13    : in STD_LOGIC_VECTOR(7 downto 0);
    data_in_14    : in STD_LOGIC_VECTOR(7 downto 0);
    data_in_15    : in STD_LOGIC_VECTOR(7 downto 0);
    
    -- data output
    data_out      : out STD_LOGIC_VECTOR(7 downto 0)
  );
end entity;

architecture input_port_16x8_sync_arch of input_port_16x8_sync is


  begin 
    
    
end architecture;






