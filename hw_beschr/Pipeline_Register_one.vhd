----------------------------------------------------------------------------------
-- Engineer: B. Eng. Saitz, Ruben Herman Felix
-- 
-- Create Date: 01.12.2023 12:33:59
-- Module Name: Pipeline_Register_one - Behavioral
-- Project Name: RISC CPU
-- Target Devices: ARTIX 7
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY Pipeline_Register_one IS
    PORT (
        clk : IN STD_LOGIC;
        Write_disable_PR1 : IN STD_LOGIC;
        Instr_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        Instr_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END Pipeline_Register_one;

ARCHITECTURE Behavioral OF Pipeline_Register_one IS
    SIGNAL P_Register_instr : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
    P_reg : PROCESS (clk, Write_disable_PR1)
    BEGIN
        IF clk'event AND clk = '1' THEN
            IF Write_disable_PR1 = '0' THEN
                P_Register_instr <= Instr_in;
            END IF;
        END IF;
    END PROCESS P_reg;
    Instr_out <= P_Register_instr;
END Behavioral;