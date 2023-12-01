----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2023 12:33:59
-- Design Name: 
-- Module Name: Pipeline_Register_one - Behavioral
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

ENTITY Pipeline_Register_one IS
    PORT (
        clk : IN STD_LOGIC;
        Instr_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        Instr_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END Pipeline_Register_one;

ARCHITECTURE Behavioral OF Pipeline_Register_one IS

BEGIN

    Instr_out <= Instr_in;
END Behavioral;