LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY shiftLeft32 IS
	PORT(	
		a: IN STD_LOGIC_VECTOR(31 downto 0);
		x: OUT STD_LOGIC_VECTOR(31 downto 0)
	);
END shiftLeft32;

ARCHITECTURE struct OF shiftLeft32 IS

BEGIN

	x(31 downto 2) <= a(29 downto 0);
	x(1 downto 0) <= "00"; 

END struct;