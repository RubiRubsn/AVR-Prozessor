----------------------------------------------------------------------------------
-- Engineer: B. Eng. Saitz, Ruben Herman Felix
-- 
-- Module Name: prog_mem - Behavioral
-- Project Name: RISC CPU
-- Target Devices: ARTIX 7
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
LIBRARY work;
USE work.pkg_instrmem.ALL;

USE IEEE.NUMERIC_STD.ALL;
ENTITY prog_mem IS
  PORT (
    Addr : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    Instr : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END prog_mem;

ARCHITECTURE Behavioral OF prog_mem IS

BEGIN
  Instr <= PROGMEM(to_integer(unsigned(Addr)));
END Behavioral;