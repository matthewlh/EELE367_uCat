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
	
	-- Constants for Instruction mnemonics
	constant LDA_IMM  : std_logic_vector (7 downto 0) := x"86";   -- Load Register A with Immediate Addressing
	constant LDA_DIR  : std_logic_vector (7 downto 0) := x"87";   -- Load Register A with Direct Addressing
	constant STA_DIR  : std_logic_vector (7 downto 0) := x"96";   -- Store Register A to memory (RAM or IO)
	constant LDB_IMM  : std_logic_vector (7 downto 0) := x"88";   -- Load Register B with Immediate Addressing
	constant LDB_DIR  : std_logic_vector (7 downto 0) := x"89";   -- Load Register B with Direct Addressing
	constant STB_DIR  : std_logic_vector (7 downto 0) := x"97";   -- Store Register B to memory (RAM or IO)
	constant BRA      : std_logic_vector (7 downto 0) := x"20";   -- Branch Always                           
	constant BEQ      : std_logic_vector (7 downto 0) := x"21";   -- Branch if Equal to Zero
	constant ADD_AB   : std_logic_vector (7 downto 0) := x"42";   -- A <= A + B
	constant SUB_AB   : std_logic_vector (7 downto 0) := x"43";   -- A <= A - B
	constant AND_AB   : std_logic_vector (7 downto 0) := x"44";   -- A <= A and B
	constant OR_AB    : std_logic_vector (7 downto 0) := x"45";   -- A <= A or B
	constant INCA     : std_logic_vector (7 downto 0) := x"46";   -- A <= A + 1
	constant INCB     : std_logic_vector (7 downto 0) := x"47";   -- B <= B + 1
	constant DECA     : std_logic_vector (7 downto 0) := x"48";   -- A <= A - 1
	constant DECB     : std_logic_vector (7 downto 0) := x"49";   -- B <= B - 1
	
	constant ADDR_SW1	: std_logic_vector (7 downto 0) := x"F0";
	constant ADDR_SW2	: std_logic_vector (7 downto 0) := x"F1";
	constant ADDR_BTN	: std_logic_vector (7 downto 0) := x"F6";
	
	constant ADDR_LED_BLUE	: std_logic_vector (7 downto 0) := x"E0";
	constant ADDR_LED_RED	: std_logic_vector (7 downto 0) := x"E1";
	constant ADDR_LED_17_18	: std_logic_vector (7 downto 0) := x"E6";
	constant ADDR_LED_19_20	: std_logic_vector (7 downto 0) := x"E7";
	
	constant ADDR_VAR_Counter : std_logic_vector (7 downto 0) := x"80";	-- variable in RW memory
	
	-- Type Declaration
	type DATA_type is array (0 to 127) of STD_LOGIC_VECTOR(7 downto 0);
  
	-- Signal Declaration
	signal DATA : DATA_type := (
	
		-- Init VAR_Counter to 0x00 --
				0 => LDA_IMM,   		
				1 => x"01",     
				2 => STA_DIR,   		
				3 => ADDR_VAR_Counter,
			
		-- MainLoop --
				-- handle counter
				4 => LDA_DIR,   		-- load VAR_Counter into A
				5 => ADDR_VAR_Counter,
				
				6 => INCA,				-- Increment A and save back to VAR_Counter 
				7 => STA_DIR,
				8 => ADDR_VAR_Counter,
				
				9 => STA_DIR,			-- display VAR_Counter on LED17-18
			  10 => ADDR_LED_17_18,
			  
			  -- handle summer
			  11 => LDA_DIR,			-- Load A with SW1 value
			  12 => ADDR_SW1,
			  13 => LDB_DIR,			-- Load B with SW2 value
			  14 => ADDR_SW2,
			  
			  15 => STA_DIR,			-- Put SW1 and SW2 values on Red and Blue LEDs
			  16 => ADDR_LED_RED,
			  17 => STB_DIR,
			  18 => ADDR_LED_BLUE,
			  
			  19 => ADD_AB,			-- Add A to B
			  
			  20 => STA_DIR, 			-- store sum to LED19-20
			  21 => ADDR_LED_19_20,
			  
			  -- if result == 0x00, do something special
			  22 => BEQ,
			  23 => x"1A",
			  
			  -- else brand back to main loop
			  24 => BRA,
			  25 => x"04",
			  
		-- something special when result = 0x00
			  26 => LDA_IMM,			-- put 0xFF on LED17-18
			  27 => x"FF",
			  28 => STA_DIR,
			  29 => ADDR_LED_17_18,
			  
			  30 => BRA,				-- go back to main loop
			  31 => x"04",
				
			others => x"00"
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
