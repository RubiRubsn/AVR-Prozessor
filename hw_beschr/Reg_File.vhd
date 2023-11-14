----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/23/2015 08:06:23 PM
-- Design Name: 
-- Module Name: Reg_File - Behavioral
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
ENTITY Reg_File IS
  PORT (
    clk : IN STD_LOGIC;
    addr_opa : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
    addr_opb : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
    w_e_regfile : IN STD_LOGIC;
    data_opa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
    data_opb : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
    data_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0)
  );
END Reg_File;

-- ACHTUNG!!! So einfach wird das mit dem Registerfile am Ende nicht.
-- hier muss noch einiges bzgl. Load/Store gemacht werden...
ARCHITECTURE Behavioral OF Reg_File IS
  TYPE regs IS ARRAY(31 DOWNTO 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL register_speicher : regs;
BEGIN

  -- purpose: einfacher Schreibprozess für rudimentaeres Registerfile
  -- type   : sequential
  -- inputs : clk, addr_opa, w_e_regfile, data_res
  -- outputs: register_speicher
  registerfile : PROCESS (clk)
  BEGIN -- process registerfile
    IF clk'event AND clk = '1' THEN -- rising clock edge
      IF w_e_regfile = '1' THEN
        register_speicher(to_integer(unsigned(addr_opa))) <= data_in;
      END IF;
    END IF;
  END PROCESS registerfile;

  -- nebenlaeufiges Lesen der Registerspeicher
  data_opa <= register_speicher(to_integer(unsigned(addr_opa)));
  data_opb <= register_speicher(to_integer(unsigned(addr_opb)));

END Behavioral;