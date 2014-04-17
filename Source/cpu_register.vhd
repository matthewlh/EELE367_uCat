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

	-- signal declaration
	signal data : STD_LOGIC_VECTOR(7 downto 0);

	begin 
	
		proc : process(clock, reset)
			begin
				if(reset = '0') then 
					data	<= x"00";
				elsif(rising_edge(clock)) then 
					if(load = '1') then 
						data <= data_in;
					end if;
					
					if(increment = '1') then 
						data <= STD_LOGIC_VECTOR(UNSIGNED(data) + 1);
					end if;
				end if;			
		end process;
		
		data_out <= data;
	
end architecture;