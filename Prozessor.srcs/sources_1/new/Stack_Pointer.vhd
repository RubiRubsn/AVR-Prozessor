----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2023 15:18:27
-- Design Name: 
-- Module Name: Stack_Pointer - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY Stack_Pointer IS
    PORT (
        clk : IN STD_LOGIC;
        SEL_ADD_SP : IN STD_LOGIC;
        SEL_PM_ADR_WESP : IN STD_LOGIC;
        Addr : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
END Stack_Pointer;

ARCHITECTURE Behavioral OF Stack_Pointer IS
    SIGNAL Summand : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL RES : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL FF_O : STD_LOGIC_VECTOR (9 DOWNTO 0) := "1111111111";

BEGIN
    Summand <= "0000000001" WHEN SEL_ADD_SP = '0' ELSE
        "1111111111";
    RES <= STD_LOGIC_VECTOR(unsigned(FF_O) + unsigned(Summand));

    FF : PROCESS (clk, RES, SEL_PM_ADR_WESP)
    BEGIN
        IF clk'event AND clk = '1' THEN
            IF SEL_PM_ADR_WESP = '1' THEN
                FF_O <= RES;
            END IF;
        END IF;
    END PROCESS; -- FF
    Addr <= FF_O;
END Behavioral;