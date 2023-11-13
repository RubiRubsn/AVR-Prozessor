----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/23/2015 08:01:02 AM
-- Design Name: 
-- Module Name: prog_mem - Behavioral
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
LIBRARY work;
USE work.pkg_instrmem.ALL;

-- following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY prog_mem IS
  PORT (
    Addr : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
    Instr : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END prog_mem;

ARCHITECTURE Behavioral OF prog_mem IS

BEGIN
  Instr <= PROGMEM(to_integer(unsigned(Addr)));

END Behavioral;