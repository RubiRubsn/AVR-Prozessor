----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/23/2015 08:45:28 PM
-- Design Name: 
-- Module Name: toplevel - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.pkg_processor.ALL;
USE work.pkg_instrmem.ALL;

ENTITY toplevel IS
  PORT (
    reset : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    PIN : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
    PORT_SEG : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    SEG_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    SEG_AN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)

  );

END toplevel;

ARCHITECTURE Behavioral OF toplevel IS
  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------
  SIGNAL Instr_PR1_IN : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL Instr_PR1_OUT : STD_LOGIC_VECTOR(15 DOWNTO 0);

  --------------------------------------------------------------------------
  --              DEC outputs
  --------------------------------------------------------------------------
  SIGNAL Data_opa_PR2_IN : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL Data_opb_PR2_IN : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL SEL_result_PR2_IN : STD_LOGIC;
  SIGNAL SEL_ADD_SP_PR2_IN : STD_LOGIC;
  SIGNAL WE_SP_PR2_IN : STD_LOGIC;
  SIGNAL CLK_Disable_ProgCntr : STD_LOGIC;
  SIGNAL WE_SREG_PR2_IN : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL WE_DataMemory_PR2_IN : STD_LOGIC;
  SIGNAL SEL_DM_ADR_PR2_IN : STD_LOGIC;
  SIGNAL Z_PR2_IN : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL K_PR2_IN : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL OPCODE_PR2_IN : STD_LOGIC_VECTOR(3 DOWNTO 0);

  --------------------------------------------------------------------------
  --              Pipeline Register OUTS
  --------------------------------------------------------------------------

  SIGNAL Data_opa_PR2_OUT : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL Data_opb_PR2_OUT : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL SEL_result_PR2_OUT : STD_LOGIC;
  SIGNAL SEL_ADD_SP_PR2_OUT : STD_LOGIC;
  SIGNAL WE_SP_PR2_OUT : STD_LOGIC;

  SIGNAL WE_SREG_PR2_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);

  SIGNAL WE_DataMemory_PR2_OUT : STD_LOGIC;
  SIGNAL SEL_DM_ADR_PR2_OUT : STD_LOGIC;
  SIGNAL Z_PR2_OUT : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL K_PR2_OUT : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL OPCODE_PR2_OUT : STD_LOGIC_VECTOR(3 DOWNTO 0);

  SIGNAL REG_DI_intern : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL Status : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL PIN_intern : STD_LOGIC_VECTOR (20 DOWNTO 0);
  SIGNAL PORT_SEG_intern : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL SEG_out_intern : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL SEG_AN_intern : STD_LOGIC_VECTOR(3 DOWNTO 0);
  -----------------------------------------------------------------------------
  -- Component declarations
  -----------------------------------------------------------------------------
  COMPONENT Instruction_Fetch
    PORT (
      reset : IN STD_LOGIC;
      clk : IN STD_LOGIC;
      CLK_Disable_ProgCntr : IN STD_LOGIC;
      instr : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
  END COMPONENT;

  COMPONENT Pipeline_Register_one
    PORT (
      clk : IN STD_LOGIC;
      Instr_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      Instr_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
  END COMPONENT;

  COMPONENT DEC
    PORT (
      clk : IN STD_LOGIC;
      Instr_in : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      Status_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      REG_DI : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      Data_opa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      Data_opb : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      SEL_result : OUT STD_LOGIC;
      SEL_ADD_SP : OUT STD_LOGIC;
      WE_SP : OUT STD_LOGIC;
      CLK_Disable_ProgCntr : OUT STD_LOGIC;
      WE_SREG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      WE_DataMemory : OUT STD_LOGIC;
      SEL_DM_ADR : OUT STD_LOGIC;
      Z : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
      K : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      OPCODE : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
  END COMPONENT;

  COMPONENT Pipeline_Register_two
    PORT (
      clk : IN STD_LOGIC;
      Data_opa_PR2_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      Data_opb_PR2_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      SEL_result_PR2_IN : IN STD_LOGIC;
      SEL_ADD_SP_PR2_IN : IN STD_LOGIC;
      WE_SP_PR2_IN : IN STD_LOGIC;
      WE_SREG_PR2_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      WE_DataMemory_PR2_IN : IN STD_LOGIC;
      SEL_DM_ADR_PR2_IN : IN STD_LOGIC;
      Z_PR2_IN : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
      K_PR2_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      OPCODE_PR2_IN : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

      Data_opa_PR2_OUT : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      Data_opb_PR2_OUT : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      SEL_result_PR2_OUT : OUT STD_LOGIC;
      SEL_ADD_SP_PR2_OUT : OUT STD_LOGIC;
      WE_SP_PR2_OUT : OUT STD_LOGIC;
      WE_SREG_PR2_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      WE_DataMemory_PR2_OUT : OUT STD_LOGIC;
      SEL_DM_ADR_PR2_OUT : OUT STD_LOGIC;
      Z_PR2_OUT : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
      K_PR2_OUT : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      OPCODE_PR2_OUT : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
  END COMPONENT;

  COMPONENT Execute
    PORT (
      clk : IN STD_LOGIC;
      OPCODE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      OPA : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      OPB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      K : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      WE_SREG : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      SEL_result : IN STD_LOGIC;
      SEL_ADD_SP : IN STD_LOGIC;
      WE_SP : IN STD_LOGIC;
      WE_DataMemory : IN STD_LOGIC;
      SEL_DM_ADR : IN STD_LOGIC;
      Z : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      PIN : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
      PORT_SEG : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      SEG_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      SEG_AN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      REG_DI : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      Status_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT;

BEGIN

  -----------------------------------------------------------------------------
  -- Component instantiations
  -----------------------------------------------------------------------------

  -- instance "prog_mem_1"
  Instruction_Fetch_1 : Instruction_Fetch
  PORT MAP(
    reset => reset,
    clk => clk,
    CLK_Disable_ProgCntr => CLK_Disable_ProgCntr,
    Instr => Instr_PR1_IN);

  -- instance "Instruction_Fetch"
  Pipeline_Register_one_1 : Pipeline_Register_one
  PORT MAP(
    clk => clk,
    Instr_in => Instr_PR1_IN,
    Instr_out => Instr_PR1_OUT);

  DEC_1 : DEC
  PORT MAP(

    clk => clk,
    Instr_in => Instr_PR1_OUT,
    Status_IN => Status,
    REG_DI => REG_DI_intern,
    Data_opa => Data_opa_PR2_IN,
    Data_opb => Data_opb_PR2_IN,
    SEL_result => SEL_result_PR2_IN,
    SEL_ADD_SP => SEL_ADD_SP_PR2_IN,
    WE_SP => WE_SP_PR2_IN,
    CLK_Disable_ProgCntr => CLK_Disable_ProgCntr,
    WE_SREG => WE_SREG_PR2_IN,
    WE_DataMemory => WE_DataMemory_PR2_IN,
    SEL_DM_ADR => SEL_DM_ADR_PR2_IN,
    Z => Z_PR2_IN,
    K => K_PR2_IN,
    OPCODE => OPCODE_PR2_IN);

  Pipeline_Register_two_1 : Pipeline_Register_two
  PORT MAP(
    clk => clk,
    Data_opa_PR2_IN => Data_opa_PR2_IN,
    Data_opb_PR2_IN => Data_opb_PR2_IN,
    SEL_result_PR2_IN => SEL_result_PR2_IN,
    SEL_ADD_SP_PR2_IN => SEL_ADD_SP_PR2_IN,
    WE_SP_PR2_IN => WE_SP_PR2_IN,
    WE_SREG_PR2_IN => WE_SREG_PR2_IN,
    WE_DataMemory_PR2_IN => WE_DataMemory_PR2_IN,
    SEL_DM_ADR_PR2_IN => SEL_DM_ADR_PR2_IN,
    Z_PR2_IN => Z_PR2_IN,
    K_PR2_IN => K_PR2_IN,
    OPCODE_PR2_IN => OPCODE_PR2_IN,
    Data_opa_PR2_OUT => Data_opa_PR2_OUT,
    Data_opb_PR2_OUT => Data_opb_PR2_OUT,
    SEL_result_PR2_OUT => SEL_result_PR2_OUT,
    SEL_ADD_SP_PR2_OUT => SEL_ADD_SP_PR2_OUT,
    WE_SP_PR2_OUT => WE_SP_PR2_OUT,
    WE_SREG_PR2_OUT => WE_SREG_PR2_OUT,
    WE_DataMemory_PR2_OUT => WE_DataMemory_PR2_OUT,
    SEL_DM_ADR_PR2_OUT => SEL_DM_ADR_PR2_OUT,
    Z_PR2_OUT => Z_PR2_OUT,
    K_PR2_OUT => K_PR2_OUT,
    OPCODE_PR2_OUT => OPCODE_PR2_OUT);

  Execute_1 : Execute
  PORT MAP(
    clk => clk,
    OPCODE => OPCODE_PR2_OUT,
    OPA => Data_opa_PR2_OUT,
    OPB => Data_opb_PR2_OUT,
    K => K_PR2_OUT,
    WE_SREG => WE_SREG_PR2_OUT,
    SEL_result => SEL_result_PR2_OUT,
    SEL_ADD_SP => SEL_ADD_SP_PR2_OUT,
    WE_SP => WE_SP_PR2_OUT,
    WE_DataMemory => WE_DataMemory_PR2_OUT,
    SEL_DM_ADR => SEL_DM_ADR_PR2_OUT,
    Z => Z_PR2_OUT,
    PIN => PIN_intern,
    PORT_SEG => PORT_SEG_intern,
    SEG_out => SEG_out_intern,
    SEG_AN => SEG_AN_intern,
    REG_DI => REG_DI_intern,
    Status_out => Status
  );

  PIN_intern <= PIN;

  PORT_SEG <= PORT_SEG_intern;
  SEG_out <= SEG_out_intern;
  SEG_AN <= SEG_AN_intern;

END Behavioral;