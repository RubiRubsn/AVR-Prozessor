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
    Addr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0));
END Program_Counter;

-- Rudimentaerer Programmzaehler ohne Ruecksetzen und springen...

ARCHITECTURE Behavioral OF Program_Counter IS
  SIGNAL PC_reg : STD_LOGIC_VECTOR(8 DOWNTO 0);
BEGIN
  count : PROCESS (clk)
  BEGIN -- process count
    IF clk'event AND clk = '1' THEN -- rising clock edge
      IF reset = '1' THEN -- synchronous reset (active high)
        PC_reg <= "000000000";
      ELSE
        IF CLK_Disable_ProgCntr = '0' THEN
          PC_reg <= STD_LOGIC_VECTOR(unsigned(PC_reg) + 1);
        END IF;
      END IF;
    END IF;
  END PROCESS count;

  Addr <= PC_reg;

END Behavioral;