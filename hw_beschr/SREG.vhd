----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2023 13:58:15
-- Design Name: 
-- Module Name: SREG - Behavioral
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

ENTITY SREG IS
    PORT (
        clk : IN STD_LOGIC;
        Status : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        w_e_SREG : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        Status_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
END SREG;

ARCHITECTURE Behavioral OF SREG IS
    SIGNAL i : STD_LOGIC := '0';
    SIGNAL t : STD_LOGIC := '0';
    SIGNAL h : STD_LOGIC := '0';
    SIGNAL s : STD_LOGIC := '0';
    SIGNAL v : STD_LOGIC := '0';
    SIGNAL n : STD_LOGIC := '0';
    SIGNAL z : STD_LOGIC := '0';
    SIGNAL c : STD_LOGIC := '0';
    SIGNAL WE : STD_LOGIC_VECTOR (7 DOWNTO 0);
BEGIN
    WE <= w_e_SREG;
    Status_out <= i & t & h & s & v & n & z & c;

    ff : PROCESS (clk)
    BEGIN
        IF clk'event AND clk = '1' THEN
            IF WE(0) = '1' THEN
                c <= Status(0);
            END IF;
            IF WE(1) = '1' THEN
                z <= Status(1);
            END IF;
            IF WE(2) = '1' THEN
                n <= Status(2);
            END IF;
            IF WE(3) = '1' THEN
                v <= Status(3);
            END IF;
            IF WE(4) = '1' THEN
                s <= Status(4);
            END IF;
            IF WE(5) = '1' THEN
                h <= Status(5);
            END IF;
            IF WE(6) = '1' THEN
                t <= Status(6);
            END IF;
            IF WE(7) = '1' THEN
                i <= Status(7);
            END IF;
        END IF;
    END PROCESS ff;

END Behavioral;