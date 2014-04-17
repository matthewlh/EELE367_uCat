library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity bcd_decoder is 
	port(
		Binary_In		: in   STD_LOGIC_VECTOR(6 downto 0);
		Dec_Upper_Out	: out  STD_LOGIC_VECTOR(3 downto 0);
		Dec_Lower_Out	: out  STD_LOGIC_VECTOR(3 downto 0)
	);	  
end entity;

architecture bcd_decoder_arch  of bcd_decoder is

	signal Binary_In_Int 	: integer range 0 to 99;

	begin

		Binary_In_Int <= to_integer(unsigned(Binary_In));
		
		Dec_Upper_Out <= std_logic_vector(to_unsigned((Binary_In_Int  /  10), 4));
		Dec_Lower_Out <= std_logic_vector(to_unsigned((Binary_In_Int mod 10), 4));
	
end architecture;