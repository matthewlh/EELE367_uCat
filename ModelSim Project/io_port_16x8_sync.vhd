------------------------------------------------------------------------------------------------------------
-- File name   : io_port_16x8_sync.vhd
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

entity io_port_16x8_sync is
  port(
    -- Synchronous Inputs
    clock         : in STD_LOGIC;
    reset         : in STD_LOGIC;
    
    -- data inputs
    address       : in STD_LOGIC_VECTOR(7 downto 0);
    data_in       : in STD_LOGIC_VECTOR(7 downto 0);
    write         : in STD_LOGIC;
    
    -- data output
    data_out      : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture io_port_16x8_sync_arch of io_port_16x8_sync is


  begin 
    
    
end architecture;



