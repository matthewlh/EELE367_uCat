------------------------------------------------------------------------------------------------------------
-- File name   : rom_128x8_sync.vhd
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

entity rom_128x8_sync is
  port(
    -- Synchronous Inputs
    clock         : in STD_LOGIC;
    
    -- data inputs
    address       : in STD_LOGIC_VECTOR(7 downto 0);
    
    -- data output
    data_out      : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture rom_128x8_sync_arch of rom_128x8_sync is

	-- Constant Declaration
	constant START_ADDR	: integer := 0;
	
	-- Type Declaration
	type DATA_type is array (0 to 128) of STD_LOGIC_VECTOR(7 downto 0);
  
	-- Signal Declaration
	signal DATA : DATA_type := ( 	  0 => x"00",
											  1 => x"00",
											  2 => x"00",
											  3 => x"00",
											  4 => x"00",
											  5 => x"00",
											  6 => x"00",
											  7 => x"00",
											  8 => x"00",
											  9 => x"00",
											 10 => x"00",
											 11 => x"00",
											 12 => x"00",
											 13 => x"00",
											 14 => x"00",
											 15 => x"00",
											 16 => x"00",
											 17 => x"00",
											 18 => x"00",
											 19 => x"00",
											 20 => x"00",
											 21 => x"00",
											 22 => x"00",
											 23 => x"00",
											 24 => x"00",
											 25 => x"00",
											 26 => x"00",
											 27 => x"00",
											 28 => x"00",
											 29 => x"00",
											 30 => x"00",
											 31 => x"00",
											 32 => x"00",
											 33 => x"00",
											 34 => x"00",
											 35 => x"00",
											 36 => x"00",
											 37 => x"00",
											 38 => x"00",
											 39 => x"00",
											 40 => x"00",
											 41 => x"00",
											 42 => x"00",
											 43 => x"00",
											 44 => x"00",
											 45 => x"00",
											 46 => x"00",
											 47 => x"00",
											 48 => x"00",
											 49 => x"00",
											 50 => x"00",
											 51 => x"00",
											 52 => x"00",
											 53 => x"00",
											 54 => x"00",
											 55 => x"00",
											 56 => x"00",
											 57 => x"00",
											 58 => x"00",
											 59 => x"00",
											 60 => x"00",
											 61 => x"00",
											 62 => x"00",
											 63 => x"00",
											 64 => x"00",
											 65 => x"00",
											 66 => x"00",
											 67 => x"00",
											 68 => x"00",
											 69 => x"00",
											 70 => x"00",
											 71 => x"00",
											 72 => x"00",
											 73 => x"00",
											 74 => x"00",
											 75 => x"00",
											 76 => x"00",
											 77 => x"00",
											 78 => x"00",
											 79 => x"00",
											 80 => x"00",
											 81 => x"00",
											 82 => x"00",
											 83 => x"00",
											 84 => x"00",
											 85 => x"00",
											 86 => x"00",
											 87 => x"00",
											 88 => x"00",
											 89 => x"00",
											 90 => x"00",
											 91 => x"00",
											 92 => x"00",
											 93 => x"00",
											 94 => x"00",
											 95 => x"00",
											 96 => x"00",
											 97 => x"00",
											 98 => x"00",
											 99 => x"00",
											100 => x"00",
											101 => x"00",
											102 => x"00",
											103 => x"00",
											104 => x"00",
											105 => x"00",
											106 => x"00",
											107 => x"00",
											108 => x"00",
											109 => x"00",
											110 => x"00",
											111 => x"00",
											112 => x"00",
											113 => x"00",
											114 => x"00",
											115 => x"00",
											116 => x"00",
											117 => x"00",
											118 => x"00",
											119 => x"00",
											120 => x"00",
											121 => x"00",
											122 => x"00",
											123 => x"00",
											124 => x"00",
											125 => x"00",
											126 => x"00",
											127 => x"00",
											128 => x"00"
									); 
 
	begin
    
		-- processes
		Memory : process (clock)
			begin
				if(rising_edge(Clock)) then
					if(address >= x"00" and address <= x"7F") then
						Data_Out <= DATA(to_integer(unsigned(Address)) - START_ADDR);
					end if;
				end if;
		end process;
    
end architecture;