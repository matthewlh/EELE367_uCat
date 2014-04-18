------------------------------------------------------------------------------------------------------------
-- File name   : output_port_16x8_sync.vhd
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

entity output_port_16x8_sync is
  port(
    -- Synchronous Inputs
    clock         : in STD_LOGIC;
    reset         : in STD_LOGIC;
    
    -- data inputs
    address       : in STD_LOGIC_VECTOR(7 downto 0);
    data_in       : in STD_LOGIC_VECTOR(7 downto 0);
    write         : in STD_LOGIC;
    
    -- data output
    data_out_00      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_01      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_02      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_03      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_04      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_05      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_06      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_07      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_08      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_09      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_10      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_11      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_12      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_13      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_14      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_15      : out STD_LOGIC_VECTOR(7 downto 0)
  );
end entity;

architecture output_port_16x8_sync_arch of output_port_16x8_sync is

	-- Constant Declaration
	constant START_ADDR	: integer := 224;

	-- Type Declaration
	type RW_type is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
  
	-- Signal Declaration
	signal RW : RW_type;
  
	begin
    
		Memory : process (clock, reset)
			begin
				if(reset = '0') then 
					RW <= (others => x"00");
				elsif(rising_edge(Clock)) then
					if(address >= x"E0" and address <= x"EF") then
						if(write = '1') then
							RW(to_integer(unsigned(address)) - START_ADDR) <= Data_In;
						end if;
					end if;
				end if;
		end process; 
		
		data_out_00 <= RW(0);
		data_out_01 <= RW(1);
		data_out_02 <= RW(2);
		data_out_03 <= RW(3);
		data_out_04 <= RW(4);
		data_out_05 <= RW(5);
		data_out_06 <= RW(6);
		data_out_07 <= RW(7);
		data_out_08 <= RW(8);
		data_out_09 <= RW(9);
		data_out_10 <= RW(10);
		data_out_11 <= RW(11);
		data_out_12 <= RW(12);
		data_out_13 <= RW(13);
		data_out_14 <= RW(14);
		data_out_15 <= RW(15);
		
end architecture;





