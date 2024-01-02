----------------------------------------------------------------------------------
-- Engineer: B. Eng. Saitz, Ruben Herman Felix
-- 
-- Create Date: 23.11.2023 13:06:56
-- Module Name: State_Machine - Behavioral
-- Project Name: RISC CPU
-- Target Devices: ARTIX 7
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY State_Machine IS
    PORT (
        clk : STD_LOGIC;
        State_in : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        W_E : IN STD_LOGIC;
        State_Out : OUT STD_LOGIC_VECTOR (1 DOWNTO 0));
END State_Machine;

ARCHITECTURE Behavioral OF State_Machine IS
    SIGNAL STATE : STD_LOGIC_VECTOR (1 DOWNTO 0) := "00";
BEGIN
    ff : PROCESS (clk)
    BEGIN
        IF clk'event AND clk = '1' THEN
            IF W_E = '1' THEN
                STATE <= State_in;
            END IF;
        END IF;

    END PROCESS ff;
    State_Out <= STATE;
END Behavioral;