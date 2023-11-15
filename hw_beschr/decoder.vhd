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
    SUB_OPCODE : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
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
    SUB_OPCODE <= "00";
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
        --CP
      WHEN "000101" =>
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_CP;
        w_e_SREG <= "00111111";
        --ADC
      WHEN "000111" =>
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_ADC;
        SUB_OPCODE <= sub_op_ADC;
        w_e_SREG <= "00111111";
        w_e_regfile <= '1';
        --AND
      WHEN "001000" =>
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_and;
        SUB_OPCODE <= sub_op_and;
        w_e_regfile <= '1';
        w_e_SREG <= "00011110";
        --EOR
      WHEN "001001" =>
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_eor;
        SUB_OPCODE <= sub_op_eor;
        w_e_regfile <= '1';
        w_e_SREG <= "00011110";
        --OR
      WHEN "001010" =>
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_or;
        SUB_OPCODE <= sub_op_or;
        w_e_regfile <= '1';
        w_e_SREG <= "00011110";
        --mov
      WHEN "001011" =>
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_MOV;
        SUB_OPCODE <= sub_op_MOV;
        w_e_regfile <= '1';
      WHEN OTHERS =>
        CASE Instr(15 DOWNTO 12) IS
            --LDI  
          WHEN "1110" =>
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            OPCODE <= op_ldi;
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            w_e_regfile <= '1';
            --cpi
          WHEN "0011" =>
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            OPCODE <= op_cpi;
            w_e_SREG <= "00011111";
            --SUBI
          WHEN "0101" =>
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            OPCODE <= op_subi;
            w_e_SREG <= "00011111";
            w_e_regfile <= '1';
            --ORI
          WHEN "0110" =>
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            OPCODE <= op_ori;
            w_e_SREG <= "00011110";
            w_e_regfile <= '1';
            --andi
          WHEN "0111" =>
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            OPCODE <= op_andi;
            w_e_SREG <= "00011110";
            w_e_regfile <= '1';
            --ASR, lsr, com, dec, inc
          WHEN "1001" =>
            CASE Instr(2 DOWNTO 0) IS
                --asr
              WHEN "101" =>
                addr_opa <= Instr(8 DOWNTO 4);
                OPCODE <= op_asr;
                SUB_OPCODE <= sub_op_asr;
                w_e_regfile <= '1';
                w_e_SREG <= "00011111";
                --lsr
              WHEN "110" =>
                addr_opa <= Instr(8 DOWNTO 4);
                OPCODE <= op_lsr;
                SUB_OPCODE <= sub_op_lsr;
                w_e_regfile <= '1';
                w_e_SREG <= "00011111";
                --dec
              WHEN "010" =>
                K <= "0000000" & '1';
                addr_opa <= Instr(8 DOWNTO 4);
                OPCODE <= op_dec;
                w_e_SREG <= "00011110";
                w_e_regfile <= '1';
                --inc
              WHEN "011" =>
                addr_opa <= Instr(8 DOWNTO 4);
                OPCODE <= op_inc;
                SUB_OPCODE <= sub_op_inc;
                w_e_regfile <= '1';
                w_e_SREG <= "00011111";
                --com
              WHEN "000" =>
                addr_opa <= Instr(8 DOWNTO 4);
                OPCODE <= op_com;
                SUB_OPCODE <= sub_op_com;
                w_e_regfile <= '1';
                w_e_SREG <= "00011111";
              WHEN OTHERS => NULL;
            END CASE;

          WHEN OTHERS => NULL;
        END CASE;
    END CASE;
  END PROCESS dec_mux;

END Behavioral;