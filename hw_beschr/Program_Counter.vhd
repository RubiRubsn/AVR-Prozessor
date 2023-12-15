----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/23/2015 08:30:37 PM
-- Design Name: 
-- Module Name: Program_Counter - Behavioral
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
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY Program_Counter IS
  PORT (
    reset : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    CLK_Disable_ProgCntr : IN STD_LOGIC;
    add_PC_val : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    sel_PC_OUT : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    PC_save_val : IN STD_LOGIC;

    Addr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0));
END Program_Counter;

-- Rudimentaerer Programmzaehler ohne Ruecksetzen und springen...

ARCHITECTURE Behavioral OF Program_Counter IS
  SIGNAL PC_reg : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL OUT_MUX : STD_LOGIC_VECTOR (8 DOWNTO 0);

  SIGNAL one : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL MUX_ADD_Addr_out : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL MUX_LDI_Addr_out : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL ADD_out : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL add_PC_val_inc : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL STR_cntr_val : STD_LOGIC_VECTOR(8 DOWNTO 0);

BEGIN
  one <= "000000001";
  count : PROCESS (clk, ADD_out, CLK_Disable_ProgCntr, reset)
  BEGIN -- process count
    IF clk'event AND clk = '1' THEN -- rising clock edge
      IF reset = '1' THEN -- synchronous reset (active high)
        PC_reg <= "000000000"; -- schneller machen vielleicht
        ELSE
        IF CLK_Disable_ProgCntr = '0' THEN
          PC_reg <= ADD_out;
        END IF;
      END IF;
    END IF;
  END PROCESS count;

  -- MUX_ADD : PROCESS (clk, sel_PC_OUT, add_PC_val, one)
  -- BEGIN
  --   IF sel_PC_OUT = '0' THEN
  --     MUX_ADD_Addr_out <= one;
  --     ELSE
  --     MUX_ADD_Addr_out <= add_PC_val;
  --   END IF;
  -- END PROCESS MUX_ADD;

  MUX_OUT : PROCESS (clk, PC_reg, add_PC_val, STR_cntr_val, sel_PC_OUT)
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

  Addr <= OUT_MUX;-- MUX_LDI_Addr_out;--PC_reg;

END Behavioral;