------------------------------------------------------------------------------------------------------------
-- File name   : top.vhd
--
-- Project     : EELE367 - Logic Design
--               uCat Final Project
--
-- Description : Quartus top file for used with DE0-Nano	
--
-- Author(s)   : 	Matthew Handley
--
-- Note(s)     : 
--               
--
------------------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity top is 
	port(
		CLK			: in  STD_LOGIC;							--50 MHz clock on DE0 Nano
		DIP			: in	STD_LOGIC_VECTOR(1 downto 0);	--DIP switch on top of DE0 Nano
		RST   		: in  STD_LOGIC;							--Reset Button
		SW1			: in	STD_LOGIC_VECTOR(7 downto 0);	--DIP Switch 1 input
		SW2			: in	STD_LOGIC_VECTOR(7 downto 0);	--DIP Switch 2 input
		KEY1        : in  STD_LOGIC;                    -- Button on DE0 Nano
		LED_Red		: out	STD_LOGIC_VECTOR(7 downto 0);	--Red LEDs
		LED_Blue		: out	STD_LOGIC_VECTOR(7 downto 0);	--Blue LEDs
		LED17			: out	STD_LOGIC_VECTOR(7 downto 0);	--Seven Segment LEDs + Decimal
		LED18			: out	STD_LOGIC_VECTOR(7 downto 0);	--Seven Segment LEDs + Decimal
		LED19			: out	STD_LOGIC_VECTOR(7 downto 0);	--Seven Segment LEDs + Decimal
		LED20			: out	STD_LOGIC_VECTOR(7 downto 0) 	--Seven Segment LEDs + Decimal
	);
end entity;

architecture top_arch of top is

	-- signal declaration	
	signal	Clock_Divided 	: STD_LOGIC;
	
	signal port_out_02					: STD_LOGIC_VECTOR(7 downto 0);
	signal port_out_06_to_decoder		: STD_LOGIC_VECTOR(7 downto 0);
	signal port_out_07_to_decoder		: STD_LOGIC_VECTOR(7 downto 0);
	

	-- component declaration
	component ucat is 
		Port(
		-- Synchronous Inputs
		 clock         : in STD_LOGIC;
		 reset         : in STD_LOGIC;
		 
		 -- Input ports
		 port_in_00    : in STD_LOGIC_VECTOR(7 downto 0);
		 port_in_01    : in STD_LOGIC_VECTOR(7 downto 0);
		 port_in_02    : in STD_LOGIC_VECTOR(7 downto 0);
		 port_in_03    : in STD_LOGIC_VECTOR(7 downto 0);
		 port_in_04    : in STD_LOGIC_VECTOR(7 downto 0);
		 port_in_05    : in STD_LOGIC_VECTOR(7 downto 0);
		 port_in_06    : in STD_LOGIC_VECTOR(7 downto 0);
		 port_in_07    : in STD_LOGIC_VECTOR(7 downto 0);
		 port_in_08    : in STD_LOGIC_VECTOR(7 downto 0);
		 port_in_09    : in STD_LOGIC_VECTOR(7 downto 0);
		 port_in_10    : in STD_LOGIC_VECTOR(7 downto 0);
		 port_in_11    : in STD_LOGIC_VECTOR(7 downto 0);
		 port_in_12    : in STD_LOGIC_VECTOR(7 downto 0);
		 port_in_13    : in STD_LOGIC_VECTOR(7 downto 0);
		 port_in_14    : in STD_LOGIC_VECTOR(7 downto 0);
		 port_in_15    : in STD_LOGIC_VECTOR(7 downto 0);
			
		 -- Output ports    
		 port_out_00   : out STD_LOGIC_VECTOR(7 downto 0);
		 port_out_01   : out STD_LOGIC_VECTOR(7 downto 0);
		 port_out_02   : out STD_LOGIC_VECTOR(7 downto 0);
		 port_out_03   : out STD_LOGIC_VECTOR(7 downto 0);
		 port_out_04   : out STD_LOGIC_VECTOR(7 downto 0);
		 port_out_05   : out STD_LOGIC_VECTOR(7 downto 0);
		 port_out_06   : out STD_LOGIC_VECTOR(7 downto 0);
		 port_out_07   : out STD_LOGIC_VECTOR(7 downto 0);
		 port_out_08   : out STD_LOGIC_VECTOR(7 downto 0);
		 port_out_09   : out STD_LOGIC_VECTOR(7 downto 0);
		 port_out_10   : out STD_LOGIC_VECTOR(7 downto 0);
		 port_out_11   : out STD_LOGIC_VECTOR(7 downto 0);
		 port_out_12   : out STD_LOGIC_VECTOR(7 downto 0);
		 port_out_13   : out STD_LOGIC_VECTOR(7 downto 0);
		 port_out_14   : out STD_LOGIC_VECTOR(7 downto 0);
		 port_out_15   : out STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;
	
	component clock_div is
		Port
		( 
			Clock_in		: in	STD_LOGIC;
			Reset			: in	STD_LOGIC;
			Sel			: in	STD_LOGIC_VECTOR(1 downto 0);
			Clock_out	: out	STD_LOGIC
		);
	end component;
	
	component character_decoder_16 is
	   port (INPUT_CODE         : in  STD_LOGIC_VECTOR(3 downto 0);
				Decimal_Point		 : in STD_LOGIC;
	         OUTPUT_DISPLAY     : out STD_LOGIC_VECTOR(7 downto 0));
   end component;

	begin
	
		-- component instantiation	
		Divider	: clock_div
		port map
		(
			Clock_in		=> CLK,
			Reset			=> RST,
			Sel			=> DIP(1 downto 0),
			Clock_out	=> Clock_Divided
		);
		
		Char20 : character_decoder_16
		port map
		(
		  INPUT_CODE => port_out_07_to_decoder(3 downto 0),
		  Decimal_Point => port_out_02(0),
		  OUTPUT_DISPLAY => LED20
		);
		
		Char19 : character_decoder_16
		port map
		(
		  INPUT_CODE => port_out_07_to_decoder(7 downto 4),
		  Decimal_Point => port_out_02(1),
		  OUTPUT_DISPLAY => LED19
		);
		
		Char18 : character_decoder_16
		port map
		(
		  INPUT_CODE => port_out_06_to_decoder(3 downto 0),
		  Decimal_Point => port_out_02(2),
		  OUTPUT_DISPLAY => LED18
		);
		
		Char17 : character_decoder_16
		port map
		(
		  INPUT_CODE => port_out_06_to_decoder(7 downto 4),
		  Decimal_Point=> port_out_02(3),
		  OUTPUT_DISPLAY => LED17
		);
		
		ucat_top	: ucat
		port map
		(
			clock				=> Clock_Divided,
			reset				=> RST,
		
			Port_in_00		=> SW1,
			Port_in_01		=> SW2,
			Port_in_02		=> x"00",
			Port_in_03		=> x"00",
			Port_in_04		=> x"00",
			Port_in_05		=> x"00",
			Port_in_06		=> "0000000" & key1,
			Port_in_07		=> x"00",
			Port_in_08		=> x"00",
			Port_in_09		=> x"00",
			Port_in_10		=> x"00",
			Port_in_11		=> x"00",
			Port_in_12		=> x"00",
			Port_in_13		=> x"00",
			Port_in_14		=> x"00",
			Port_in_15		=> x"00",
			
			Port_out_00		=> LED_Blue,
			Port_out_01		=> LED_Red,
			Port_out_02		=> port_out_02,
			Port_out_03		=> open,
			Port_out_04		=> open,
			Port_out_05		=> open,
			Port_out_06 	=> port_out_06_to_decoder,
			Port_out_07 	=> port_out_07_to_decoder,
			Port_out_08 	=> open,
			Port_out_09 	=> open,
			Port_out_10 	=> open,
			Port_out_11 	=> open,
			Port_out_12 	=> open,
			Port_out_13 	=> open,
			Port_out_14 	=> open,
			Port_out_15 	=> open
			
		);
	
	
end architecture;
