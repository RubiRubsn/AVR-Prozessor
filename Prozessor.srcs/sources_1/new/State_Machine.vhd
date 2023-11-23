----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2023 13:06:56
-- Design Name: 
-- Module Name: State_Machine - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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