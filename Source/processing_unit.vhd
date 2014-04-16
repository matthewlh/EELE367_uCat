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


  begin 
    
    
end architecture;



