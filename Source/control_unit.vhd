------------------------------------------------------------------------------------------------------------
-- File name   : control_unit.vhd
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

entity control_unit is
  port(
    -- Synchronous Inputs
    clock     : in  STD_LOGIC;
    reset     : in  STD_LOGIC;

    -- Data IO control
    write     : out STD_LOGIC;

    IR_Load   : out STD_LOGIC;
    IR        : in  STD_LOGIC_VECTOR (7 downto 0);

    MAR_Load  : out STD_LOGIC;             

    PC_Load   : out STD_LOGIC;
    PC_Inc    : out STD_LOGIC;             

    A_Load    : out STD_LOGIC;
    B_Load    : out STD_LOGIC;             

    ALU_Sel   : out STD_LOGIC_VECTOR (2 downto 0);             

    CCR_Result: in  STD_LOGIC_VECTOR (3 downto 0);
    CCR_Load  : out STD_LOGIC;             

    Bus1_Sel  : out STD_LOGIC_VECTOR (1 downto 0);                          
    Bus2_Sel  : out STD_LOGIC_VECTOR (1 downto 0)
  );
end entity;

architecture control_unit_arch of control_unit is


  begin 
    
    
end architecture;



