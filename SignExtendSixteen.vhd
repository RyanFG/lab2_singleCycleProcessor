LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY SignExtendSixteen IS
	PORT(
		i_value: IN STD_LOGIC_VECTOR (15 downto 0);
		o_value: OUT STD_LOGIC_VECTOR (31 downto 0)
	);
END SignExtendSixteen;		

ARCHITECTURE struct OF SignExtendSixteen IS

		
BEGIN
		
		o_value(0) <= i_value(0);
		o_value(1) <= i_value(1);
		o_value(2) <= i_value(2);
		o_value(3) <= i_value(3);
		o_value(4) <= i_value(4);
		o_value(5) <= i_value(5);
		o_value(6) <= i_value(6);
		o_value(7) <= i_value(7);
		o_value(8) <= i_value(8);
		o_value(9) <= i_value(9);
		o_value(10) <= i_value(10);
		o_value(11) <= i_value(11);
		o_value(12) <= i_value(12);
		o_value(13) <= i_value(13);
		o_value(14) <= i_value(14);
		o_value(15) <= i_value(15);
		o_value(16) <= i_value(15);
		o_value(17) <= i_value(15);
		o_value(18) <= i_value(15);
		o_value(19) <= i_value(15);
		o_value(20) <= i_value(15);
		o_value(21) <= i_value(15);
		o_value(22) <= i_value(15);
		o_value(23) <= i_value(15);
		o_value(24) <= i_value(15);
		o_value(25) <= i_value(15);
		o_value(26) <= i_value(15);
		o_value(27) <= i_value(15);
		o_value(28) <= i_value(15);
		o_value(29) <= i_value(15);
		o_value(30) <= i_value(15);
		o_value(31) <= i_value(15);
		
END struct;