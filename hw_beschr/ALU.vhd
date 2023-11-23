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
  SIGNAL MUX_V : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
  OPCODE_SLICE_E <= OPCODE(0);
  OPCODE_SLICE_U <= OPCODE(3 DOWNTO 1);
  ADD1_OUT <= STD_LOGIC_VECTOR(unsigned(OPA) + unsigned(MUX_OUT_OPB_K));
  CARRY_ACHT_BIT <= "0000000" & SREG_IN(0);
  MUX_V(1) <= (OPCODE(3) OR (OPCODE(2) AND OPCODE(1)));
  MUX_V(0) <= ((OPCODE(2) AND (NOT OPCODE(1))) OR (OPCODE(3) AND OPCODE(2)));
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
  Berechnung_SREG : PROCESS (OPA, MUX_OUT_OPB_K, OPCODE_SLICE_U, erg, K, OPCODE_SLICE_E, MUX_V)
  BEGIN -- process Berechnung_SREG
    z <= NOT (erg(7) OR erg(6) OR erg(5) OR erg(4) OR erg(3) OR erg(2) OR erg(1) OR erg(0));
    n <= erg(7);

    c <= '0'; -- um Latches zu verhindern
    v <= '0';

    --erzeugung C
    CASE OPCODE_SLICE_U (2 DOWNTO 1) IS
      WHEN "00" =>
        --add, LSL, ADC
        c <= (OPA(7) AND MUX_OUT_OPB_K(7)) OR (MUX_OUT_OPB_K(7) AND (NOT erg(7))) OR ((NOT erg(7)) AND OPA(7));
      WHEN "01" =>
        --SUB,cp,SUBI,CPI,DEC
        c <= (NOT OPA(7) AND MUX_OUT_OPB_K(7)) OR (MUX_OUT_OPB_K(7) AND erg(7)) OR (NOT OPA(7) AND erg(7));
      WHEN "10" =>
        --COM
        c <= '1';
      WHEN "11" =>
        c <= OPA(0);
      WHEN OTHERS => NULL;
    END CASE;

    --erzeugung V
    CASE MUX_V IS
      WHEN "00" =>
        v <= (OPA(7) AND MUX_OUT_OPB_K(7) AND (NOT erg(7))) OR ((NOT OPA(7)) AND (NOT MUX_OUT_OPB_K(7)) AND erg(7));
      WHEN "01" =>
        v <= ((OPA(7) AND (NOT MUX_OUT_OPB_K(7)) AND (NOT erg(7))) OR ((NOT OPA(7)) AND MUX_OUT_OPB_K(7) AND erg(7)));
      WHEN "10" =>
        v <= '0';
      WHEN "11" =>
        v <= (erg(7)) XOR (OPA(0));
      WHEN OTHERS => NULL;
    END CASE;

  END PROCESS Berechnung_SREG;

  s <= v XOR n;
  RES <= erg;
  Status <= '0' & '0' & '0' & s & v & n & z & c;

END Behavioral;