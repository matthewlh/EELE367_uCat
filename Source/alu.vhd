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
	constant ALU_Sel_INCA	: STD_LOGIC_VECTOR(2 downto 0) := "100";
	constant ALU_Sel_DECA	: STD_LOGIC_VECTOR(2 downto 0) := "101";
	constant ALU_Sel_INCB	: STD_LOGIC_VECTOR(2 downto 0) := "110";
	constant ALU_Sel_DECB	: STD_LOGIC_VECTOR(2 downto 0) := "111";
	
	-- signal declaration
	signal A_uns				: unsigned(8 downto 0);
	signal B_uns				: unsigned(8 downto 0);
	signal result				: unsigned(8 downto 0);
	
	signal N						: STD_LOGIC;
	signal Z						: STD_LOGIC;
	signal V						: STD_LOGIC;
	signal C						: STD_LOGIC;
	
	begin
	
		A_uns <= '0' & unsigned(A);
		B_uns <= '0' & unsigned(B);
	
		proc : process(ALU_Sel, A_uns, B_uns)
			begin
				if(ALU_Sel = ALU_Sel_ADD) then 
					result <= A_uns + B_uns;
				elsif(ALU_Sel = ALU_Sel_SUB) then 
					result <= A_uns - B_uns;
				elsif(ALU_Sel = ALU_Sel_AND) then 
					result <= A_uns AND B_uns;
				elsif(ALU_Sel = ALU_Sel_OR) then 
					result <= A_uns OR B_uns;
				elsif(ALU_Sel = ALU_Sel_INCA) then 
					result <= A_uns +1;
				elsif(ALU_Sel = ALU_Sel_DECA) then 
					result <= A_uns -1;
				elsif(ALU_Sel = ALU_Sel_INCB) then 
					result <= B_uns +1;
				elsif(ALU_Sel = ALU_Sel_DECB) then 
					result <= B_uns -1;					
				end if;
		end process;
		
		N <= '0';
		Z <= '0';
		V <= '0';
		C <= '0';
					
		data_out <= STD_LOGIC_VECTOR(result(7 downto 0));
		
		CCR_out <= N & Z & V & C;
	
end architecture;