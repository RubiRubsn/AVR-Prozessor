-------------------------------------------------------------------------------
-- Title      : decoder
-- Project    : 
-------------------------------------------------------------------------------
-- File       : decoder.vhd
-- Author     : Burkart Voss  <bvoss@Troubadix>
-- Company    : 
-- Created    : 2015-06-23
-- Last update: 2015-06-25
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2015 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2015-06-23  1.0      bvoss	Created
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
LIBRARY work;
USE work.pkg_processor.ALL;

-------------------------------------------------------------------------------

ENTITY decoder IS
  PORT (
    Instr : IN STD_LOGIC_VECTOR(15 DOWNTO 0); -- Eingang vom Programmspeicher
    addr_opa : OUT STD_LOGIC_VECTOR(4 DOWNTO 0); -- Adresse von 1. Operand
    addr_opb : OUT STD_LOGIC_VECTOR(4 DOWNTO 0); -- Adresse von 2. Operand
    OPCODE : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Opcode für ALU
    w_e_regfile : OUT STD_LOGIC; -- write enable for Registerfile
    w_e_SREG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- einzeln Write_enables für SREG - Bits
    K : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) --konstanten wert
    -- hier kommen noch die ganzen Steuersignale der Multiplexer...

  );
END decoder;

ARCHITECTURE Behavioral OF decoder IS

BEGIN -- Behavioral

  -- purpose: Decodierprozess
  -- type   : combinational
  -- inputs : Instr
  -- outputs: addr_opa, addr_opb, OPCODE, w_e_regfile, w_e_SREG, ...
  dec_mux : PROCESS (Instr)
  BEGIN -- process dec_mux
    -- ACHTUNG!!!
    -- So einfach wie hier unten ist das Ganze nicht! Es soll nur den Anfang erleichtern!
    -- Etwas muss man hier schon nachdenken und sich die Operationen genau ansehen...

    -- Vorzuweisung der Signale, um Latches zu verhindern
    K <= "00000000";
    addr_opa <= "00000";
    addr_opb <= "00000";
    OPCODE <= op_NOP;
    w_e_regfile <= '0';
    w_e_SREG <= "00000000";

    CASE Instr(15 DOWNTO 10) IS
        -- ADD
      WHEN "000011" =>
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_add;
        w_e_regfile <= '1';
        w_e_SREG <= "00111111";
        -- SUB
      WHEN "000110" =>
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_sub;
        w_e_regfile <= '1';
        w_e_SREG <= "00111111";
      WHEN "001010" =>
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_or;
        w_e_regfile <= '1';
        w_e_SREG <= "00011110";

      WHEN OTHERS =>
        CASE Instr(15 DOWNTO 12) IS
            --LDI  
          WHEN "1110" =>
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            OPCODE <= op_ldi;
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            w_e_regfile <= '1';
          WHEN OTHERS => NULL;
        END CASE;
    END CASE;
  END PROCESS dec_mux;

END Behavioral;