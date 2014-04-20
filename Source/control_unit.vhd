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
use IEEE.numeric_std.all;

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
	
	constant ALU_Sel_ADD		: STD_LOGIC_VECTOR(2 downto 0) := "000";
	constant ALU_Sel_SUB		: STD_LOGIC_VECTOR(2 downto 0) := "001";
	constant ALU_Sel_AND		: STD_LOGIC_VECTOR(2 downto 0) := "010";
	constant ALU_Sel_OR		: STD_LOGIC_VECTOR(2 downto 0) := "011";
	constant ALU_Sel_INC		: STD_LOGIC_VECTOR(2 downto 0) := "100";
	constant ALU_Sel_DEC		: STD_LOGIC_VECTOR(2 downto 0) := "101";
	
	constant Bus1_Sel_PC			: STD_LOGIC_VECTOR(1 downto 0) := "00";
	constant Bus1_Sel_A			: STD_LOGIC_VECTOR(1 downto 0) := "01";
	constant Bus1_Sel_B			: STD_LOGIC_VECTOR(1 downto 0) := "10";
	
	constant Bus2_Sel_ALU		: STD_LOGIC_VECTOR(1 downto 0) := "00";
	constant Bus2_Sel_Bus1		: STD_LOGIC_VECTOR(1 downto 0) := "01";
	constant Bus2_Sel_from_mem	: STD_LOGIC_VECTOR(1 downto 0) := "10";

	-- type declaration
	type state_type is ( S_FETCH_0,		-- Opcode fetch states
								S_FETCH_1,
								S_FETCH_2,
								
								S_DECODE_0,		-- Opcode decode state
								
								S_LDA_IMM_0,	-- LDA_IMM states
								S_LDA_IMM_1,
								S_LDA_IMM_2,
								
								S_LDA_DIR_0,	-- LDA_DIR states
								S_LDA_DIR_1,
								S_LDA_DIR_2,
								S_LDA_DIR_3,
								S_LDA_DIR_4,
								
								S_STA_DIR_0,	-- STA_DIR states
								S_STA_DIR_1,
								S_STA_DIR_2,
								S_STA_DIR_3,
								
								S_LDB_IMM_0,	-- LDB_IMM states
								S_LDB_IMM_1,
								S_LDB_IMM_2,
								
								S_LDB_DIR_0,	-- LDB_DIR states
								S_LDB_DIR_1,
								S_LDB_DIR_2,
								S_LDB_DIR_3,
								S_LDB_DIR_4,
								
								S_STB_DIR_0,	-- STB_DIR states
								S_STB_DIR_1,
								S_STB_DIR_2,
								S_STB_DIR_3,
								
								S_BRA_0,			-- BRA states
								S_BRA_1,
								S_BRA_2
							 );
							 
	--signal decalration
	signal current_state		: state_type;
	signal next_state			: state_type;								
	
	begin 
		
		-- State Memory
		STATE_MEMORY : process(clock, reset)
			begin
				if(reset = '0') then 
					current_state <= S_FETCH_0;
				elsif(rising_edge(clock)) then
					current_state <= next_state;
				end if;
		end process;
		
		-- Next State Logic
		NEXT_STATE_LOGIC : process(current_state, IR)
			begin
				-- opcode fetch states
				if(current_state = S_FETCH_0) then 
					next_state <= S_FETCH_1;
				elsif(current_state = S_FETCH_1) then
					next_state <= S_FETCH_2;
				elsif(current_state = S_FETCH_2) then
					next_state <= S_DECODE_0;
				
				-- opcode decode state
				elsif(current_state = S_DECODE_0) then
					if(IR = LDA_IMM) then
						next_state <= S_LDA_IMM_0;
					elsif(IR = STA_DIR) then
						next_state <= S_STA_DIR_0;
					elsif(IR = BRA) then 
						next_state <= S_BRA_0;
					else
						next_state <= S_FETCH_0;
					end if;
				
				-- LDA_IMM states				
				elsif(current_state = S_LDA_IMM_0) then
					next_state <= S_LDA_IMM_1;
				elsif(current_state = S_LDA_IMM_1) then
					next_state <= S_LDA_IMM_2;
				elsif(current_state = S_LDA_IMM_2) then
					next_state <= S_FETCH_0;
				
				-- LDA_DIR states				
				elsif(current_state = S_LDA_DIR_0) then
					next_state <= S_LDA_DIR_1;
				elsif(current_state = S_LDA_DIR_1) then
					next_state <= S_LDA_DIR_2;
				elsif(current_state = S_LDA_DIR_2) then
					next_state <= S_LDA_DIR_3;
				elsif(current_state = S_LDA_DIR_3) then
					next_state <= S_LDA_DIR_4;
				elsif(current_state = S_LDA_DIR_4) then
					next_state <= S_FETCH_0;
					
				-- STA_DIR states
				elsif(current_state = S_STA_DIR_0) then
					next_state <= S_STA_DIR_1;
				elsif(current_state = S_STA_DIR_1) then
					next_state <= S_STA_DIR_2;
				elsif(current_state = S_STA_DIR_2) then
					next_state <= S_STA_DIR_3;
				elsif(current_state = S_STA_DIR_3) then
					next_state <= S_FETCH_0;
				
				-- LDB_IMM states				
				elsif(current_state = S_LDB_IMM_0) then
					next_state <= S_LDB_IMM_1;
				elsif(current_state = S_LDB_IMM_1) then
					next_state <= S_LDB_IMM_2;
				elsif(current_state = S_LDB_IMM_2) then
					next_state <= S_FETCH_0;
				
				-- LDB_DIR states				
				elsif(current_state = S_LDB_DIR_0) then
					next_state <= S_LDB_DIR_1;
				elsif(current_state = S_LDB_DIR_1) then
					next_state <= S_LDB_DIR_2;
				elsif(current_state = S_LDB_DIR_2) then
					next_state <= S_LDB_DIR_3;
				elsif(current_state = S_LDB_DIR_3) then
					next_state <= S_LDB_DIR_4;
				elsif(current_state = S_LDB_DIR_4) then
					next_state <= S_FETCH_0;
					
				-- STB_DIR states
				elsif(current_state = S_STB_DIR_0) then
					next_state <= S_STB_DIR_1;
				elsif(current_state = S_STB_DIR_1) then
					next_state <= S_STB_DIR_2;
				elsif(current_state = S_STB_DIR_2) then
					next_state <= S_STB_DIR_3;
				elsif(current_state = S_STB_DIR_3) then
					next_state <= S_FETCH_0;
					
				-- BRA states
				elsif(current_state = S_BRA_0) then
					next_state <= S_BRA_1;
				elsif(current_state = S_BRA_1) then
					next_state <= S_BRA_2;
				elsif(current_state = S_BRA_2) then
					next_state <= S_FETCH_0;
					
				-- if we get lost
				else
					next_state <= S_FETCH_0;					
				end if;
		end process;
		
		-- Output logic
		OUTPUT_LOGIC : process(current_state)
			begin
				case(current_state) is 
				
					-- Opcode fetch states
					when S_FETCH_0 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '1';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_Bus1;
						write			<= '0';
					when S_FETCH_1 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '1';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
					when S_FETCH_2 =>
						IR_Load 		<= '1';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
						
					-- Opcode decode state
					when S_DECODE_0 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
						
					-- LDA_IMM states
					when S_LDA_IMM_0 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '1';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_Bus1;
						write			<= '0';
					when S_LDA_IMM_1 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '1';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
					when S_LDA_IMM_2 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '1';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
						
					-- LDA_DIR states
					when S_LDA_DIR_0 =>			-- fetch operand (address) from memory
						IR_Load 		<= '0';		
						MAR_LOAD 	<= '1';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_Bus1;
						write			<= '0';
					when S_LDA_DIR_1 =>			-- put address from memory onto bus2
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '1';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
					when S_LDA_DIR_2 =>			-- load the address from memory into the MAR
						IR_Load 		<= '0';
						MAR_LOAD 	<= '1';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
					when S_LDA_DIR_3 =>			-- put data from memory onto bus2
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
					when S_LDA_DIR_4 =>			-- put data from memory onto bus2
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '1';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
						
					-- STA_DIR states
					when S_STA_DIR_0 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '1';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_Bus1;
						write			<= '0';
					when S_STA_DIR_1 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '1';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
					when S_STA_DIR_2 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '1';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
					when S_STA_DIR_3 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '1';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_A;
						Bus2_Sel		<= Bus2_Sel_ALU;
						write			<= '1';
						
					-- LDB_IMM states
					when S_LDB_IMM_0 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '1';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_Bus1;
						write			<= '0';
					when S_LDB_IMM_1 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '1';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
					when S_LDB_IMM_2 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '1';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
						
					-- LDB_DIR states
					when S_LDB_DIR_0 =>			-- fetch operand (address) from memory
						IR_Load 		<= '0';		
						MAR_LOAD 	<= '1';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_Bus1;
						write			<= '0';
					when S_LDB_DIR_1 =>			-- put address from memory onto bus2
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '1';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
					when S_LDB_DIR_2 =>			-- load the address from memory into the MAR
						IR_Load 		<= '0';
						MAR_LOAD 	<= '1';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
					when S_LDB_DIR_3 =>			-- put data from memory onto bus2
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
					when S_LDB_DIR_4 =>			-- put data from memory onto bus2
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '1';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
						
					-- STB_DIR states
					when S_STB_DIR_0 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '1';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_Bus1;
						write			<= '0';
					when S_STB_DIR_1 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '1';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
					when S_STB_DIR_2 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '1';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
					when S_STB_DIR_3 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '1';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_B;
						Bus2_Sel		<= Bus2_Sel_ALU;
						write			<= '1';
						
					-- BRA states
					when S_BRA_0 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '1';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_Bus1;
						write			<= '0';
					when S_BRA_1 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
					when S_BRA_2 =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '1';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_from_mem;
						write			<= '0';
					
					when others =>
						IR_Load 		<= '0';
						MAR_LOAD 	<= '0';
						PC_Load		<= '0';
						PC_Inc		<= '0';
						A_Load		<= '0';
						B_Load		<= '0';
						ALU_Sel		<= ALU_Sel_ADD;
						CCR_Load		<= '0';
						BUS1_Sel		<= BUS1_Sel_PC;
						Bus2_Sel		<= Bus2_Sel_ALU;
						write			<= '0';
						
				end case;
		end process;
		
end architecture;



