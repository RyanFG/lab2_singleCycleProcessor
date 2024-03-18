LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY CLA32Bit IS
	PORT(
		a,b: IN STD_LOGIC_VECTOR(31 downto 0);
		addOrSub: IN STD_LOGIC;
		carryIn: IN STD_LOGIC;
		s: OUT STD_LOGIC_VECTOR(31 downto 0);
		carryOut: OUT STD_LOGIC
	);
END CLA32Bit;

ARCHITECTURE struct OF CLA32Bit IS
SIGNAL c1,c2,c3: STD_LOGIC;

	COMPONENT eightBitCLA 
		PORT(
			a,b: IN STD_LOGIC_VECTOR(7 downto 0);
			addOrSub: IN STD_LOGIC;
			carryIn: IN STD_LOGIC;
			s: OUT STD_LOGIC_VECTOR(7 downto 0);
			carryOut: OUT STD_LOGIC
		);
	END COMPONENT;

BEGIN

	CLA1: eightBitCLA
		PORT MAP(
			a => a(7 downto 0), b => b(7 downto 0),
			addOrSub => addOrSub,
			carryIn => carryIn,
			s => s(7 downto 0),
			carryOut => c1
		);
	
	CLA2: eightBitCLA
		PORT MAP(
			a => a(15 downto 8), b => b(15 downto 8),
			addOrSub => addOrSub,
			carryIn => c1,
			s => s(15 downto 8),
			carryOut => c2
		);
	
	CLA3: eightBitCLA
		PORT MAP(
			a => a(23 downto 16), b => b(23 downto 16),
			addOrSub => addOrSub,
			carryIn => c2,
			s => s(23 downto 16),
			carryOut => c3
		);
	 
	CLA4: eightBitCLA
		PORT MAP(
			a => a(31 downto 24), b => b(31 downto 24),
			addOrSub => addOrSub,
			carryIn => c3,
			s => s(31 downto 24),
			carryOut => carryOut
		);

END struct;