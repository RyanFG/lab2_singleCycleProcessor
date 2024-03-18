LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY registers IS
	PORT(
		readReg1,readReg2,writeReg: IN STD_LOGIC_VECTOR(4 downto 0);
		writeData: IN STD_LOGIC_VECTOR(7 downto 0);
		reset,clk: IN STD_LOGIC;
		regWrite: IN STD_LOGIC;
		
		data1out,data2out: OUT STD_LOGIC_VECTOR(7 downto 0)
	);
END registers;

ARCHITECTURE struct OF registers IS
SIGNAL reg1Out,reg2Out,reg3Out,reg4Out,reg5Out,reg6Out,reg7Out,reg8Out: STD_LOGIC_VECTOR(7 downto 0);
SIGNAL read1addr1,read1addr2,read1addr3,read1addr4,read1addr5,read1addr6,read1addr7,read1addr8: STD_LOGIC;
SIGNAL read2addr1,read2addr2,read2addr3,read2addr4,read2addr5,read2addr6,read2addr7,read2addr8: STD_LOGIC;
SIGNAL write1,write2,write3,write4,write5,write6,write7,write8: STD_LOGIC;

	COMPONENT eightBitRegister IS
		PORT(	
			resetBar, load, clock: IN STD_LOGIC;
			inValues: IN STD_LOGIC_VECTOR(7 downto 0);
			outValues: OUT STD_LOGIC_VECTOR(7 downto 0)
		);
	END COMPONENT;

BEGIN
	
	-- used to decide if an output is needed from the given addr
	read1addr1 <= ((readReg1(0))and(not(readReg1(1)))and(not(readReg1(2)))and(not(readReg1(3)))and(not(readReg1(4))));
	read1addr2 <= ((not(readReg1(0)))and((readReg1(1)))and(not(readReg1(2)))and(not(readReg1(3)))and(not(readReg1(4))));
	read1addr3 <= (((readReg1(0)))and((readReg1(1)))and(not(readReg1(2)))and(not(readReg1(3)))and(not(readReg1(4))));
	read1addr4 <= ((not(readReg1(0)))and(not(readReg1(1)))and((readReg1(2)))and(not(readReg1(3)))and(not(readReg1(4))));
	read1addr5 <= (((readReg1(0)))and(not(readReg1(1)))and((readReg1(2)))and(not(readReg1(3)))and(not(readReg1(4))));
	read1addr6 <= ((not(readReg1(0)))and((readReg1(1)))and((readReg1(2)))and(not(readReg1(3)))and(not(readReg1(4))));
	read1addr7 <= (((readReg1(0)))and((readReg1(1)))and((readReg1(2)))and(not(readReg1(3)))and(not(readReg1(4))));
	read1addr8 <= ((not(readReg1(0)))and(not(readReg1(1)))and(not(readReg1(2)))and((readReg1(3)))and(not(readReg1(4))));
	
	read2addr1 <= ((readReg2(0))and(not(readReg2(1)))and(not(readReg2(2)))and(not(readReg2(3)))and(not(readReg2(4))));
	read2addr2 <= ((not(readReg2(0)))and((readReg2(1)))and(not(readReg2(2)))and(not(readReg2(3)))and(not(readReg2(4))));
	read2addr3 <= (((readReg2(0)))and((readReg2(1)))and(not(readReg2(2)))and(not(readReg2(3)))and(not(readReg2(4))));
	read2addr4 <= ((not(readReg2(0)))and(not(readReg2(1)))and((readReg2(2)))and(not(readReg2(3)))and(not(readReg2(4))));
	read2addr5 <= (((readReg2(0)))and(not(readReg2(1)))and((readReg2(2)))and(not(readReg2(3)))and(not(readReg2(4))));
	read2addr6 <= ((not(readReg2(0)))and((readReg2(1)))and((readReg2(2)))and(not(readReg2(3)))and(not(readReg2(4))));
	read2addr7 <= (((readReg2(0)))and((readReg2(1)))and((readReg2(2)))and(not(readReg2(3)))and(not(readReg2(4))));
	read2addr8 <= ((not(readReg2(0)))and(not(readReg2(1)))and(not(readReg2(2)))and((readReg2(3)))and(not(readReg2(4))));
	
	-- used to load when writing specific addr
	-- Ex. reg1 = 1 => write1 = reg1 and regWrite, reg2 = 2 => write2 = reg2 and regWrite, ...
	write1 <= ((writeReg(0))and(not(writeReg(1)))and(not(writeReg(2)))and(not(writeReg(3)))and(not(writeReg(4))))and(regWrite);
	write2 <= ((not(writeReg(0)))and((writeReg(1)))and(not(writeReg(2)))and(not(writeReg(3)))and(not(writeReg(4))))and(regWrite);
	write3 <= (((writeReg(0)))and((writeReg(1)))and(not(writeReg(2)))and(not(writeReg(3)))and(not(writeReg(4))))and(regWrite);
	write4 <= ((not(writeReg(0)))and(not(writeReg(1)))and((writeReg(2)))and(not(writeReg(3)))and(not(writeReg(4))))and(regWrite);
	write5 <= (((writeReg(0)))and(not(writeReg(1)))and((writeReg(2)))and(not(writeReg(3)))and(not(writeReg(4))))and(regWrite);
	write6 <= ((not(writeReg(0)))and((writeReg(1)))and((writeReg(2)))and(not(writeReg(3)))and(not(writeReg(4))))and(regWrite);
	write7 <= (((writeReg(0)))and((writeReg(1)))and((writeReg(2)))and(not(writeReg(3)))and(not(writeReg(4))))and(regWrite);
	write8 <= ((not(writeReg(0)))and(not(writeReg(1)))and(not(writeReg(2)))and((writeReg(3)))and(not(writeReg(4))))and(regWrite);
	
	reg1: eightBitRegister
		PORT MAP(
			resetBar => not(reset), load => write1, clock => clk,
			inValues => writeData,
			outValues => reg1Out
		);
	
	reg2: eightBitRegister
		PORT MAP(
			resetBar => not(reset), load => write2, clock => clk,
			inValues => writeData,
			outValues => reg2Out
		);
	
	reg3: eightBitRegister
		PORT MAP(
			resetBar => not(reset), load => write3, clock => clk,
			inValues => writeData,
			outValues => reg3Out
		);
	
	reg4: eightBitRegister
		PORT MAP(
			resetBar => not(reset), load => write4, clock => clk,
			inValues => writeData,
			outValues => reg4Out
		);
	
	reg5: eightBitRegister
		PORT MAP(
			resetBar => not(reset), load => write5, clock => clk,
			inValues => writeData,
			outValues => reg5Out
		);
	
	reg6: eightBitRegister
		PORT MAP(
			resetBar => not(reset), load => write6, clock => clk,
			inValues => writeData,
			outValues => reg6Out
		);
	
	reg7: eightBitRegister
		PORT MAP(
			resetBar => not(reset), load => write7, clock => clk,
			inValues => writeData,
			outValues => reg7Out
		);
	
	reg8: eightBitRegister
		PORT MAP(
			resetBar => not(reset), load => write8, clock => clk,
			inValues => writeData,
			outValues => reg8Out
		);
		
		
	data1out(0) <= ((reg1Out(0))and(read1addr1))or((reg2Out(0))and(read1addr2))or((reg3Out(0))and(read1addr3))or((reg4Out(0))and(read1addr4))or((reg5Out(0))and(read1addr5))or((reg6Out(0))and(read1addr6))or((reg7Out(0))and(read1addr7))or((reg8Out(0))and(read1addr8));
	data1out(1) <= ((reg1Out(1))and(read1addr1))or((reg2Out(1))and(read1addr2))or((reg3Out(1))and(read1addr3))or((reg4Out(1))and(read1addr4))or((reg5Out(1))and(read1addr5))or((reg6Out(1))and(read1addr6))or((reg7Out(1))and(read1addr7))or((reg8Out(1))and(read1addr8));
	data1out(2) <= ((reg1Out(2))and(read1addr1))or((reg2Out(2))and(read1addr2))or((reg3Out(2))and(read1addr3))or((reg4Out(2))and(read1addr4))or((reg5Out(2))and(read1addr5))or((reg6Out(2))and(read1addr6))or((reg7Out(2))and(read1addr7))or((reg8Out(2))and(read1addr8));
	data1out(3) <= ((reg1Out(3))and(read1addr1))or((reg2Out(3))and(read1addr2))or((reg3Out(3))and(read1addr3))or((reg4Out(3))and(read1addr4))or((reg5Out(3))and(read1addr5))or((reg6Out(3))and(read1addr6))or((reg7Out(3))and(read1addr7))or((reg8Out(3))and(read1addr8));
	data1out(4) <= ((reg1Out(4))and(read1addr1))or((reg2Out(4))and(read1addr2))or((reg3Out(4))and(read1addr3))or((reg4Out(4))and(read1addr4))or((reg5Out(4))and(read1addr5))or((reg6Out(4))and(read1addr6))or((reg7Out(4))and(read1addr7))or((reg8Out(4))and(read1addr8));
	data1out(5) <= ((reg1Out(5))and(read1addr1))or((reg2Out(5))and(read1addr2))or((reg3Out(5))and(read1addr3))or((reg4Out(5))and(read1addr4))or((reg5Out(5))and(read1addr5))or((reg6Out(5))and(read1addr6))or((reg7Out(5))and(read1addr7))or((reg8Out(5))and(read1addr8));
	data1out(6) <= ((reg1Out(6))and(read1addr1))or((reg2Out(6))and(read1addr2))or((reg3Out(6))and(read1addr3))or((reg4Out(6))and(read1addr4))or((reg5Out(6))and(read1addr5))or((reg6Out(6))and(read1addr6))or((reg7Out(6))and(read1addr7))or((reg8Out(6))and(read1addr8));
	data1out(7) <= ((reg1Out(7))and(read1addr1))or((reg2Out(7))and(read1addr2))or((reg3Out(7))and(read1addr3))or((reg4Out(7))and(read1addr4))or((reg5Out(7))and(read1addr5))or((reg6Out(7))and(read1addr6))or((reg7Out(7))and(read1addr7))or((reg8Out(7))and(read1addr8));
	
	data2out(0) <= ((reg1Out(0))and(read2addr1))or((reg2Out(0))and(read2addr2))or((reg3Out(0))and(read2addr3))or((reg4Out(0))and(read2addr4))or((reg5Out(0))and(read2addr5))or((reg6Out(0))and(read2addr6))or((reg7Out(0))and(read2addr7))or((reg8Out(0))and(read2addr8));
	data2out(1) <= ((reg1Out(1))and(read2addr1))or((reg2Out(1))and(read2addr2))or((reg3Out(1))and(read2addr3))or((reg4Out(1))and(read2addr4))or((reg5Out(1))and(read2addr5))or((reg6Out(1))and(read2addr6))or((reg7Out(1))and(read2addr7))or((reg8Out(1))and(read2addr8));
	data2out(2) <= ((reg1Out(2))and(read2addr1))or((reg2Out(2))and(read2addr2))or((reg3Out(2))and(read2addr3))or((reg4Out(2))and(read2addr4))or((reg5Out(2))and(read2addr5))or((reg6Out(2))and(read2addr6))or((reg7Out(2))and(read2addr7))or((reg8Out(2))and(read2addr8));
	data2out(3) <= ((reg1Out(3))and(read2addr1))or((reg2Out(3))and(read2addr2))or((reg3Out(3))and(read2addr3))or((reg4Out(3))and(read2addr4))or((reg5Out(3))and(read2addr5))or((reg6Out(3))and(read2addr6))or((reg7Out(3))and(read2addr7))or((reg8Out(3))and(read2addr8));
	data2out(4) <= ((reg1Out(4))and(read2addr1))or((reg2Out(4))and(read2addr2))or((reg3Out(4))and(read2addr3))or((reg4Out(4))and(read2addr4))or((reg5Out(4))and(read2addr5))or((reg6Out(4))and(read2addr6))or((reg7Out(4))and(read2addr7))or((reg8Out(4))and(read2addr8));
	data2out(5) <= ((reg1Out(5))and(read2addr1))or((reg2Out(5))and(read2addr2))or((reg3Out(5))and(read2addr3))or((reg4Out(5))and(read2addr4))or((reg5Out(5))and(read2addr5))or((reg6Out(5))and(read2addr6))or((reg7Out(5))and(read2addr7))or((reg8Out(5))and(read2addr8));
	data2out(6) <= ((reg1Out(6))and(read2addr1))or((reg2Out(6))and(read2addr2))or((reg3Out(6))and(read2addr3))or((reg4Out(6))and(read2addr4))or((reg5Out(6))and(read2addr5))or((reg6Out(6))and(read2addr6))or((reg7Out(6))and(read2addr7))or((reg8Out(6))and(read2addr8));
	data2out(7) <= ((reg1Out(7))and(read2addr1))or((reg2Out(7))and(read2addr2))or((reg3Out(7))and(read2addr3))or((reg4Out(7))and(read2addr4))or((reg5Out(7))and(read2addr5))or((reg6Out(7))and(read2addr6))or((reg7Out(7))and(read2addr7))or((reg8Out(7))and(read2addr8));

END struct;