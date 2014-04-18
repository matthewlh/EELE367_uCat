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
use IEEE.numeric_std.ALL;

entity input_port_16x8_sync is
  port(
    -- Synchronous Inputs
    clock         : in STD_LOGIC;
    reset         : in STD_LOGIC;
    
    -- input control
    address       : in STD_LOGIC_VECTOR(7 downto 0);
    read         	: in STD_LOGIC;
    
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

	-- Constant Declaration
	constant START_ADDR	: integer := 240;

	-- Type Declaration
	type RW_type is array (0 to 16) of STD_LOGIC_VECTOR(7 downto 0);
  
	-- Signal Declaration
	signal RW : RW_type;
  
	begin
    
		Memory : process (clock, reset)
			begin
				if(reset = '0') then
					data_out <= x"00";
				elsif(rising_edge(Clock)) then
					if(address >= x"F0" and address <= x"FF") then
						if(read = '1') then
							data_out <= RW(to_integer(unsigned(address)) - START_ADDR);
						end if;
					end if;
				end if;
		end process; 
		
		RW(0) <= data_in_00;
		RW(1) <= data_in_01;
		RW(2) <= data_in_02;
		RW(3) <= data_in_03;
		RW(4) <= data_in_04;
		RW(5) <= data_in_05;
		RW(6) <= data_in_06;
		RW(7) <= data_in_07;
		RW(8) <= data_in_08;
		RW(9) <= data_in_09;
		RW(10) <= data_in_10;
		RW(11) <= data_in_11;
		RW(12) <= data_in_12;
		RW(13) <= data_in_13;
		RW(14) <= data_in_14;
		RW(15) <= data_in_15;
	 
end architecture;






