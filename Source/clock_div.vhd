------------------------------------------------------------------------------------------------------------
-- File name   : clock_div.vhd
--
-- Project     : EELE367 - Logic Design
--               DE0-Nano Lab 5 Selectable Clock Divider and a Binary Character Count
--
-- Description : 	
--               
--
-- Author(s)   : 	Matthew Handley
--						David Keltgen
--               	Montana State University
--
-- Note(s)     : 
--               
--
------------------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity clock_div is
	Port
	( 
		Clock_in		: in	STD_LOGIC;
		Reset			: in	STD_LOGIC;
		Sel			: in	STD_LOGIC_VECTOR(1 downto 0);
		Clock_out	: out	STD_LOGIC
	);	
end clock_div;


architecture clock_div_arch of clock_div is

------------------------------------------------------------------------------------
--Component Declaration
	
signal CLK_div: STD_LOGIC;
signal CLK_cnt: integer range 0 to 25000000;
signal CLK_cmp: integer range 25000 to 25000000;

begin

SELproc : process(Sel)
	begin 
	if(Sel = "00") then
	 CLK_cmp <= 25000000;
	elsif(Sel = "01") then
	 CLK_cmp <= 2500000;
	elsif(Sel = "10") then 
	 CLK_cmp <= 250000;
	else
	 CLK_cmp <= 25000;
	end if;
end process;
    
Tproc: process (Clock_in, Reset)
	 begin
		if (Reset = '0') then
		 CLK_cnt <= 0;
		 CLK_div <= '0';
		elsif (rising_edge(Clock_in)) then
       if(CLK_cnt >= CLK_cmp) then
		  CLK_cnt <= 0;
		  CLK_div <= not CLK_div;
		 else
		  CLK_cnt <= CLK_cnt + 1;
		 end if;
		end if;
	end process;
	
Clock_out <= CLK_div;
 

end clock_div_arch;