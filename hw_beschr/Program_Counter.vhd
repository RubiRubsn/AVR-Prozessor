----------------------------------------------------------------------------------
-- Engineer: B. Eng. Saitz, Ruben Herman Felix
-- 
-- Module Name: Program_Counter - Behavioral
-- Project Name: RISC CPU
-- Target Devices: ARTIX 7
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Program_Counter IS
  PORT (
    -- reset : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    CLK_Disable_ProgCntr : IN STD_LOGIC;
    add_PC_val : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    sel_PC_OUT : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    PC_save_val : IN STD_LOGIC;
    PC_DISABLE_SAVE_FOR_RCAL : IN STD_LOGIC;
    PULL_ERG : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    save_addr_rcal : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    Addr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0));
END Program_Counter;

ARCHITECTURE Behavioral OF Program_Counter IS
  SIGNAL PC_reg : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL OUT_MUX : STD_LOGIC_VECTOR (8 DOWNTO 0);

  SIGNAL one : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL MUX_ADD_Addr_out : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL MUX_LDI_Addr_out : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL ADD_out : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL add_PC_val_inc : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL STR_cntr_val : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL save_addr_ret : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL save_addr_ret_higher : STD_LOGIC;

BEGIN
  one <= "000000001";
  count : PROCESS (clk, ADD_out, CLK_Disable_ProgCntr) --reset)
  BEGIN -- process count
    IF clk'event AND clk = '1' THEN -- rising clock edge
      IF CLK_Disable_ProgCntr = '0' THEN
        PC_reg <= ADD_out;
      END IF;
    END IF;
  END PROCESS count;
  MUX_OUT : PROCESS (clk, PC_reg, add_PC_val, STR_cntr_val, sel_PC_OUT, save_addr_ret, PULL_ERG, save_addr_ret_higher)
  BEGIN
    OUT_MUX <= PC_reg;
    CASE (sel_PC_OUT) IS
      WHEN "00" =>
        -- normal
        OUT_MUX <= PC_reg;
      WHEN "01" =>
        -- add_addr
        OUT_MUX <= STD_LOGIC_VECTOR(unsigned(PC_reg) + unsigned(add_PC_val));
      WHEN "10" =>
        -- load back branch
        OUT_MUX <= STR_cntr_val;
      WHEN "11" =>
        --ret
        OUT_MUX <= save_addr_ret_higher & save_addr_ret;
      WHEN OTHERS => NULL;
    END CASE;
  END PROCESS MUX_OUT;

  ADDer : PROCESS (clk, OUT_MUX)
  BEGIN
    ADD_out <= STD_LOGIC_VECTOR(unsigned(OUT_MUX) + 1);
  END PROCESS ADDer;

  save_old_val : PROCESS (clk, PC_reg, PC_save_val)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF PC_save_val = '1' THEN
        STR_cntr_val <= PC_reg;
      END IF;
    END IF;
  END PROCESS save_old_val;

  save_PC_Rcal : PROCESS (clk, PC_DISABLE_SAVE_FOR_RCAL, OUT_MUX)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF PC_DISABLE_SAVE_FOR_RCAL = '0' THEN
        save_addr_rcal <= ADD_out;
      END IF;
    END IF;
  END PROCESS save_PC_Rcal;

  save_PC_ret : PROCESS (clk, PULL_ERG)
  BEGIN
    IF clk'event AND clk = '1' THEN

      save_addr_ret <= PULL_ERG;

    END IF;
  END PROCESS save_PC_ret;
  save_PC_ret_higher : PROCESS (clk, save_addr_ret)
  BEGIN
    IF clk'event AND clk = '1' THEN

      save_addr_ret_higher <= save_addr_ret(0);

    END IF;
  END PROCESS save_PC_ret_higher;
  Addr <= OUT_MUX;

END Behavioral;