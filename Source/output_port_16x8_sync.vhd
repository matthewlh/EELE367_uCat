------------------------------------------------------------------------------------------------------------
-- File name   : output_port_16x8_sync.vhd
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

entity io_port_16x8_sync is
  port(
    -- Synchronous Inputs
    clock         : in STD_LOGIC;
    reset         : in STD_LOGIC;
    
    -- data inputs
    address       : in STD_LOGIC_VECTOR(7 downto 0);
    data_in       : in STD_LOGIC_VECTOR(7 downto 0);
    write         : in STD_LOGIC;
    
    -- data output
    data_out_00      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_01      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_02      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_03      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_04      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_05      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_06      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_07      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_08      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_09      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_10      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_11      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_12      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_13      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_14      : out STD_LOGIC_VECTOR(7 downto 0);
    data_out_15      : out STD_LOGIC_VECTOR(7 downto 0)
  );
end entity;

architecture io_port_16x8_sync_arch of io_port_16x8_sync is


  begin 
    
    
end architecture;





