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
    ld_PC_val : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    sel_PC_LDI_VAL : IN STD_LOGIC;
    sel_PC_ADD_VAL : IN STD_LOGIC;
    Addr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0));
END Program_Counter;

-- Rudimentaerer Programmzaehler ohne Ruecksetzen und springen...

ARCHITECTURE Behavioral OF Program_Counter IS
  SIGNAL PC_reg : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL one : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL MUX_ADD_Addr_out : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL MUX_LDI_Addr_out : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL ADD_out : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL ld_PC_val_inc : STD_LOGIC_VECTOR(8 DOWNTO 0);

BEGIN
  one <= "000000001";
  count : PROCESS (clk)
  BEGIN -- process count
    IF clk'event AND clk = '1' THEN -- rising clock edge
      IF reset = '1' THEN -- synchronous reset (active high)
        PC_reg <= "111111111"; -- schneller machen vielleicht
        ELSE
        IF CLK_Disable_ProgCntr = '0' THEN
          PC_reg <= MUX_LDI_Addr_out;
        END IF;
      END IF;
    END IF;
  END PROCESS count;

  MUX_ADD : PROCESS (clk, sel_PC_ADD_VAL, ld_PC_val_inc, one)
  BEGIN
    IF sel_PC_ADD_VAL = '0' THEN
      MUX_ADD_Addr_out <= one;
      ELSE
      MUX_ADD_Addr_out <= ld_PC_val_inc;
    END IF;
  END PROCESS MUX_ADD;

  ADDer : PROCESS (clk, PC_reg, MUX_ADD_Addr_out)
  BEGIN
    ADD_out <= STD_LOGIC_VECTOR(unsigned(PC_reg) + unsigned(MUX_ADD_Addr_out));
  END PROCESS ADDer;
  ADD_Val : PROCESS (clk, PC_reg, ld_PC_val, one)
  BEGIN
    ld_PC_val_inc <= STD_LOGIC_VECTOR(unsigned(ld_PC_val) + unsigned(one));
  END PROCESS ADD_Val;

  MUX_LD : PROCESS (clk, sel_PC_LDI_VAL, ADD_out, ld_PC_val)
  BEGIN
    IF sel_PC_LDI_VAL = '0' THEN
      MUX_LDI_Addr_out <= ADD_out;
      ELSE
      MUX_LDI_Addr_out <= ld_PC_val;
    END IF;
  END PROCESS MUX_LD;

  Addr <= MUX_LDI_Addr_out;--PC_reg;

END Behavioral;