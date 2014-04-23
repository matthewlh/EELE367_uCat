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
		
		N <= result(7);
		Z <= '1' when(result(7 downto 0) = x"00") else '0';		
		V <= '1' when (((ALU_Sel = ALU_Sel_ADD) AND (A(7) = '0') AND (B(7) = '0') and (result(7) = '1')) OR  	-- (+) + (+) = -
                     ((ALU_Sel = ALU_Sel_ADD) AND (A(7) = '1') AND (B(7) = '1') and (result(7) = '0')) OR	-- (-) + (-) = +
                     ((ALU_Sel = ALU_Sel_SUB) AND (A(7) = '1') AND (B(7) = '0') and (result(7) = '0'))) 		-- (-) - (+) = +
				else '0';				
		C <= result(8);
					
		data_out <= STD_LOGIC_VECTOR(result(7 downto 0));
		
		CCR_out <= N & Z & V & C;
	
end architecture;