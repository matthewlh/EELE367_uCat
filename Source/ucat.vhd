------------------------------------------------------------------------------------------------------------
-- File name   : ucat.vhd
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

entity ucat is
  port(
    -- Synchronous Inputs
    clock         : in STD_LOGIC;
    reset         : in STD_LOGIC;
    
    -- Input ports
    port_in_00    : in STD_LOGIC_VECTOR(7 downto 0);
    port_in_01    : in STD_LOGIC_VECTOR(7 downto 0);
    port_in_02    : in STD_LOGIC_VECTOR(7 downto 0);
    port_in_03    : in STD_LOGIC_VECTOR(7 downto 0);
    port_in_04    : in STD_LOGIC_VECTOR(7 downto 0);
    port_in_05    : in STD_LOGIC_VECTOR(7 downto 0);
    port_in_06    : in STD_LOGIC_VECTOR(7 downto 0);
    port_in_07    : in STD_LOGIC_VECTOR(7 downto 0);
    port_in_08    : in STD_LOGIC_VECTOR(7 downto 0);
    port_in_09    : in STD_LOGIC_VECTOR(7 downto 0);
    port_in_10    : in STD_LOGIC_VECTOR(7 downto 0);
    port_in_11    : in STD_LOGIC_VECTOR(7 downto 0);
    port_in_12    : in STD_LOGIC_VECTOR(7 downto 0);
    port_in_13    : in STD_LOGIC_VECTOR(7 downto 0);
    port_in_14    : in STD_LOGIC_VECTOR(7 downto 0);
    port_in_15    : in STD_LOGIC_VECTOR(7 downto 0);
      
    -- Output ports    
    port_out_00   : out STD_LOGIC_VECTOR(7 downto 0);
    port_out_01   : out STD_LOGIC_VECTOR(7 downto 0);
    port_out_02   : out STD_LOGIC_VECTOR(7 downto 0);
    port_out_03   : out STD_LOGIC_VECTOR(7 downto 0);
    port_out_04   : out STD_LOGIC_VECTOR(7 downto 0);
    port_out_05   : out STD_LOGIC_VECTOR(7 downto 0);
    port_out_06   : out STD_LOGIC_VECTOR(7 downto 0);
    port_out_07   : out STD_LOGIC_VECTOR(7 downto 0);
    port_out_08   : out STD_LOGIC_VECTOR(7 downto 0);
    port_out_09   : out STD_LOGIC_VECTOR(7 downto 0);
    port_out_10   : out STD_LOGIC_VECTOR(7 downto 0);
    port_out_11   : out STD_LOGIC_VECTOR(7 downto 0);
    port_out_12   : out STD_LOGIC_VECTOR(7 downto 0);
    port_out_13   : out STD_LOGIC_VECTOR(7 downto 0);
    port_out_14   : out STD_LOGIC_VECTOR(7 downto 0);
    port_out_15   : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture ucat_arch of ucat is

  -- component declaration
  component cpu is
    port(
      -- Synchronous Inputs
      clock         : in STD_LOGIC;
      reset         : in STD_LOGIC;
    
      -- Inputs
      from_memory   : in STD_LOGIC_VECTOR(7 downto 0);
      
      -- Outputs 
      address       : out STD_LOGIC_VECTOR(7 downto 0);
      write         : out STD_LOGIC;
      to_memory     : out STD_LOGIC_VECTOR(7 downto 0)
    );
  end component;
  
  
  component memory is
    port(
			-- Synchronous Inputs
			clock         : in STD_LOGIC;
			reset         : in STD_LOGIC;
			
			-- cpu inputs
			address       : in STD_LOGIC_VECTOR(7 downto 0);
			write         : in STD_LOGIC;
			data_in       : in STD_LOGIC_VECTOR(7 downto 0);
			
			-- cpu output
			data_out      : out STD_LOGIC_VECTOR(7 downto 0);
			
			-- Input ports
			port_in_00    : in STD_LOGIC_VECTOR(7 downto 0);
			port_in_01    : in STD_LOGIC_VECTOR(7 downto 0);
			port_in_02    : in STD_LOGIC_VECTOR(7 downto 0);
			port_in_03    : in STD_LOGIC_VECTOR(7 downto 0);
			port_in_04    : in STD_LOGIC_VECTOR(7 downto 0);
			port_in_05    : in STD_LOGIC_VECTOR(7 downto 0);
			port_in_06    : in STD_LOGIC_VECTOR(7 downto 0);
			port_in_07    : in STD_LOGIC_VECTOR(7 downto 0);
			port_in_08    : in STD_LOGIC_VECTOR(7 downto 0);
			port_in_09    : in STD_LOGIC_VECTOR(7 downto 0);
			port_in_10    : in STD_LOGIC_VECTOR(7 downto 0);
			port_in_11    : in STD_LOGIC_VECTOR(7 downto 0);
			port_in_12    : in STD_LOGIC_VECTOR(7 downto 0);
			port_in_13    : in STD_LOGIC_VECTOR(7 downto 0);
			port_in_14    : in STD_LOGIC_VECTOR(7 downto 0);
			port_in_15    : in STD_LOGIC_VECTOR(7 downto 0);
			  
			-- Output ports    
			port_out_00   : out STD_LOGIC_VECTOR(7 downto 0);
			port_out_01   : out STD_LOGIC_VECTOR(7 downto 0);
			port_out_02   : out STD_LOGIC_VECTOR(7 downto 0);
			port_out_03   : out STD_LOGIC_VECTOR(7 downto 0);
			port_out_04   : out STD_LOGIC_VECTOR(7 downto 0);
			port_out_05   : out STD_LOGIC_VECTOR(7 downto 0);
			port_out_06   : out STD_LOGIC_VECTOR(7 downto 0);
			port_out_07   : out STD_LOGIC_VECTOR(7 downto 0);
			port_out_08   : out STD_LOGIC_VECTOR(7 downto 0);
			port_out_09   : out STD_LOGIC_VECTOR(7 downto 0);
			port_out_10   : out STD_LOGIC_VECTOR(7 downto 0);
			port_out_11   : out STD_LOGIC_VECTOR(7 downto 0);
			port_out_12   : out STD_LOGIC_VECTOR(7 downto 0);
			port_out_13   : out STD_LOGIC_VECTOR(7 downto 0);
			port_out_14   : out STD_LOGIC_VECTOR(7 downto 0);
			port_out_15   : out STD_LOGIC_VECTOR(7 downto 0)
	  );
  end component;
  
  -- signal declaration
  signal address           : STD_LOGIC_VECTOR(7 downto 0);
  signal write             : STD_LOGIC;
  signal to_memory         : STD_LOGIC_VECTOR(7 downto 0);
  signal from_memory       : STD_LOGIC_VECTOR(7 downto 0);
  
  begin 
    
    -- component instantiation
    cpu_component  : cpu
      port map(
        clock       => clock,
        reset       => reset,
        
        address     => address,        
        write       => write,
        to_memory   => to_memory,
        from_memory => from_memory
      );
    
    memory_component  : memory
      port map(
        clock       => clock,
        reset       => reset,
        
        address     => address,        
        write       => write,
        data_in     => to_memory,
        data_out    => from_memory,
        
        port_in_00  => port_in_00,
        port_in_01  => port_in_01,
        port_in_02  => port_in_02,
        port_in_03  => port_in_03,
        port_in_04  => port_in_04,
        port_in_05  => port_in_05,
        port_in_06  => port_in_06,
        port_in_07  => port_in_07,
        port_in_08  => port_in_08,
        port_in_09  => port_in_09,
        port_in_10  => port_in_10,
        port_in_11  => port_in_11,
        port_in_12  => port_in_12,
        port_in_13  => port_in_13,
        port_in_14  => port_in_14,
        port_in_15  => port_in_15,
        
        port_out_00  => port_out_00,
        port_out_01  => port_out_01,
        port_out_02  => port_out_02,
        port_out_03  => port_out_03,
        port_out_04  => port_out_04,
        port_out_05  => port_out_05,
        port_out_06  => port_out_06,
        port_out_07  => port_out_07,
        port_out_08  => port_out_08,
        port_out_09  => port_out_09,
        port_out_10  => port_out_10,
        port_out_11  => port_out_11,
        port_out_12  => port_out_12,
        port_out_13  => port_out_13,
        port_out_14  => port_out_14,
        port_out_15  => port_out_15
      );    
    
    
end architecture;


