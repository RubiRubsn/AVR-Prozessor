----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2023 14:36:28
-- Design Name: 
-- Module Name: Ports - Behavioral
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

ENTITY Ports IS
    PORT (
        clk : IN STD_LOGIC;
        WE : IN STD_LOGIC;
        Addr_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
        Din : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        PIN : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
        PORT_SEG : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        Dout : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        SW_Mux : OUT STD_LOGIC);
END Ports;

ARCHITECTURE Behavioral OF Ports IS
    SIGNAL PIND : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL PINC : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL PINB : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL PORTC : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL PORTB : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL SER : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL seg0_N : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL seg1_N : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL seg2_N : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL seg3_N : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL i2c_SCR : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL i2c_DaTR : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL i2c_DaRR : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Dout_int : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Addr_to_dec : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL Addr : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL is_PORT : STD_LOGIC;

    -------------------------------------------------------------------------
    --                  components
    -------------------------------------------------------------------------

    COMPONENT Ports_decoder
        PORT (
            Addr_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
            new_addr_out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            is_PORT : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN

    Addr_to_dec <= Addr_in;

    Ports_decoder_1 : Ports_decoder
    PORT MAP(
        Addr_in => Addr_to_dec,
        new_addr_out => Addr,
        is_PORT => is_PORT
    );

    Dout_erz : PROCESS (addr, PIND, PINC, PINB, PORTC, PORTB, SER, seg0_N, seg1_N, seg2_N, seg3_N, i2c_SCR, i2c_DaTR, i2c_DaRR)
    BEGIN
        Dout_int <= "00000000";
        CASE (Addr) IS
            WHEN "0000" =>
                --PIND
                Dout_int <= "000" & PIND;
            WHEN "0001" =>
                --PINC
                Dout_int <= PINC;
            WHEN "0010" =>
                --PINB
                Dout_int <= PINB;
            WHEN "0011" =>
                --PORTC
                Dout_int <= PORTC;
            WHEN "0100" =>
                --PORTB
                Dout_int <= PORTB;
            WHEN "0101" =>
                -- SER
                Dout_int <= "0000" & SER;
            WHEN "0110" =>
                --seg0_N
                Dout_int <= seg0_N;
            WHEN "0111" =>
                --seg1_N
                Dout_int <= seg1_N;
            WHEN "1000" =>
                --seg2_N
                Dout_int <= seg2_N;
            WHEN "1001" =>
                --seg3_N
                Dout_int <= seg3_N;
            WHEN "1010" =>
                --i2c_SCR
                Dout_int <= '0' & i2c_SCR;
            WHEN "1011" =>
                --i2c_DaTR
                Dout_int <= i2c_DaTR;
            WHEN "1100" =>
                --i2c_DaTR
                Dout_int <= i2c_DaRR;
            WHEN OTHERS => NULL;
        END CASE;
    END PROCESS; -- Dout_erz

    FF_PIN : PROCESS (CLK, PIN)
    BEGIN
        IF (CLK'event AND CLK = '1') THEN
            -- PIND <= PIN(4 DOWNTO 0);
            -- PINC <= PIN(12 DOWNTO 5);
            -- PINB <= PIN(20 DOWNTO 13);
            PIND <= PIN(20 DOWNTO 16);
            PINC <= PIN(15 DOWNTO 8);
            PINB <= PIN(7 DOWNTO 0);

        END IF;
    END PROCESS;

    FF_1 : PROCESS (CLK, Din)
    BEGIN
        IF (CLK'event AND CLK = '1') THEN
            IF (WE = '1') THEN
                CASE (Addr) IS
                    WHEN "0011" =>
                        --PORTC
                        PORTC <= Din;
                    WHEN "0100" =>
                        --PORTB
                        PORTB <= Din;
                    WHEN "0101" =>
                        -- SER
                        SER <= Din(3 DOWNTO 0);
                    WHEN "0110" =>
                        --seg0_N
                        seg0_N <= Din;
                    WHEN "0111" =>
                        --seg1_N
                        seg1_N <= Din;
                    WHEN "1000" =>
                        --seg2_N
                        seg2_N <= Din;
                    WHEN "1001" =>
                        --seg3_N
                        seg3_N <= Din;
                    WHEN "1010" =>
                        --i2c_SCR
                        --hier fehlt noch viel in bezug auf auto reset von flags
                        i2c_SCR <= Din(6 DOWNTO 0);
                    WHEN "1011" =>
                        --i2c_DaTR
                        i2c_DaTR <= Din;
                    WHEN "1100" =>
                        --i2c_DaRR
                        --eigentlich nur READ muss noch überarbeitet werden
                        i2c_DaRR <= Din;
                    WHEN OTHERS => NULL;
                END CASE;
                --RAM(to_integer(unsigned(A))) <= DI;
            END IF;
        END IF;
    END PROCESS;
    SW_Mux <= is_PORT;
    Dout <= Dout_int;
    PORT_SEG <= (PORTB & PORTC);
END Behavioral;