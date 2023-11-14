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
    OPA : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    OPB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    K : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
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
  kern_ALU : PROCESS (OPA, OPB, OPCODE, K)
  BEGIN -- process kern_ALU
    erg <= "00000000"; -- verhindert Latches
    CASE OPCODE IS
        -- ADD --> Addition
      WHEN "0000" =>
        erg <= STD_LOGIC_VECTOR(unsigned(OPA) + unsigned(OPB));
        -- SUB
      WHEN "0001" =>
        erg <= STD_LOGIC_VECTOR(unsigned(OPA) - unsigned(OPB));
        -- OR
      WHEN "0010" =>
        erg <= OPA OR OPB;
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
  Berechnung_SREG : PROCESS (OPA, OPB, OPCODE, erg)
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

        -- SUB
      WHEN "0001" =>
        c <= (NOT OPA(7) AND OPB(7)) OR (OPB(7) AND erg(7)) OR (NOT OPA(7) AND erg(7));
        v <= (OPA(7) AND NOT OPB(7) AND NOT erg(7)) OR (NOT OPA(7) AND OPB(7) AND erg(7));

        -- OR
      WHEN "0010" =>
        c <= '0';
        v <= '0';
        -- alle anderen Operationen...
      WHEN OTHERS => NULL;
    END CASE;

  END PROCESS Berechnung_SREG;

  s <= v XOR n;
  RES <= erg;
  Status <= '0' & '0' & '0' & s & v & n & z & c;

END Behavioral;