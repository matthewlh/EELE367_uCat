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
	
	-- Type Declaration
	type DATA_type is array (0 to 127) of STD_LOGIC_VECTOR(7 downto 0);
  
	-- Signal Declaration
	signal DATA : DATA_type := (
				0 => LDA_IMM,   -- testing Load A Imm
				1 => x"AA",     
				2 => STA_DIR,   -- testing Store A Dir (Port Out 00)
				3 => x"E0",  
				4 => LDA_IMM,   -- testing Load A Imm
				5 => x"CC",     
				6 => STA_DIR,   -- testing Store A Dir (Port Out 01)
				7 => x"E1",
				
				8 => LDA_DIR,   -- Test Load A Dir
				9 => x"F1",     -- load from port in 01
				
			 10 => STA_DIR,   -- store value from port in 00 in A ,
			 11 => x"E6",     -- to port out 06 (LED17 and 18)
			 
			 12 => LDB_IMM,   -- test load B Imm
			 13 => x"DD",
			 
			 14 => STB_DIR,   -- test store B dir
			 15 => x"E7",
				
			 16 => LDB_DIR,   -- test load B Dir
			 17 => x"F2",
			 
			 18 => STB_DIR,
			 19 => x"E7",
			 
			 20 => BEQ,       -- test BEQ by skipping over the following load and store if Z = '1'
			 21 => x"24",     -- 0x1A = 26
			 
			 22 => LDA_IMM,   -- Load A Imm
			 23 => x"FF",     
			 24 => STA_DIR,   -- testing Store A Dir (Port Out 00)
			 25 => x"E0", 
			 
			 26 => ADD_AB,	  -- Test ALU instructions
			 27 => SUB_AB,
			 28 => AND_AB,
			 29 => OR_AB,
			 
			 30 => INCA,
			 31 => DECA,
			 32 => INCB,
			 33 => DECB,
			 
			 34 => BRA,       -- testing Branch Always
			 35 => x"00",     -- branch to start of program
				
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
