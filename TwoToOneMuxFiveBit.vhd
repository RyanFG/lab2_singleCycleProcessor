LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY TwoToOneMuxFiveBit IS
	PORT(
		a,b: IN STD_LOGIC_VECTOR (4 downto 0);
		sel: IN STD_LOGIC;
		MuxOut: OUT STD_LOGIC_VECTOR (4 downto 0)
		);
END TwoToOneMuxFiveBit;		

ARCHITECTURE struct OF TwoToOneMuxFiveBit IS
SIGNAL O_Mux: STD_LOGIC_VECTOR (4 downto 0);

	COMPONENT twoToOneMUX IS
		PORT(	
			inA: IN STD_LOGIC;
			inB: IN STD_LOGIC;
			sel: IN STD_LOGIC;
			outC: OUT STD_LOGIC
		);
	END COMPONENT;
		
BEGIN

	Mux0: twoToOneMUX
	PORT MAP (
	inA => a(0),
	inB => b(0),
	sel => sel,
	outC => O_Mux(0)
	);

	Mux1: twoToOneMUX
	PORT MAP (
	inA => a(1),
	inB => b(1),
	sel => sel,
	outC => O_Mux(1)
	);

	Mux2: twoToOneMUX
	PORT MAP (
	inA => a(2),
	inB => b(2),
	sel => sel,
	outC => O_Mux(2)
	);

	Mux3: twoToOneMUX
	PORT MAP (
	inA => a(3),
	inB => b(3),
	sel => sel,
	outC => O_Mux(3)
	);

	Mux4: twoToOneMUX
	PORT MAP (
	inA => a(4),
	inB => b(4),
	sel => sel,
	outC => O_Mux(4)
	);
		
	MuxOut <= O_Mux;
		
END struct;