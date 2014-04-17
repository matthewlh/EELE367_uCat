------------------------------------------------------------------------------------------------------------
-- File name   : rw_96x8_sync.vhd
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
use IEEE.numeric_std.ALL;

entity rw_96x8_sync is
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

architecture rw_96x8_sync_arch of rw_96x8_sync is

	-- Constant Declaration
	constant START_ADDR	: integer := 128;

	-- Type Declaration
	type RW_type is array (0 to 96) of STD_LOGIC_VECTOR(7 downto 0);
  
	-- Signal Declaration
	signal RW : RW_type;
  
	begin
    
		Memory : process (clock)
			begin
				if(rising_edge(Clock)) then
					if(address >= x"80" and address <= x"DF") then
						if(write = '1') then
							RW(to_integer(unsigned(address)) - START_ADDR) <= Data_In;
						else
							Data_Out <= RW(to_integer(unsigned(address)) - START_ADDR);
						end if;
					end if;
				end if;
		end process;      
    
end architecture;

