------------------------------------------------------------------------------------------------------------
-- File name   : memory.vhd
--
-- Project     : EELE367 - Logic Design
--               uCat Final Project
--
-- Description : 	
--
-- Author(s)   : 	Matthew Handley
--
-- Note(s)     : Address      Description
--              ----------------------------------
--              x"00"       Instruction Memory (ROM)    
--               :            (128x8-bit) 
--               : 
--              x"7F"                          
--              ----------------------------------
--              x"80"       Data Memory (RAM)
--               :            (96x8-bit)
--              x"DF"           
--              ----------------------------------               
--              x"E0"        Output Ports 
--               :            (16 ports)
--              x"EF"           
--              ----------------------------------               
--              x"F0"        Input Ports 
--               :            (16 ports)
--              x"FF"           
--              ----------------------------------
--
------------------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity memory is
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
end entity;

architecture memory_arch of memory is

  -- component declaration
  component rom_128x8_sync is
    port(
      -- Synchronous Inputs
      clock         : in STD_LOGIC;
      
      -- Inputs
      address       : in STD_LOGIC_VECTOR(7 downto 0);
      
      -- Outputs 
      data_out      : out STD_LOGIC_VECTOR(7 downto 0)
    );
  end component;
  
  component rw_96x8_sync is
    port(
      -- Synchronous Inputs
      clock         : in STD_LOGIC;
      reset         : in STD_LOGIC;
    
      -- data inputs
      address       : in STD_LOGIC_VECTOR(7 downto 0);
      data_in       : in STD_LOGIC_VECTOR(7 downto 0);
      write         : in STD_LOGIC;
    
      -- data output
      data_out      : out STD_LOGIC_VECTOR(7 downto 0)
    );
  end component;
  
  component input_port_16x8_sync is
    port(      
      -- Synchronous Inputs
      clock         : in STD_LOGIC;
      reset         : in STD_LOGIC;
    
      -- input control
      address       : in STD_LOGIC_VECTOR(7 downto 0);
      write         : in STD_LOGIC;
    
      -- data input
      data_in_00    : in STD_LOGIC_VECTOR(7 downto 0);
      data_in_01    : in STD_LOGIC_VECTOR(7 downto 0);
      data_in_02    : in STD_LOGIC_VECTOR(7 downto 0);
      data_in_03    : in STD_LOGIC_VECTOR(7 downto 0);
      data_in_04    : in STD_LOGIC_VECTOR(7 downto 0);
      data_in_05    : in STD_LOGIC_VECTOR(7 downto 0);
      data_in_06    : in STD_LOGIC_VECTOR(7 downto 0);
      data_in_07    : in STD_LOGIC_VECTOR(7 downto 0);
      data_in_08    : in STD_LOGIC_VECTOR(7 downto 0);
      data_in_09    : in STD_LOGIC_VECTOR(7 downto 0);
      data_in_10    : in STD_LOGIC_VECTOR(7 downto 0);
      data_in_11    : in STD_LOGIC_VECTOR(7 downto 0);
      data_in_12    : in STD_LOGIC_VECTOR(7 downto 0);
      data_in_13    : in STD_LOGIC_VECTOR(7 downto 0);
      data_in_14    : in STD_LOGIC_VECTOR(7 downto 0);
      data_in_15    : in STD_LOGIC_VECTOR(7 downto 0);
    
      -- data output
      data_out      : out STD_LOGIC_VECTOR(7 downto 0)
    );    
  end component;
  
  component output_port_16x8_sync is
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
  end component;

  -- signal declaration
  signal rom_data_out         : STD_LOGIC_VECTOR(7 downto 0);
  signal rw_data_out          : STD_LOGIC_VECTOR(7 downto 0);
  signal input_port_data_out  : STD_LOGIC_VECTOR(7 downto 0);
  
  signal address_uns          : unsigned(7 downto 0);

  begin 
    
    -- component instantiation
    rom  : rom_128x8_sync
      port map(
        clock       => clock,        
        address     => address,                
        data_out    => rom_data_out
      );
      
    rw  : rw_96x8_sync
      port map(
        clock       => clock, 
        reset       => reset,
               
        address     => address,  
        data_in     => data_in,
        write       => write,
                      
        data_out    => rw_data_out
      );
      
    input_port  : input_port_16x8_sync
      port map(
        clock       => clock, 
        reset       => reset,
               
        address     => address,  
        write       => write,
        
        data_in_00  => port_in_00,
        data_in_01  => port_in_01,
        data_in_02  => port_in_02,
        data_in_03  => port_in_03,
        data_in_04  => port_in_04,
        data_in_05  => port_in_05,
        data_in_06  => port_in_06,
        data_in_07  => port_in_07,
        data_in_08  => port_in_08,
        data_in_09  => port_in_09,
        data_in_10  => port_in_10,
        data_in_11  => port_in_11,
        data_in_12  => port_in_12,
        data_in_13  => port_in_13,
        data_in_14  => port_in_14,
        data_in_15  => port_in_15,
                      
        data_out    => input_port_data_out
      );
      
    output_port  : output_port_16x8_sync
      port map(
        clock       => clock, 
        reset       => reset,
               
        address     => address,  
        data_in     => data_in,
        write       => write,
                      
        data_out_00 => port_out_00,
        data_out_01 => port_out_01,
        data_out_02 => port_out_02,
        data_out_03 => port_out_03,
        data_out_04 => port_out_04,
        data_out_05 => port_out_05,
        data_out_06 => port_out_06,
        data_out_07 => port_out_07,
        data_out_08 => port_out_08,
        data_out_09 => port_out_09,
        data_out_10 => port_out_10,
        data_out_11 => port_out_11,
        data_out_12 => port_out_12,
        data_out_13 => port_out_13,
        data_out_14 => port_out_14,
        data_out_15 => port_out_15
      );
      
    -- mux data_out
    data_out <= rom_data_out          when (address_uns >= x"00" and address_uns <= x"7F") else
                rw_data_out           when (address_uns >= x"80" and address_uns <= x"DF") else
                input_port_data_out   when (address_uns >= x"F0" and address_uns <= x"FF") else
                x"00";
    
end architecture;

