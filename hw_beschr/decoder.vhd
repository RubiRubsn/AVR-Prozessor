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
    STATE_IN : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    addr_opa : OUT STD_LOGIC_VECTOR(4 DOWNTO 0); -- Adresse von 1. Operand
    addr_opb : OUT STD_LOGIC_VECTOR(4 DOWNTO 0); -- Adresse von 2. Operand
    OPCODE : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Opcode für ALU
    w_e_regfile : OUT STD_LOGIC; -- write enable for Registerfile
    w_e_SREG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- einzeln Write_enables für SREG - Bits
    K : OUT STD_LOGIC_VECTOR (7 DOWNTO 0); --konstanten wert
    DM_W_E : OUT STD_LOGIC;
    SEL_MUX_RES : OUT STD_LOGIC;
    SEL_ADD_SP : OUT STD_LOGIC;
    SEL_DM_ADR : OUT STD_LOGIC;
    WE_SP : OUT STD_LOGIC;
    CD_PC : OUT STD_LOGIC;
    W_E_SM : OUT STD_LOGIC;
    STATE_OUT : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    -- hier kommen noch die ganzen Steuersignale der Multiplexer...

  );
END decoder;

ARCHITECTURE Behavioral OF decoder IS
  SIGNAL SEL_SCR : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN -- Behavioral
  SEL_SCR <= Instr(11) & Instr(7);
  -- purpose: Decodierprozess
  -- type   : combinational
  -- inputs : Instr
  -- outputs: addr_opa, addr_opb, OPCODE, w_e_regfile, w_e_SREG, ...
  dec_mux : PROCESS (Instr, SEL_SCR, STATE_IN)
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
    DM_W_E <= '0';
    SEL_MUX_RES <= '0';
    SEL_ADD_SP <= '0';
    SEL_DM_ADR <= '0';
    WE_SP <= '0';
    CD_PC <= '0';
    W_E_SM <= '0';
    STATE_OUT <= "00";

    CASE Instr(15 DOWNTO 10) IS
      WHEN "000011" =>
        addr_opa <= Instr(8 DOWNTO 4);
        -- ADD, LSL
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_ADD;
        w_e_regfile <= '1';
        w_e_SREG <= "00111111";
      WHEN "000101" =>
        --CP
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_CP;
        w_e_SREG <= "00111111";
      WHEN "000110" =>
        -- SUB
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_SUB;
        w_e_regfile <= '1';
        w_e_SREG <= "00111111";
      WHEN "000111" =>
        --ADC, ROL
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_ADC;

        w_e_SREG <= "00111111";
        w_e_regfile <= '1';
      WHEN "001000" =>
        --AND
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_AND;
        w_e_regfile <= '1';
        w_e_SREG <= "00011110";
      WHEN "001001" =>
        --EOR
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_EOR;
        w_e_regfile <= '1';
        w_e_SREG <= "00011110";
      WHEN "001010" =>
        --OR
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_OR;
        w_e_regfile <= '1';
        w_e_SREG <= "00011110";
      WHEN "001011" =>
        --mov
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_MOV;
        w_e_regfile <= '1';
      WHEN "100000" =>
        --LD und ST
        IF Instr(9) = '1' THEN
          --ST
          addr_opa <= Instr(8 DOWNTO 4);
          DM_W_E <= '1';
        ELSE
          addr_opa <= Instr(8 DOWNTO 4);
          SEL_MUX_RES <= '1';
          w_e_regfile <= '1';
        END IF;
      WHEN "100100" =>
        --PUSH,POP
        IF Instr(9) = '0' THEN
          --POP in 2 takten
          IF STATE_IN = "00" THEN
            CD_PC <= '1'; -- program counter anhalten
            State_Out <= "01";
            W_E_SM <= '1';
            SEL_ADD_SP <= '0'; --SP +
            WE_SP <= '1';
          ELSIF STATE_IN = "01" THEN
            CD_PC <= '0';
            State_Out <= "00";
            W_E_SM <= '1';
            SEL_MUX_RES <= '1';
            SEL_DM_ADR <= '1';
            w_e_regfile <= '1';
            addr_opa <= Instr(8 DOWNTO 4);
          END IF;
        ELSE
          --PUSH
          addr_opa <= Instr(8 DOWNTO 4);
          DM_W_E <= '1';
          SEL_ADD_SP <= '1';
          WE_SP <= '1';
          SEL_DM_ADR <= '1';

        END IF;
      WHEN "100101" =>
        IF Instr(3) = '0' THEN
          CASE Instr(2 DOWNTO 0) IS
            WHEN "000" =>
              --com
              addr_opa <= Instr(8 DOWNTO 4);
              OPCODE <= op_COM;
              K <= "11111111";
              w_e_regfile <= '1';
              w_e_SREG <= "00011111";
            WHEN "101" =>
              --asr
              addr_opa <= Instr(8 DOWNTO 4);
              OPCODE <= op_ASR;
              w_e_regfile <= '1';
              w_e_SREG <= "00011111";
            WHEN "010" =>
              --dec
              K <= "0000000" & '1';
              addr_opa <= Instr(8 DOWNTO 4);
              OPCODE <= op_DEC;
              w_e_SREG <= "00011110";
              w_e_regfile <= '1';
            WHEN "011" =>
              --inc
              addr_opa <= Instr(8 DOWNTO 4);
              OPCODE <= op_INC;
              K <= "0000000" & '1';
              w_e_regfile <= '1';
              w_e_SREG <= "00011111";
            WHEN "110" =>
              --lsr
              addr_opa <= Instr(8 DOWNTO 4);
              OPCODE <= op_LSR;
              w_e_regfile <= '1';
              w_e_SREG <= "00011111";
            WHEN OTHERS => NULL;
          END CASE;
        ELSE
          CASE(SEL_SCR) IS

          WHEN "00" =>
            --sec
            OPCODE <= op_COM;
            w_e_SREG <= "00000001";
          WHEN "01" =>
            -- clc
            OPCODE <= op_CLC;
            w_e_SREG <= "00000001";
          WHEN "10" =>
            --ret

          WHEN OTHERS => NULL;

          END CASE;
        END IF;
      WHEN OTHERS =>
        CASE Instr(15 DOWNTO 12) IS
          WHEN "0011" =>
            --cpi
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            OPCODE <= op_CPI;
            w_e_SREG <= "00011111";
          WHEN "0101" =>
            --SUBI
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            OPCODE <= op_SUBI;
            w_e_SREG <= "00011111";
            w_e_regfile <= '1';
          WHEN "0110" =>
            --ORI
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            OPCODE <= op_ORI;
            w_e_SREG <= "00011110";
            w_e_regfile <= '1';
          WHEN "0111" =>
            --andi
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            OPCODE <= op_ANDI;
            w_e_SREG <= "00011110";
            w_e_regfile <= '1';

            --ASR, lsr, com, dec, inc
          WHEN "1001" =>

          WHEN "1110" =>
            --LDI  
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            OPCODE <= op_LDI;
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            w_e_regfile <= '1';
          WHEN OTHERS => NULL;
        END CASE;
    END CASE;
  END PROCESS dec_mux;

END Behavioral;