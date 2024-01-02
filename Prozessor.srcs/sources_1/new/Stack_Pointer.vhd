----------------------------------------------------------------------------------
-- Engineer: B. Eng. Saitz, Ruben Herman Felix
-- 
-- Create Date: 20.11.2023 15:18:27
-- Module Name: Stack_Pointer - Behavioral
-- Project Name: RISC CPU
-- Target Devices: ARTIX 7
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Stack_Pointer IS
    PORT (
        clk : IN STD_LOGIC;
        SEL_ADD_SP : IN STD_LOGIC;
        WE_SP : IN STD_LOGIC;
        Addr : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
END Stack_Pointer;

ARCHITECTURE Behavioral OF Stack_Pointer IS
    SIGNAL Summand : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL RES : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL FF_O : STD_LOGIC_VECTOR (9 DOWNTO 0) := "1111111111";
    SIGNAL FF_DEC_O : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";

BEGIN
    Summand <= "0000000001" WHEN SEL_ADD_SP = '0' ELSE
        "1111111111";
    RES <= STD_LOGIC_VECTOR(unsigned(FF_O) + unsigned(Summand));

    FF : PROCESS (clk, RES, WE_SP)
    BEGIN
        IF clk'event AND clk = '1' THEN
            IF WE_SP = '1' THEN
                FF_O <= RES;
            END IF;
        END IF;
    END PROCESS; -- FF
    FF_dec : PROCESS (clk, RES, WE_SP)
    BEGIN
        IF clk'event AND clk = '1' THEN
            IF WE_SP = '1' THEN
                FF_DEC_O <= STD_LOGIC_VECTOR(unsigned(RES) + 1);
            END IF;
        END IF;
    END PROCESS; -- FFdec
    Addr <= FF_O WHEN SEL_ADD_SP = '1' ELSE
        FF_DEC_O;
END Behavioral;