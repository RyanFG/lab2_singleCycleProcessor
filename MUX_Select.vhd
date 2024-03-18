LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MUX_Select IS
	PORT(
		sel: IN STD_LOGIC_VECTOR(2 downto 0);
		PC,ALU_res,D1,D2,WD,CS: IN STD_LOGIC_VECTOR(7 downto 0);
		
		M_out: OUT STD_LOGIC_VECTOR(7 downto 0)
	);
END MUX_Select;

ARCHITECTURE struct OF MUX_Select IS
SIGNAL s1,s2,s3,s4,s5,s6: STD_LOGIC;
	

BEGIN

	s1 <= (not(sel(0)))and(not(sel(1)))and(not(sel(2)));
	s2 <= (not(sel(0)))and(not(sel(1)))and((sel(2)));
	s3 <= (not(sel(0)))and((sel(1)))and(not(sel(2)));
	s4 <= (not(sel(0)))and((sel(1)))and((sel(2)));
	s5 <= ((sel(0)))and(not(sel(1)))and(not(sel(2)));
	s6 <= not((s1)or(s2)or(s3)or(s4)or(s5));
	
	M_out(0) <= ((PC(0))and(s1))or((ALU_res(0))and(s2))or((D1(0))and(s3))or((D2(0))and(s4))or((WD(0))and(s5))or((CS(0))and(s6));
	M_out(1) <= ((PC(1))and(s1))or((ALU_res(1))and(s2))or((D1(1))and(s3))or((D2(1))and(s4))or((WD(1))and(s5))or((CS(1))and(s6));
	M_out(2) <= ((PC(2))and(s1))or((ALU_res(2))and(s2))or((D1(2))and(s3))or((D2(2))and(s4))or((WD(2))and(s5))or((CS(2))and(s6));
	M_out(3) <= ((PC(3))and(s1))or((ALU_res(3))and(s2))or((D1(3))and(s3))or((D2(3))and(s4))or((WD(3))and(s5))or((CS(3))and(s6));
	M_out(4) <= ((PC(4))and(s1))or((ALU_res(4))and(s2))or((D1(4))and(s3))or((D2(4))and(s4))or((WD(4))and(s5))or((CS(4))and(s6));
	M_out(5) <= ((PC(5))and(s1))or((ALU_res(5))and(s2))or((D1(5))and(s3))or((D2(5))and(s4))or((WD(5))and(s5))or((CS(5))and(s6));
	M_out(6) <= ((PC(6))and(s1))or((ALU_res(6))and(s2))or((D1(6))and(s3))or((D2(6))and(s4))or((WD(6))and(s5))or((CS(6))and(s6));
	M_out(7) <=	((PC(7))and(s1))or((ALU_res(7))and(s2))or((D1(7))and(s3))or((D2(7))and(s4))or((WD(7))and(s5))or((CS(7))and(s6));
	
END struct;