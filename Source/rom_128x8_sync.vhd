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
				0      => LDA_IMM,  -- testing Load A Imm
				1      => x"AA",     
				2      => STA_DIR,  -- testing Store A Dir (Port Out 00)
				3      => x"E0",  
				4      => LDA_IMM,  -- testing Load A Imm
				5      => x"CC",     
				6      => STA_DIR,  -- testing Store A Dir (Port Out 01)
				7      => x"E1", 
				8      => BRA,      -- testing Branch Always
				9      => x"00",
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
