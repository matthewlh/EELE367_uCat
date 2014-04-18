------------------------------------------------------------------------------------------------------------
-- File name   : alu.vhd
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

entity alu is 
	port(
		-- Synchronous Inputs
		clock         : in STD_LOGIC;
		reset         : in STD_LOGIC;
	 
		-- control
		ALU_Sel			: in STD_LOGIC_VECTOR(2 downto 0);
	 
		-- Inputs
		A					: in STD_LOGIC_VECTOR(7 downto 0);
		B					: in STD_LOGIC_VECTOR(7 downto 0);
	 
		-- Outputs
		data_out		: out STD_LOGIC_VECTOR(7 downto 0);
		CCR_out			: out STD_LOGIC_VECTOR(3 downto 0)
		
	);
end entity;

architecture alu_arch of alu is

	-- constant declaration
	constant ALU_Sel_ADD		: STD_LOGIC_VECTOR(2 downto 0) := "000";
	constant ALU_Sel_SUB		: STD_LOGIC_VECTOR(2 downto 0) := "001";
	constant ALU_Sel_AND		: STD_LOGIC_VECTOR(2 downto 0) := "010";
	constant ALU_Sel_OR		: STD_LOGIC_VECTOR(2 downto 0) := "011";
	constant ALU_Sel_INC		: STD_LOGIC_VECTOR(2 downto 0) := "100";
	constant ALU_Sel_DEC		: STD_LOGIC_VECTOR(2 downto 0) := "101";
	
	-- signal declaration
	signal N						: STD_LOGIC;
	signal Z						: STD_LOGIC;
	signal V						: STD_LOGIC;
	signal C						: STD_LOGIC;
	
	begin
	
		proc : process(clock, reset)
			begin
				if(reset = '0') then 
					N <= '0';
					Z <= '0';
					V <= '0';
					C <= '0';
					data_out <= x"00";
				end if;
		end process;
	
end architecture;