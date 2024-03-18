LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY register32Bit IS
	PORT(	resetBar, load, clock: IN STD_LOGIC;
			inValues: IN STD_LOGIC_VECTOR(31 downto 0);
			outValues: OUT STD_LOGIC_VECTOR(31 downto 0)
	);
END register32Bit;

ARCHITECTURE struct OF register32Bit IS

	COMPONENT eightBitRegister IS
		PORT(	
			resetBar, load, clock: IN STD_LOGIC;
			inValues: IN STD_LOGIC_VECTOR(7 downto 0);
			outValues: OUT STD_LOGIC_VECTOR(7 downto 0)
		);
	END COMPONENT;

BEGIN

	reg1: eightBitRegister
		PORT MAP(	
			resetBar => resetBar, load => load, clock =>  clock,
			inValues => inValues(7 downto 0),
			outValues => outValues(7 downto 0)
		);
	
	reg2: eightBitRegister
		PORT MAP(	
			resetBar => resetBar, load => load, clock => clock,
			inValues => inValues(15 downto 8),
			outValues => outValues(15 downto 8)
		);
	
	reg3: eightBitRegister
		PORT MAP(	
			resetBar => resetBar, load => load, clock =>  clock,
			inValues => inValues(23 downto 16),
			outValues => outValues(23 downto 16)
		);
	
	reg4: eightBitRegister
		PORT MAP(	
			resetBar => resetBar, load => load, clock =>  clock,
			inValues => inValues(31 downto 24),
			outValues => outValues(31 downto 24)
		);

END struct;