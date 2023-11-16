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
  SIGNAL OPCODE_SLICE_E : STD_LOGIC := '0';
  SIGNAL OPCODE_SLICE_U : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL MUX_OUT_ASR_LSR : STD_LOGIC := '0';
  SIGNAL ADD1_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL MUX_OUT_OPB_K : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL CARRY_ACHT_BIT : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL erg : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Zwischenergebnis
BEGIN
  OPCODE_SLICE_E <= OPCODE(0);
  OPCODE_SLICE_U <= OPCODE(3 DOWNTO 1);
  ADD1_OUT <= STD_LOGIC_VECTOR(unsigned(OPA) + unsigned(MUX_OUT_OPB_K));
  CARRY_ACHT_BIT <= "0000000" & SREG_IN(0);

  --
  --
  mux_OPB_K : PROCESS (OPCODE_SLICE_E, OPB, K)
  BEGIN
    IF OPCODE_SLICE_E = '0' THEN
      MUX_OUT_OPB_K <= OPB;
    ELSE
      MUX_OUT_OPB_K <= K;
    END IF;
  END PROCESS; -- mux_OPB_K

  --
  --
  MUX_ASR_LSR : PROCESS (OPCODE_SLICE_E, OPA)
  BEGIN
    IF OPCODE_SLICE_E = '0' THEN
      MUX_OUT_ASR_LSR <= OPA(7);
    ELSE
      MUX_OUT_ASR_LSR <= '0';
    END IF;

  END PROCESS; -- MUX_ASR_LSR_MUX

  --
  --
  ERG_MUX : PROCESS (OPA, OPB, CARRY_ACHT_BIT, ADD1_OUT, OPCODE_SLICE_U, MUX_OUT_OPB_K, MUX_OUT_ASR_LSR)
  BEGIN
    CASE OPCODE_SLICE_U IS
      WHEN "000" =>
        --add
        erg <= ADD1_OUT;
      WHEN "001" =>
        --adc
        erg <= STD_LOGIC_VECTOR(unsigned(ADD1_OUT) + unsigned(CARRY_ACHT_BIT));
      WHEN "010" =>
        -- sub
        erg <= STD_LOGIC_VECTOR(unsigned(OPA) - unsigned(MUX_OUT_OPB_K));
      WHEN "011" =>
        erg <= OPA OR MUX_OUT_OPB_K;
      WHEN "100" =>
        erg <= OPA XOR MUX_OUT_OPB_K;
      WHEN "101" =>
        erg <= OPA AND MUX_OUT_OPB_K;
      WHEN "110" =>
        erg <= MUX_OUT_OPB_K;
      WHEN "111" =>
        erg(7) <= MUX_OUT_ASR_LSR;
        erg(6 DOWNTO 0) <= OPA(7 DOWNTO 1);
      WHEN OTHERS => NULL;
    END CASE;
  END PROCESS; -- ERG_MUX

  -- purpose: berechnet die Statusflags
  -- type   : combinational
  -- inputs : OPA, OPB, OPCODE, erg
  -- outputs: z, c, v, n
  Berechnung_SREG : PROCESS (OPA, OPB, OPCODE_SLICE_U, erg, K, OPCODE_SLICE_E)
  BEGIN -- process Berechnung_SREG
    z <= NOT (erg(7) OR erg(6) OR erg(5) OR erg(4) OR erg(3) OR erg(2) OR erg(1) OR erg(0));
    n <= erg(7);

    c <= '0'; -- um Latches zu verhindern
    v <= '0';

    CASE OPCODE_SLICE_U IS
      WHEN "000" =>
        IF OPCODE_SLICE_E = '0' THEN
          --add, LSL
          c <= (OPA(7) AND OPB(7)) OR (OPB(7) AND (NOT erg(7))) OR ((NOT erg(7)) AND OPA(7));
          v <= (OPA(7) AND OPB(7) AND (NOT erg(7))) OR ((NOT OPA(7)) AND (NOT OPB(7)) AND erg(7));
        ELSE
          --inc
          c <= '0';
          v <= (erg(7) AND NOT erg(6)AND NOT erg(5)AND NOT erg(4)AND NOT erg(3)AND NOT erg(2)AND NOT erg(1)AND NOT erg(0));

        END IF;

      WHEN "001" =>
        --adc
        c <= (OPA(7) AND OPB(7)) OR (OPB(7) AND NOT erg(7)) OR (NOT erg(7) AND OPA(7));
        v <= (OPA(7) AND OPB(7) AND NOT erg(7)) OR (NOT OPA(7) AND NOT OPB(7) AND erg(7));
      WHEN "010" =>
        IF OPCODE_SLICE_E = '0' THEN
          --SUB, CP
          c <= (NOT OPA(7) AND OPB(7)) OR (OPB(7) AND erg(7)) OR (NOT OPA(7) AND erg(7));
          v <= (OPA(7) AND NOT OPB(7) AND NOT erg(7)) OR (NOT OPA(7) AND OPB(7) AND erg(7));
        ELSE
          -- subi, cpi, DEC
          c <= (NOT OPA(7) AND K(7)) OR (K(7) AND erg(7)) OR (NOT OPA(7) AND erg(7));
          v <= (OPA(7) AND NOT K(7) AND NOT erg(7)) OR (NOT OPA(7) AND K(7) AND erg(7));

        END IF;
      WHEN "100" =>
        IF OPCODE_SLICE_E = '1' THEN
          --com
          c <= '1';
        END IF;
        -- ASR, LSR
      WHEN "111" =>
        c <= OPA(0);
        v <= (erg(7)) XOR (OPA(0));
      WHEN OTHERS => NULL;
    END CASE;

  END PROCESS Berechnung_SREG;

  s <= v XOR n;
  RES <= erg;
  Status <= '0' & '0' & '0' & s & v & n & z & c;

END Behavioral;