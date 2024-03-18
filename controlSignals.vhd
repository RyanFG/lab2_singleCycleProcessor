LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY controlSignals IS
	PORT(
			instr: IN STD_LOGIC_VECTOR(5 downto 0);
			
			regDst,jump,branch: OUT STD_LOGIC;
			memRead,memToReg,ALUOP1,ALUOP0: OUT STD_LOGIC;
			memWrite,ALUSrc, regWrite: OUT STD_LOGIC
	);
END controlSignals;

ARCHITECTURE struct OF controlSignals IS
SIGNAL rFormat,lw,sw,beq: STD_LOGIC;

BEGIN

	rFormat <= not((instr(0))and(instr(1))and(instr(2))and(instr(3))and(instr(4))and(instr(5)));
	lw <= ((instr(0))and(instr(1))and(not(instr(2)))and(not(instr(3)))and(not(instr(4)))and(instr(5)));
	SW <= ((instr(0))and(instr(1))and(not(instr(2)))and(instr(3))and(not(instr(4)))and(instr(5)));
	beq <= ((not(instr(0)))and(not(instr(1)))and(instr(2))and(not(instr(3)))and(not(instr(4)))and(not(instr(5))));
	
	regDst <= rFormat;
	ALUSrc <= lw or sw;
	memToReg <= lw;
	regWrite <= rFormat or lw;
	memRead <= lw;
	memWrite <= sw;
	branch <= beq;
	ALUOP0 <= beq;
	ALUOP1 <= rFormat;

END struct;