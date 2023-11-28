----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2023 15:17:58
-- Design Name: 
-- Module Name: Ports_decoder - Behavioral
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

ENTITY Ports_decoder IS
    PORT (
        Addr_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
        new_addr_out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        is_PORT : OUT STD_LOGIC);
END Ports_decoder;

ARCHITECTURE Behavioral OF Ports_decoder IS
    SIGNAL new_addr : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL is_port_intern : STD_LOGIC;
    SIGNAL w_mask_intern : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Addr_in_intern : STD_LOGIC_VECTOR (9 DOWNTO 0);
BEGIN
    Addr_in_intern <= Addr_in;
    dec_ports : PROCESS (Addr_in_intern)
    BEGIN
        is_port_intern <= '0';
        new_addr <= "0000";
        w_mask_intern <= "00000000";
        CASE (Addr_in_intern) IS
            WHEN "0000110000" =>
                --PIND
                new_addr <= "0000";
                w_mask_intern <= "00000000";
                is_port_intern <= '1';
            WHEN "0000110011" =>
                --PINC    
                new_addr <= "0001";
                w_mask_intern <= "00000000";
                is_port_intern <= '1';
            WHEN "0000110110" =>
                --PINB
                new_addr <= "0010";
                w_mask_intern <= "00000000";
                is_port_intern <= '1';
            WHEN "0000110101" =>
                --PORTC
                new_addr <= "0011";
                is_port_intern <= '1';
            WHEN "0000111000" =>
                --PORTB
                new_addr <= "0100";
                is_port_intern <= '1';
            WHEN "0001000000" =>
                --SER
                new_addr <= "0101";
                is_port_intern <= '1';
            WHEN "0001000001" =>
                --seg0_N
                new_addr <= "0110";
                is_port_intern <= '1';
            WHEN "0001000010" =>
                --seg1_n
                new_addr <= "0111";
                is_port_intern <= '1';

            WHEN "0001000011" =>
                --seg2_n
                new_addr <= "1000";
                is_port_intern <= '1';
            WHEN "0001000100" =>
                --seg3_n
                new_addr <= "1001";
                is_port_intern <= '1';
            WHEN "0001010000" =>
                --i2c_SCR
                new_addr <= "1010";
                is_port_intern <= '1';
            WHEN "0001010001" =>
                --i2c_DaTR
                new_addr <= "1011";
                is_port_intern <= '1';
            WHEN "0001010010" =>
                --i2c_DaRR
                new_addr <= "1100";
                is_port_intern <= '1';
            WHEN OTHERS => NULL;
        END CASE;
    END PROCESS; -- dec_ports
    is_PORT <= is_port_intern;
    new_addr_out <= new_addr;

END Behavioral;