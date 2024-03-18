LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ALU IS
	PORT(
		data1,data2: IN STD_LOGIC_VECTOR(7 downto 0);
		controlSig: IN STD_LOGIC_VECTOR(2 downto 0);
		
		zero: OUT STD_LOGIC;
		result_out: OUT STD_LOGIC_VECTOR(7 downto 0)
	);
END ALU;

ARCHITECTURE struct OF ALU IS
SIGNAL AS_out,AND_out,OR_out,SOLT_out,result: STD_LOGIC_VECTOR(7 downto 0);
SIGNAL ADD_SUB_out: STD_LOGIC_VECTOR(7 downto 0);
SIGNAL AND_op,OR_op,ADD_op,SUB_op,SOLT_op: STD_LOGIC;
SIGNAL A_greater: STD_LOGIC;

	
	COMPONENT eightBitCLA
		PORT(
			a,b: IN STD_LOGIC_VECTOR(7 downto 0);
			addOrSub: IN STD_LOGIC;
			carryIn: IN STD_LOGIC;
			s: OUT STD_LOGIC_VECTOR(7 downto 0);
			carryOut: OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT eightBitComparator
		PORT(	x,y: IN STD_LOGIC_VECTOR(7 downto 0);
			eq: OUT STD_LOGIC;
			xGreaterZero: OUT STD_LOGIC;
			yGreaterZero: OUT STD_LOGIC;
			bitX7Eq1: OUT STD_LOGIC;
			bitY7Eq1: OUT STD_LOGIC;
			xEqZero, yEqZero: OUT STD_LOGIC;
			xGZ_US8Bit, yGZ_US8Bit: OUT STD_LOGIC;
			xEqZero_8Bit, yEqZero_8Bit: OUT STD_LOGIC
		);
	END COMPONENT;
	
BEGIN
	
	-- Control Signal inputs
	-- 000 = AND
	-- 001 = OR
	-- 010 = ADD
	-- 110 = SUB
	-- 111 = setOnLess
  	
	addSub: eightBitCLA
		PORT MAP(
			a => data1 ,b => data2,
			addOrSub => ((not(controlSig(0)))and(controlSig(1))and(not(controlSig(2)))),
			carryIn => '0',
			s => AS_out
		);
	
	AND_op <= ((not(controlSig(0)))and(not(controlSig(1)))and(not(controlSig(2))));
	OR_op <= ((not(controlSig(0)))and(not(controlSig(1)))and(controlSig(2)));
	ADD_op <= (((controlSig(0)))and(not(controlSig(1)))and((controlSig(2))));
	SUB_op <= (((controlSig(0)))and((controlSig(1)))and(not(controlSig(2))));
	SOLT_op <= (((controlSig(0)))and((controlSig(1)))and((controlSig(2))));
	
	compare1: eightBitComparator
		PORT MAP(
			x => AS_out, y => AS_out,
			xGreaterZero => A_greater
		);
		
	SOLT_out(7 downto 1) <= "0000000";
	SOLT_out(0) <= (A_greater)and(SOLT_op);
	
	AND_out(0) <= ((data1(0))and(data2(0)))and(AND_op);
	AND_out(1) <= ((data1(1))and(data2(1)))and(AND_op);
	AND_out(2) <= ((data1(2))and(data2(2)))and(AND_op);
	AND_out(3) <= ((data1(3))and(data2(3)))and(AND_op);
	AND_out(4) <= ((data1(4))and(data2(4)))and(AND_op);
	AND_out(5) <= ((data1(5))and(data2(5)))and(AND_op);
	AND_out(6) <= ((data1(6))and(data2(6)))and(AND_op);
	AND_out(7) <= ((data1(7))and(data2(7)))and(AND_op);

	OR_out(0) <= ((data1(0))or(data2(0)))and(OR_op);
	OR_out(1) <= ((data1(1))or(data2(1)))and(OR_op);
	OR_out(2) <= ((data1(2))or(data2(2)))and(OR_op);
	OR_out(3) <= ((data1(3))or(data2(3)))and(OR_op);
	OR_out(4) <= ((data1(4))or(data2(4)))and(OR_op);
	OR_out(5) <= ((data1(5))or(data2(5)))and(OR_op);
	OR_out(6) <= ((data1(6))or(data2(6)))and(OR_op);
	OR_out(7) <= ((data1(7))or(data2(7)))and(OR_op);
	
	ADD_SUB_out(0) <= (AS_out(0))and((ADD_op)or(SUB_op));
	ADD_SUB_out(1) <= (AS_out(1))and((ADD_op)or(SUB_op));
	ADD_SUB_out(2) <= (AS_out(2))and((ADD_op)or(SUB_op));
	ADD_SUB_out(3) <= (AS_out(3))and((ADD_op)or(SUB_op));
	ADD_SUB_out(4) <= (AS_out(4))and((ADD_op)or(SUB_op));
	ADD_SUB_out(5) <= (AS_out(5))and((ADD_op)or(SUB_op));
	ADD_SUB_out(6) <= (AS_out(6))and((ADD_op)or(SUB_op));
	ADD_SUB_out(7) <= (AS_out(7))and((ADD_op)or(SUB_op));
	
	
	
	result <= (ADD_SUB_out)or(AND_out)or(OR_out)or(SOLT_out);
	
	compare2: eightBitComparator
		PORT MAP(
			x => result, y => result,
			xEQZero_8Bit => zero
		);
	
	result_out <= result;
	
END struct;