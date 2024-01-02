----------------------------------------------------------------------------------
-- Engineer: B. Eng. Saitz, Ruben Herman Felix
-- 
-- Module Name: Data_Memory - Behavioral
-- Project Name: RISC CPU
-- Target Devices: ARTIX 7
-- 
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Data_Memory IS
    PORT (
        CLK : IN STD_LOGIC;
        WE : IN STD_LOGIC;
        A : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        DI : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        DO : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END Data_Memory;

ARCHITECTURE Behavioral OF Data_Memory IS
    TYPE ram_type IS ARRAY (1023 DOWNTO 0) OF STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL RAM : ram_type;
BEGIN

    PROCESS (CLK)
    BEGIN
        IF (CLK'event AND CLK = '1') THEN
            IF (WE = '1') THEN
                RAM(to_integer(unsigned(A))) <= DI;
            END IF;
        END IF;
    END PROCESS;

    DO <= RAM(to_integer(unsigned(A)));

END Behavioral;