LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY TwoToOneMux32Bit IS
	PORT(
		a,b: IN STD_LOGIC_VECTOR (31 downto 0);
		sel: IN STD_LOGIC;
		MuxOut: OUT STD_LOGIC_VECTOR (31 downto 0)
		);
END TwoToOneMux32Bit;

ARCHITECTURE struct OF TwoToOneMux32Bit IS

	COMPONENT TwoToOneMuxEightBit
		PORT(
			a,b: IN STD_LOGIC_VECTOR (7 downto 0);
			sel: IN STD_LOGIC;
			MuxOut: OUT STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;

BEGIN

	mux1: TwoToOneMuxEightBit
		PORT MAP(
			a => a(7 downto 0), b => b(7 downto 0),
			sel => sel,
			MuxOut => MuxOut(7 downto 0)
		);
	
	mux2: TwoToOneMuxEightBit
		PORT MAP(
			a => a(15 downto 8), b => b(15 downto 8),
			sel => sel,
			MuxOut => MuxOut(15 downto 8)
		);
	
	mux3: TwoToOneMuxEightBit
		PORT MAP(
			a => a(23 downto 16), b => b(23 downto 16),
			sel => sel,
			MuxOut => MuxOut(23 downto 16)
		);
	
	mux4: TwoToOneMuxEightBit
		PORT MAP(
			a => a(31 downto 24), b => b(31 downto 24),
			sel => sel,
			MuxOut => MuxOut(31 downto 24)
		);

END struct;