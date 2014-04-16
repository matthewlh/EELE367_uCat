------------------------------------------------------------------------------------------------------------
-- File name   : cpu.vhd
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

entity cpu is
  port(
    -- Synchronous Inputs
    clock         : in STD_LOGIC;
    reset         : in STD_LOGIC;
    
    -- Inputs
    from_memory   : in STD_LOGIC_VECTOR(7 downto 0);
      
    -- Outputs 
    address       : out STD_LOGIC_VECTOR(7 downto 0);
    write         : out STD_LOGIC;
    to_memory     : out STD_LOGIC_VECTOR(7 downto 0)
  );
end entity;

architecture cpu_arch of cpu is


  begin 
    
    
end architecture;

