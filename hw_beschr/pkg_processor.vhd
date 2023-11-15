LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE pkg_processor IS

  CONSTANT op_add : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000"; -- Addition
  CONSTANT op_NOP : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000"; -- NoOperation (als Addition implementiert, die Ergebnisse
  -- werden aber nicht gespeichert...
  --CONSTANT op_lsl : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
  CONSTANT op_cp : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001"; -- compare 
  CONSTANT op_sub : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001"; -- Subtraction
  CONSTANT op_ADC : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001"; -- ADD with carry
  CONSTANT sub_op_ADC : STD_LOGIC_VECTOR(1 DOWNTO 0) := "11"; -- Add with carry

  CONSTANT op_or : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010"; -- bitwise OR
  CONSTANT sub_op_or : STD_LOGIC_VECTOR(1 DOWNTO 0) := "10"; -- or
  CONSTANT op_and : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010"; -- bitwise OR
  CONSTANT sub_op_and : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00"; -- or
  CONSTANT op_eor : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010"; -- bitwise OR
  CONSTANT sub_op_eor : STD_LOGIC_VECTOR(1 DOWNTO 0) := "01"; -- or
  CONSTANT op_MOV : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010"; -- MOV
  CONSTANT sub_op_MOV : STD_LOGIC_VECTOR(1 DOWNTO 0) := "11"; -- MOV
  CONSTANT op_cpi : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0011"; -- CPI
  CONSTANT op_subi : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0011"; -- subi
  CONSTANT op_ori : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0110"; -- ori
  CONSTANT op_andi : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0111"; -- andi
  CONSTANT op_ldi : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1110"; -- Load immediate
END pkg_processor;