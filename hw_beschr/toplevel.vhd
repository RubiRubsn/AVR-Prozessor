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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY toplevel IS
  PORT (

    -- global ports
    reset : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    PIN : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
    PORT_SEG : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    SEG_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    SEG_AN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    -- ports to "decoder_1"
    --w_e_SREG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- ports to "ALU_1"
    --Status : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
  );

END toplevel;

ARCHITECTURE Behavioral OF toplevel IS
  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------

  -- outputs of "Program_Counter_1"
  SIGNAL Addr : STD_LOGIC_VECTOR (8 DOWNTO 0);

  -- outputs of "prog_mem_1"
  SIGNAL Instr : STD_LOGIC_VECTOR (15 DOWNTO 0);

  -- outputs of "decoder_1"
  SIGNAL addr_opa : STD_LOGIC_VECTOR(4 DOWNTO 0);
  SIGNAL addr_opb : STD_LOGIC_VECTOR(4 DOWNTO 0);
  SIGNAL OPCODE : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL w_e_regfile : STD_LOGIC;
  SIGNAL sel_immediate : STD_LOGIC;
  SIGNAL K : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL DM_W_E : STD_LOGIC;
  SIGNAL SEL_MUX_RES : STD_LOGIC;
  SIGNAL CD_PC : STD_LOGIC;
  SIGNAL W_E_SM : STD_LOGIC;
  SIGNAL STATE_DEC_TO_SM : STD_LOGIC_VECTOR(1 DOWNTO 0);

  -- outputs of State Machine
  SIGNAL STATE_SM_TO_DEC : STD_LOGIC_VECTOR (1 DOWNTO 0);

  -- outputs of Regfile
  SIGNAL data_opa : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL data_opb : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL Z_A : STD_LOGIC_VECTOR (9 DOWNTO 0);
  --output of MUX
  SIGNAL REG_DI : STD_LOGIC_VECTOR (7 DOWNTO 0);

  --output of Data Memory
  SIGNAL RAM_DO : STD_LOGIC_VECTOR (7 DOWNTO 0);
  --alu
  SIGNAL data_res : STD_LOGIC_VECTOR(7 DOWNTO 0); --output from alu
  -- auxiliary signals
  SIGNAL PM_data : STD_LOGIC_VECTOR(7 DOWNTO 0); -- used for wiring immediate data

  SIGNAL Status : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL SREG_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL w_e_SREG : STD_LOGIC_VECTOR(7 DOWNTO 0);

  SIGNAL SEL_ADD_SP : STD_LOGIC;
  SIGNAL SEL_DM_ADR : STD_LOGIC;
  SIGNAL WE_SP : STD_LOGIC;
  SIGNAL Z_SP_Addr : STD_LOGIC_VECTOR(9 DOWNTO 0);
  SIGNAL SP_Addr : STD_LOGIC_VECTOR(9 DOWNTO 0);

  SIGNAL PIN_intern : STD_LOGIC_VECTOR (20 DOWNTO 0);
  SIGNAL PORT_SEG_intern : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL DOUT_IO : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL SW_MUX_IO_DM_HIGH : STD_LOGIC;

  SIGNAL SEG : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL SEG_EN : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL SEG_out_intern : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL SEG_AN_intern : STD_LOGIC_VECTOR(3 DOWNTO 0);
  -----------------------------------------------------------------------------
  -- Component declarations
  -----------------------------------------------------------------------------

  COMPONENT Program_Counter
    PORT (
      reset : IN STD_LOGIC;
      clk : IN STD_LOGIC;
      CD_PC : IN STD_LOGIC;
      Addr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0));
  END COMPONENT;

  COMPONENT prog_mem
    PORT (
      Addr : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
      Instr : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
  END COMPONENT;

  COMPONENT decoder
    PORT (
      Instr : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      STATE_IN : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      addr_opa : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      addr_opb : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      OPCODE : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      w_e_regfile : OUT STD_LOGIC;
      w_e_SREG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      K : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      DM_W_E : OUT STD_LOGIC;
      SEL_MUX_RES : OUT STD_LOGIC;
      SEL_ADD_SP : OUT STD_LOGIC;
      SEL_DM_ADR : OUT STD_LOGIC;
      WE_SP : OUT STD_LOGIC;
      CD_PC : OUT STD_LOGIC;
      W_E_SM : OUT STD_LOGIC;
      STATE_OUT : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
      --hier fehlt etwas
    );

  END COMPONENT;

  COMPONENT State_Machine
    PORT (
      clk : STD_LOGIC;
      State_in : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      W_E : IN STD_LOGIC;
      State_Out : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT SREG
    PORT (
      clk : IN STD_LOGIC;
      Status : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      w_e_SREG : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      Status_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT Reg_File
    PORT (
      clk : IN STD_LOGIC;
      addr_opa : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
      addr_opb : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
      w_e_regfile : IN STD_LOGIC;
      data_opa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      data_opb : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      data_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0); -- muss ich noch einsortieren sieht ja unmöglich aus hier...
      Z : OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
      --data_res : IN STD_LOGIC_VECTOR (7 DOWNTO 0)
      --hier fehlt etwas
    );
  END COMPONENT;

  COMPONENT Stack_Pointer
    PORT (
      clk : IN STD_LOGIC;
      SEL_ADD_SP : IN STD_LOGIC;
      WE_SP : IN STD_LOGIC;
      Addr : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
  END COMPONENT;

  COMPONENT Data_Memory
    PORT (
      CLK : IN STD_LOGIC;
      WE : IN STD_LOGIC;
      A : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      DI : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      DO : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT Ports
    PORT (
      clk : IN STD_LOGIC;
      WE : IN STD_LOGIC;
      Addr_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
      Din : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      PIN : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
      PORT_SEG : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      Dout : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      SW_Mux : OUT STD_LOGIC;
      SEG : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
      SEG_EN : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
  END COMPONENT;

  COMPONENT ALU
    PORT (
      OPCODE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      OPA : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      OPB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      K : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      SREG_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      RES : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      Status : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
  END COMPONENT;

  COMPONENT puls_seg
    PORT (
      clk : IN STD_LOGIC;
      en_seg_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      SEG_in : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
      SEG_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      en_seg_out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
  END COMPONENT;

BEGIN

  -----------------------------------------------------------------------------
  -- Component instantiations
  -----------------------------------------------------------------------------

  -- instance "Program_Counter_1"
  Program_Counter_1 : Program_Counter
  PORT MAP(
    reset => reset,
    clk => clk,
    CD_PC => CD_PC,
    Addr => Addr);

  -- instance "prog_mem_1"
  prog_mem_1 : prog_mem
  PORT MAP(
    Addr => Addr,
    Instr => Instr);

  -- instance "decoder_1"
  decoder_1 : decoder
  PORT MAP(
    Instr => Instr,
    STATE_IN => STATE_SM_TO_DEC,
    addr_opa => addr_opa,
    addr_opb => addr_opb,
    OPCODE => OPCODE,
    w_e_regfile => w_e_regfile,
    w_e_SREG => w_e_SREG,
    K => K,
    DM_W_E => DM_W_E,
    SEL_MUX_RES => SEL_MUX_RES,
    SEL_ADD_SP => SEL_ADD_SP,
    SEL_DM_ADR => SEL_DM_ADR,
    WE_SP => WE_SP,
    CD_PC => CD_PC,
    W_E_SM => W_E_SM,
    STATE_OUT => STATE_DEC_TO_SM
  );

  STATE_MACHINE_1 : State_Machine
  PORT MAP(
    clk => clk,
    State_in => STATE_DEC_TO_SM,
    W_E => W_E_SM,
    State_Out => STATE_SM_TO_DEC
  );

  -- instance "Reg_File_1"

  Reg_File_1 : Reg_File
  PORT MAP(
    clk => clk,
    addr_opa => addr_opa,
    addr_opb => addr_opb,
    w_e_regfile => w_e_regfile,
    data_opa => data_opa,
    data_opb => data_opb,
    data_in => REG_DI,
    Z => Z_A);

  Stack_Pointer_1 : Stack_Pointer
  PORT MAP(
    clk => clk,
    SEL_ADD_SP => SEL_ADD_SP,
    WE_SP => WE_SP,
    Addr => SP_Addr
  );

  Data_Memory_1 : Data_Memory
  PORT MAP(
    CLK => clk,
    WE => DM_W_E,
    A => Z_SP_Addr,
    DI => data_opa,
    DO => RAM_DO
  );

  Ports_1 : Ports
  PORT MAP(
    clk => clk,
    WE => DM_W_E,
    Addr_in => Z_SP_Addr,
    Din => data_opa,
    PIN => PIN_intern,
    PORT_SEG => PORT_SEG_intern,
    Dout => DOUT_IO,
    SW_MUX => SW_MUX_IO_DM_HIGH,
    SEG => SEG,
    SEG_EN => SEG_EN
  );

  -- instance "ALU_1"
  ALU_1 : ALU
  PORT MAP(
    OPCODE => OPCODE,
    OPA => data_opa,
    OPB => data_opb,
    RES => data_res,
    Status => Status,
    K => K,
    SREG_IN => SREG_OUT);

  SREG_1 : SREG
  PORT MAP(
    clk => clk,
    Status => Status,
    w_e_SREG => w_e_SREG,
    Status_out => SREG_OUT
  );
  puls_seg_1 : puls_seg
  PORT MAP(
    clk => clk,
    en_seg_in => SEG_EN,
    SEG_in => SEG,
    SEG_out => SEG_out_intern,
    en_seg_out => SEG_AN_intern);

  Din_Reg_file_MUX : PROCESS (SW_MUX_IO_DM_HIGH, SEL_MUX_RES, data_res, RAM_DO, DOUT_IO)
  BEGIN
    REG_DI <= "00000000";

    IF SEL_MUX_RES = '0' THEN
      REG_DI <= data_res;
    ELSE
      IF SW_MUX_IO_DM_HIGH = '0' THEN
        REG_DI <= RAM_DO;
      ELSE
        REG_DI <= DOUT_IO;
      END IF;
    END IF;
  END PROCESS; -- Din_Reg_file_MUX

  PM_Data <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
  Z_SP_Addr <= Z_A WHEN SEL_DM_ADR = '0' ELSE
    SP_Addr;

  PIN_intern <= PIN;

  PORT_SEG <= PORT_SEG_intern;
  SEG_out <= SEG_out_intern;
  SEG_AN <= SEG_AN_intern;

END Behavioral;