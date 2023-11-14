LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE pkg_processor IS

  CONSTANT op_add : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000"; -- Addition
  CONSTANT op_NOP : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000"; -- NoOperation (als Addition implementiert, die Ergebnisse
  -- werden aber nicht gespeichert...
  --CONSTANT op_lsl : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
  CONSTANT op_cp : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001"; -- compare 
  CONSTANT op_sub : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001"; -- Subtraction

  CONSTANT op_or : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010"; -- bitwise OR
  CONSTANT op_ldi : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1110"; -- Load immediate
END pkg_processor;