------------------------------------------------------------------------------------------------------------
-- File name   : cpu_register.vhd
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cpu_register is 
	port(
    -- Synchronous Inputs
    clock         : in STD_LOGIC;
    reset         : in STD_LOGIC;
	 
	 -- control
	 load				: in STD_LOGIC;
	 increment		: in STD_LOGIC;
	 
	 -- IO
	 data_in			: in STD_LOGIC_VECTOR(7 downto 0);
	 data_out		: out STD_LOGIC_VECTOR(7 downto 0)
		
	);
end entity;

architecture cpu_register_arch of cpu_register is


	begin 
	
end architecture;