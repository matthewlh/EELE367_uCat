------------------------------------------------------------------------------------------------------------
-- File name   : processing_unit.vhd
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

entity processing_unit is
  port( 
    -- Synchronous Inputs
    clock       : in  STD_LOGIC;
    reset       : in  STD_LOGIC;
    
    -- Data IO control
    from_memory : in  STD_LOGIC_VECTOR (7 downto 0);             
    to_memory   : out STD_LOGIC_VECTOR (7 downto 0);
    address     : out STD_LOGIC_VECTOR (7 downto 0);
    
    IR_Load     : in  STD_LOGIC;
    IR          : out STD_LOGIC_VECTOR (7 downto 0);
    
    MAR_Load    : in  STD_LOGIC;             
    
    PC_Load     : in  STD_LOGIC;
    PC_Inc      : in  STD_LOGIC;             
    
    A_Load      : in  STD_LOGIC;
    B_Load      : in  STD_LOGIC;             
    
    ALU_Sel     : in  STD_LOGIC_VECTOR (2 downto 0);             
    
    CCR_Result  : out STD_LOGIC_VECTOR (3 downto 0);
    CCR_Load    : in  STD_LOGIC;             
    
    Bus1_Sel    : in  STD_LOGIC_VECTOR (1 downto 0);                          
    Bus2_Sel    : in  STD_LOGIC_VECTOR (1 downto 0)
  );                            
end entity;

architecture processing_unit_arch of processing_unit is

	-- signal declaration
	signal	BUS2 			: STD_LOGIC_VECTOR(7 downto 0);
	signal	BUS1 			: STD_LOGIC_VECTOR(7 downto 0);
	
	signal	PC_out		          : STD_LOGIC_VECTOR(7 downto 0);	
	signal	A_out 		          : STD_LOGIC_VECTOR(7 downto 0);	
	signal	B_out 		          : STD_LOGIC_VECTOR(7 downto 0);
	signal	ALU_out 		        : STD_LOGIC_VECTOR(7 downto 0);
	signal	ALU_CCR_out	      : STD_LOGIC_VECTOR(3 downto 0);
	signal	ALU_CCR_out_8bits	: STD_LOGIC_VECTOR(7 downto 0);
	signal	CCR_out 		        : STD_LOGIC_VECTOR(7 downto 0);
	

	-- component declaration
	component cpu_register is 
		port(
			-- Synchronous Inputs
			clock         : in STD_LOGIC;
			reset         : in STD_LOGIC;
			 
			-- control
			load				: in STD_LOGIC;
			increment		: in STD_LOGIC;
			 
			-- IO
			data_in			: in STD_LOGIC_VECTOR(7 downto 0);
			data_out		: out STD_LOGIC_VECTOR(7 downto 0)		
		);
	end component;
	
	component alu is
		port(
			-- Synchronous Inputs
			clock         	: in STD_LOGIC;
			reset         	: in STD_LOGIC;
			 
			-- control
			ALU_Sel			: in STD_LOGIC_VECTOR(2 downto 0);
			 
			-- Inputs
			A					: in STD_LOGIC_VECTOR(7 downto 0);
			B					: in STD_LOGIC_VECTOR(7 downto 0);
			 
			-- Outputs
			data_out			: out STD_LOGIC_VECTOR(7 downto 0);
			CCR_out			: out STD_LOGIC_VECTOR(3 downto 0)
		);
	end component;

	begin 
    
		-- component instantiation
		reg_IR  : cpu_register
			port map(
				-- Synchronous Inputs
				clock       => clock,        
				reset     	=> reset,  
				
				-- control
				load    		=> IR_Load,
				increment	=>	'0',
				
				--IO
				data_in		=> BUS2,
				data_out		=> IR
			);
			
		reg_MAR  : cpu_register
			port map(
				-- Synchronous Inputs
				clock       => clock,        
				reset     	=> reset,  
				
				-- control
				load    		=> MAR_Load,
				increment	=>	'0',
				
				--IO
				data_in		=> BUS2,
				data_out		=> address
			);
			
		reg_PC  : cpu_register
			port map(
				-- Synchronous Inputs
				clock       => clock,        
				reset     	=> reset,  
				
				-- control
				load    		=> PC_Load,
				increment	=>	PC_Inc,
				
				--IO
				data_in		=> BUS2,
				data_out		=> PC_out
			);
			
		reg_A  : cpu_register
			port map(
				-- Synchronous Inputs
				clock       => clock,        
				reset     	=> reset,  
				
				-- control
				load    		=> A_Load,
				increment	=>	'0',
				
				--IO
				data_in		=> BUS2,
				data_out		=> A_out
			);
			
		reg_B  : cpu_register
			port map(
				-- Synchronous Inputs
				clock       => clock,        
				reset     	=> reset,  
				
				-- control
				load    		=> B_Load,
				increment	=>	'0',
				
				--IO
				data_in		=> BUS2,
				data_out		=> B_out
			);
			
		ALU_1	: alu
			port map(
				-- Synchronous Inputs
				clock       => clock,        
				reset     	=> reset,  
				
				-- control
				ALU_Sel    	=> ALU_Sel,
				
				-- inputs
				A				=> BUS1,
				B				=> B_out,
				
				-- outputs
				data_out		=> ALU_out,
				CCR_out		=> ALU_CCR_out
			);
			
		reg_CCR  : cpu_register
			port map(
				-- Synchronous Inputs
				clock       => clock,        
				reset     	=> reset,  
				
				-- control
				load    		=> CCR_Load,
				increment	=>	'0',
				
				--IO
				data_in		=> ALU_CCR_out_8bits,
				data_out		=> CCR_out
			);
			
		ALU_CCR_out_8bits <= "0000" & ALU_CCR_out;
		CCR_Result <= CCR_out(3 downto 0);
		
		
		-- BUS 2 MUX
		BUS2 <= 	ALU_out 		when (BUS2_Sel = "00") else
					BUS1 			when (BUS2_Sel = "01") else
					from_memory	when (BUS2_Sel = "10") else
					x"00";
		
		-- BUS 1 MUX
		BUS1 <= 	PC_out 		when (BUS1_Sel = "00") else
					A_out 		when (BUS1_Sel = "01") else
					B_out			when (BUS1_Sel = "10") else
					x"00";
					
		to_memory	<= BUS1;
		
    
end architecture;



