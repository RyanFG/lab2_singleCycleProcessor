LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ALU_control IS
	PORT(
		ALU_op0,ALU_op1: IN STD_LOGIC;
		func: IN STD_LOGIC_VECTOR(5 downto 0);
		
		operation: OUT STD_LOGIC_VECTOR(2 downto 0)
	);
END ALU_control;

ARCHITECTURE struct OF ALU_control IS

BEGIN
	
	operation(0) <= (ALU_op0)or((ALU_op1)and(func(1)));
	operation(1) <= (ALU_op1)nor(func(2));
	operation(2) <= ((func(0))or(func(3)))and(ALU_op1);
	
END struct;