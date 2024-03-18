LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FourToOneMuxFiveBit IS
	PORT(
		a,b,c,d: IN STD_LOGIC_VECTOR (4 downto 0);
		sel: IN STD_LOGIC_VECTOR (2 downto 0);
		resetBar, clock: IN STD_LOGIC;
		MuxOut: OUT STD_LOGIC_VECTOR (4 downto 0)
		);
END FourToOneMuxFiveBit;		

ARCHITECTURE struct OF FourToOneMuxFiveBit IS
SIGNAL O_Mux: STD_LOGIC_VECTOR (4 downto 0);
		COMPONENT eightBitRegister IS
		PORT(	resetBar, load, clock: IN STD_LOGIC;
			inValues: IN STD_LOGIC_VECTOR(7 downto 0);
			outValues: OUT STD_LOGIC_VECTOR(7 downto 0)
			);
		END COMPONENT;
		
BEGIN
		RegA: eightBitRegister
		PORT MAP(
			resetBar => resetBar,
			load => (not(sel(1)) and not(sel(0))),
			inValues (4 downto 0) => a,
			outValues => O_Mux
		);
		
		RegB: eightBitRegister
		PORT MAP(
			resetBar => resetBar,
			load => (not(sel(1)) and (sel(0))),
			inValues (4 downto 0) => b,
			outValues => O_Mux
		);
		RegC: eightBitRegister
		PORT MAP(
			resetBar => resetBar,
			load => ((sel(1)) and not(sel(0))),
			inValues (4 downto 0) => c,
			outValues => O_Mux
		);
		
		RegD: eightBitRegister
		PORT MAP(
			resetBar => resetBar,
			load => ((sel(1)) and (sel(0))),
			inValues (4 downto 0) => d,
			outValues => O_Mux
		);
		MuxOut <= O_Mux;
		
END struct;