
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity character_decoder_16 is 
port(INPUT_CODE: in STD_LOGIC_VECTOR(3 downto 0);
     Decimal_Point: in STD_LOGIC;
	  OUTPUT_DISPLAY: out STD_LOGIC_VECTOR(7 downto 0));
	  
end entity;

architecture character_decoder_16_arch  of character_decoder_16 is

begin

--Processes


CASE_Proc : process (INPUT_CODE, Decimal_Point)
	begin
	
	   case (INPUT_CODE) is
		   
			when x"0" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"FC"; else OUTPUT_DISPLAY <= x"FD"; end if; -- when (Decimal_Point = '0') else x"FD";
			when x"1" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"60"; else OUTPUT_DISPLAY <= x"61"; end if;
			when x"2" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"DA"; else OUTPUT_DISPLAY <= x"DB"; end if;
			when x"3" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"F2"; else OUTPUT_DISPLAY <= x"F3"; end if;
			when x"4" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"66"; else OUTPUT_DISPLAY <= x"67"; end if;
			when x"5" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"B6"; else OUTPUT_DISPLAY <= x"B7"; end if;
			when x"6" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"BE"; else OUTPUT_DISPLAY <= x"BF"; end if;
			when x"7" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"E0"; else OUTPUT_DISPLAY <= x"E1"; end if;
			when x"8" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"FE"; else OUTPUT_DISPLAY <= x"FF"; end if;
			when x"9" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"F6"; else OUTPUT_DISPLAY <= x"F7"; end if;
			when x"A" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"EE"; else OUTPUT_DISPLAY <= x"EF"; end if;
			when x"B" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"3E"; else OUTPUT_DISPLAY <= x"3F"; end if;
			when x"C" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"1A"; else OUTPUT_DISPLAY <= x"1B"; end if;
			when x"D" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"7A"; else OUTPUT_DISPLAY <= x"7B"; end if;
			when x"E" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"9E"; else OUTPUT_DISPLAY <= x"9F"; end if;
			when x"F" => if(Decimal_Point = '0') then OUTPUT_DISPLAY <= x"8E"; else OUTPUT_DISPLAY <= x"8F"; end if;
		end case;
		
	end process;
	
end architecture;
			

	  
		