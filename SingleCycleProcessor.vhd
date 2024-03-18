LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY SingleCycleProcessor IS
	PORT(
		clk,reset: IN STD_LOGIC;
		valueSelect: IN STD_LOGIC_VECTOR(2 downto 0);
		Instruction: IN STD_LOGIC_VECTOR (31 downto 0);
		ReadData: IN STD_LOGIC_VECTOR (7 downto 0);
		WriteData: OUT STD_LOGIC_VECTOR (7 downto 0);
		ReadAddr,WriteAddress : OUT STD_LOGIC_VECTOR (7 downto 0);
		MUXOut: OUT STD_LOGIC_VECTOR(7 downto 0);
		InstructionOut: OUT STD_LOGIC_VECTOR(31 downto 0);
		ReadAddress: OUT STD_LOGIC_VECTOR (31 downto 0);
		branchOut: OUT STD_LOGIC;
		zeroOut: OUT STD_LOGIC;
		memWriteOut: OUT STD_LOGIC;
		regWriteOut: OUT STD_LOGIC
	);
END SingleCycleProcessor;

ARCHITECTURE struct OF SingleCycleProcessor IS
SIGNAL operation: STD_LOGIC_VECTOR(2 downto 0);
SIGNAL memRead,memToReg,ALUop0,ALUop1: STD_LOGIC;
SIGNAL regDst,jump,branch: STD_LOGIC;
SIGNAL memWrite,ALUSrc, regWrite: STD_LOGIC;
SIGNAL signExtOut,pcOut,adder1Out,adder2Out: STD_LOGIC_VECTOR(31 downto 0);
SIGNAL shift1Out,jumpAddr,branchMUX,pcMUX: STD_LOGIC_VECTOR(31 downto 0);
SIGNAL writeMUX: STD_LOGIC_VECTOR(4 downto 0);
SIGNAL data1,data2,dataMUX,data2MUX: STD_LOGIC_VECTOR(7 downto 0);
SIGNAL zero: STD_LOGIC;
SIGNAL result, control_signals: STD_LOGIC_VECTOR(7 downto 0);

	COMPONENT ALU
		PORT(
			data1,data2: IN STD_LOGIC_VECTOR(7 downto 0);
			controlSig: IN STD_LOGIC_VECTOR(2 downto 0);
			
			zero: OUT STD_LOGIC;
			result_out: OUT STD_LOGIC_VECTOR(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT registers
		PORT(
			readReg1,readReg2,writeReg: IN STD_LOGIC_VECTOR(4 downto 0);
			writeData: IN STD_LOGIC_VECTOR(7 downto 0);
			reset,clk: IN STD_LOGIC;
			regWrite: IN STD_LOGIC;
			
			data1out,data2out: OUT STD_LOGIC_VECTOR(7 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT TwoToOneMuxEightBit IS
		PORT(
			a,b: IN STD_LOGIC_VECTOR (7 downto 0);
			sel: IN STD_LOGIC;
			MuxOut: OUT STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;

	COMPONENT TwoToOneMuxFiveBit IS
		PORT(
			a,b: IN STD_LOGIC_VECTOR (4 downto 0);
			sel: IN STD_LOGIC;
			MuxOut: OUT STD_LOGIC_VECTOR (4 downto 0)
		);
	END COMPONENT;
	
	COMPONENT controlSignals
		PORT(
			instr: IN STD_LOGIC_VECTOR(5 downto 0);
			
			regDst,jump,branch: OUT STD_LOGIC;
			memRead,memToReg,ALUOP1,ALUOP0: OUT STD_LOGIC;
			memWrite,ALUSrc, regWrite: OUT STD_LOGIC
		);
	END COMPONENT;
	
	
	COMPONENT ALU_control
		PORT(
			ALU_op0,ALU_op1: IN STD_LOGIC;
			func: IN STD_LOGIC_VECTOR(5 downto 0);
			
			operation: OUT STD_LOGIC_VECTOR(2 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SignExtendSixteen IS
		PORT(
			i_value: IN STD_LOGIC_VECTOR (15 downto 0);
			o_value: OUT STD_LOGIC_VECTOR (31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT CLA32Bit IS
		PORT(
			a,b: IN STD_LOGIC_VECTOR(31 downto 0);
			addOrSub: IN STD_LOGIC;
			carryIn: IN STD_LOGIC;
			s: OUT STD_LOGIC_VECTOR(31 downto 0);
			carryOut: OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT register32Bit IS
		PORT(	resetBar, load, clock: IN STD_LOGIC;
				inValues: IN STD_LOGIC_VECTOR(31 downto 0);
				outValues: OUT STD_LOGIC_VECTOR(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT shiftLeft32
		PORT(	
			a: IN STD_LOGIC_VECTOR(31 downto 0);
			x: OUT STD_LOGIC_VECTOR(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT TwoToOneMux32Bit
		PORT(
			a,b: IN STD_LOGIC_VECTOR (31 downto 0);
			sel: IN STD_LOGIC;
			MuxOut: OUT STD_LOGIC_VECTOR (31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MUX_Select
		PORT(
			sel: IN STD_LOGIC_VECTOR(2 downto 0);
			PC,ALU_res,D1,D2,WD,CS: IN STD_LOGIC_VECTOR(7 downto 0);
			
			M_out: OUT STD_LOGIC_VECTOR(7 downto 0)
		);
	END COMPONENT;

BEGIN

	
	
	
	ALU_comp: ALU
		PORT MAP(
			data1 => data1, data2 => data2MUX(7 downto 0),
			controlSig => operation,
			
			zero => zero,
			result_out => result
		);
	
	
	Registers_comp: registers
		PORT MAP(
			readReg1 => instruction(25 downto 21), readReg2 => instruction(20 downto 16), writeReg => writeMUX,
			writeData => dataMUX,
			reset => reset, clk => clk,
			regWrite => regWrite,
			
			data1out => data1, data2out => data2
		);
	
	extend: SignExtendSixteen
		PORT MAP(
			i_value => instruction(15 downto 0),
			o_value => signExtOut
		);
	
	MUX1: TwoToOneMuxFiveBit
	 PORT MAP(
		a => instruction(20 downto 16), b => instruction(15 downto 11),
		sel => RegDst,
		MuxOut => writeMUX
	 );
	
	MUX2: TwoToOneMuxEightBit
		PORT MAP(
			a => data2(7 downto 0), b => signExtOut(7 downto 0),
			sel => ALUSrc,
			MuxOut => data2MUX
		 );
	
	MUX3: TwoToOneMuxEightBit
		PORT MAP(
			a => result, b => ReadData,
			sel => memToReg,
			MuxOut => dataMUX
		 );
	
	MUX4: TwoToOneMux32Bit
		PORT MAP(
			a => adder1Out, b => adder2Out,
			sel => (zero)and(branch),
			muxOut => branchMUX
		);
	
	MUX5: TwoToOneMux32Bit
		PORT MAP(
			a(27 downto 0) => jumpAddr(27 downto 0), a(31 downto 28) => adder1Out(31 downto 28), b => branchMUX,
			sel => jump,
			muxOut => pcMUX
		);
	
	Control_comp: controlSignals
		PORT MAP(
			instr => instruction(31 downto 26),
			
			regDst => regDst, jump => jump, branch => branch,
			memRead => memRead, memToReg => memToReg, ALUOP1 => ALUop1, ALUOP0 => ALUop0,
			memWrite => memWrite, ALUSrc => ALUSrc, regWrite => regWrite
		);
	
	ALU_ctrl: ALU_control
		PORT MAP(
			ALU_op0 => ALUop0, ALU_op1 => ALUop1,
			func => instruction(5 downto 0),
			
			operation => operation
		);
		
	adder1: CLA32Bit
		PORT MAP(
			a => pcOut, b => "00000000000000000000000000000100",
			addOrSub => '0',
			carryIn =>  '0',
			s => adder1Out
		);
	
	adder2: CLA32Bit
		PORT MAP(
			a => adder1Out, b => shift1Out,
			addOrSub => '0',
			carryIn =>  '0',
			s => adder2Out
		);
		
	pc: register32Bit
		PORT MAP(
			resetBar => not(reset), load => '1', clock => clk,
			inValues => pcMUX,
			outValues => pcOut
		);
		
	shift1: shiftLeft32
		PORT MAP(
			a => signExtOut,
			x => shift1Out
		);
		
	shift2: shiftLeft32
		PORT MAP(
			a(25 downto 0) => instruction(25 downto 0),
			x(28 downto 0) => jumpAddr(28 downto 0)
		);
		
	control_signals(0) <= '0';
	control_signals(1) <= regDst;
	control_signals(2) <= jump;
	control_signals(3) <= memRead;
	control_signals(4) <= memToReg;
	control_signals(5) <= ALUop1;
	control_signals(6) <= ALUop0;
	control_signals(7) <= ALUSrc;
	
	MUX_S: MUX_Select
		PORT MAP(
			sel => ValueSelect,
			PC => pcOut(7 downto 0), ALU_res => result, D1 => data1, D2 => data2, WD => dataMUX, CS => control_signals,
			
			M_out => MUXOut
		);
		
	branchOut <= branch;
	ZeroOut <= zero;
	memWriteOut <= memWrite;
	RegWriteOut <= regWrite;
	
END struct;