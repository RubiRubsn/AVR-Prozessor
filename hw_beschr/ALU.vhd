----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/23/2015 09:44:25 AM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
USE ieee.numeric_std.ALL;
LIBRARY work;
USE work.pkg_processor.ALL;
ENTITY ALU IS
  PORT (
    OPCODE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    SUB_OPCODE : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    OPA : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    OPB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    K : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    SREG_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    RES : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
    Status : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END ALU;

ARCHITECTURE Behavioral OF ALU IS
  SIGNAL z : STD_LOGIC := '0'; -- Zero Flag
  SIGNAL c : STD_LOGIC := '0'; -- Carry Flag
  SIGNAL v : STD_LOGIC := '0'; -- Overflow Flag
  SIGNAL n : STD_LOGIC := '0'; -- negative flag
  SIGNAL s : STD_LOGIC := '0'; -- sign flag
  SIGNAL erg : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Zwischenergebnis
BEGIN
  -- purpose: Kern-ALU zur Berechnung des Datenausganges
  -- type   : combinational
  -- inputs : OPA, OPB, OPCODE
  -- outputs: erg
  kern_ALU : PROCESS (OPA, OPB, OPCODE, K, SUB_OPCODE, SREG_IN)
  BEGIN -- process kern_ALU
    erg <= "00000000"; -- verhindert Latches
    CASE OPCODE IS
        -- ADD --> Addition
      WHEN "0000" =>
        erg <= STD_LOGIC_VECTOR(unsigned(OPA) + unsigned(OPB));
        -- SUB or adc
      WHEN "0001" =>
        IF SUB_OPCODE(0) = '0' THEN

          erg <= STD_LOGIC_VECTOR(unsigned(OPA) - unsigned(OPB));
        ELSIF SUB_OPCODE(0) = '1' THEN
          IF SREG_IN(0) = '1' THEN
            erg <= STD_LOGIC_VECTOR(unsigned(OPA) + unsigned(OPB) + 1);
          ELSE
            erg <= STD_LOGIC_VECTOR(unsigned(OPA) + unsigned(OPB));
          END IF;

        END IF;

        -- OR oder MOV
      WHEN "0010" =>
        IF SUB_OPCODE = "00" THEN
          --And
          erg <= OPA AND OPB;
        ELSIF SUB_OPCODE = "01" THEN
          --eor
          erg <= OPA XOR OPB;
        ELSIF SUB_OPCODE = "10" THEN
          --or
          erg <= OPA OR OPB;
        ELSIF SUB_OPCODE = "11" THEN
          --mov 
          erg <= OPB;
        END IF;
        --cpi, subi
      WHEN "0011" =>
        erg <= STD_LOGIC_VECTOR(unsigned(OPA) - unsigned(K));
        --ori
      WHEN "0110" =>
        erg <= OPA OR K;
        --andi
      WHEN "0111" =>
        erg <= OPA AND K;
        --asr,lsr,com,dec,inc
      WHEN "1001" =>
        --asr,lsr
        IF SUB_OPCODE(1) = '0' THEN
          erg(6 DOWNTO 0) <= OPA(7 DOWNTO 1);
          IF SUB_OPCODE(0) = '0' THEN
            --asr
            erg(7) <= OPA(7);
          ELSE
            --lsr
            erg(7) <= '0';
          END IF;
        ELSE
          --inc
          IF SUB_OPCODE(0) = '0' THEN
            erg <= STD_LOGIC_VECTOR(unsigned(OPA) + 1);
          ELSE
            --com
            erg <= STD_LOGIC_VECTOR(255 - unsigned(OPA));
          END IF;
        END IF;
        --LDI
      WHEN "1110" =>
        erg <= K;
        -- alle anderen Operationen...
      WHEN OTHERS => NULL;
    END CASE;
  END PROCESS kern_ALU;

  -- purpose: berechnet die Statusflags
  -- type   : combinational
  -- inputs : OPA, OPB, OPCODE, erg
  -- outputs: z, c, v, n
  Berechnung_SREG : PROCESS (OPA, OPB, OPCODE, erg, SUB_OPCODE, K)
  BEGIN -- process Berechnung_SREG
    z <= NOT (erg(7) OR erg(6) OR erg(5) OR erg(4) OR erg(3) OR erg(2) OR erg(1) OR erg(0));
    n <= erg(7);

    c <= '0'; -- um Latches zu verhindern
    v <= '0';

    CASE OPCODE IS
        -- ADD
      WHEN "0000" =>
        c <= (OPA(7) AND OPB(7)) OR (OPB(7) AND (NOT erg(7))) OR ((NOT erg(7)) AND OPA(7));
        v <= (OPA(7) AND OPB(7) AND (NOT erg(7))) OR ((NOT OPA(7)) AND (NOT OPB(7)) AND erg(7));

        -- SUB oder ADC
      WHEN "0001" =>
        IF SUB_OPCODE(0) = '0' THEN
          --sub
          c <= (NOT OPA(7) AND OPB(7)) OR (OPB(7) AND erg(7)) OR (NOT OPA(7) AND erg(7));
          v <= (OPA(7) AND NOT OPB(7) AND NOT erg(7)) OR (NOT OPA(7) AND OPB(7) AND erg(7));
        ELSIF SUB_OPCODE(0) = '1' THEN
          --adc 
          c <= (OPA(7) AND OPB(7)) OR (OPB(7) AND NOT erg(7)) OR (NOT erg(7) AND OPA(7));
          v <= (OPA(7) AND OPB(7) AND NOT erg(7)) OR (NOT OPA(7) AND NOT OPB(7) AND erg(7));
        END IF;
        -- OR, and, eor
      WHEN "0010" =>
        c <= '0';
        v <= '0';
      WHEN "0011" =>
        --cpi, subi
        c <= (NOT OPA(7) AND K(7)) OR (K(7) AND erg(7)) OR (NOT OPA(7) AND erg(7));
        v <= (OPA(7) AND NOT K(7) AND NOT erg(7)) OR (NOT OPA(7) AND K(7) AND erg(7));
        --ORI
      WHEN "0110" =>
        c <= '0';
        v <= '0';
        --andi
      WHEN "0111" =>
        c <= '0';
        v <= '0';
      WHEN "1001" =>
        IF SUB_OPCODE(1) = '0' THEN
          c <= OPA(0);
          v <= (erg(7)) XOR (OPA(0));
        ELSE
          IF SUB_OPCODE(0) = '0' THEN
            --inc
            c <= '0';
            v <= (erg(7) AND NOT erg(6)AND NOT erg(5)AND NOT erg(4)AND NOT erg(3)AND NOT erg(2)AND NOT erg(1)AND NOT erg(0));
          ELSE
            --com
            c <= '1';
            v <= '0';
          END IF;

        END IF;
        -- alle anderen Operationen...

      WHEN OTHERS => NULL;
    END CASE;

  END PROCESS Berechnung_SREG;

  s <= v XOR n;
  RES <= erg;
  Status <= '0' & '0' & '0' & s & v & n & z & c;

END Behavioral;