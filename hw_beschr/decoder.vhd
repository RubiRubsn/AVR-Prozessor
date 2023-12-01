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
    WE_RegFile : OUT STD_LOGIC; -- write enable for Registerfile
    WE_SREG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- einzeln Write_enables für SREG - Bits
    K : OUT STD_LOGIC_VECTOR (7 DOWNTO 0); --konstanten wert
    WE_DataMemory : OUT STD_LOGIC;
    SEL_MUX_RES : OUT STD_LOGIC;
    SEL_ADD_SP : OUT STD_LOGIC;
    SEL_DM_ADR : OUT STD_LOGIC;
    WE_SP : OUT STD_LOGIC;
    CLK_Disable_ProgCntr : OUT STD_LOGIC;
    WE_StateMachine : OUT STD_LOGIC;
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
  -- outputs: addr_opa, addr_opb, OPCODE, WE_RegFile, WE_SREG, ...
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
    WE_RegFile <= '0';
    WE_SREG <= "00000000";
    WE_DataMemory <= '0';
    SEL_MUX_RES <= '0';
    SEL_ADD_SP <= '0';
    SEL_DM_ADR <= '0';
    WE_SP <= '0';
    CLK_Disable_ProgCntr <= '0';
    WE_StateMachine <= '0';
    STATE_OUT <= "00";

    CASE Instr(15 DOWNTO 10) IS
      WHEN "000011" =>
        addr_opa <= Instr(8 DOWNTO 4);
        -- ADD, LSL
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_ADD;
        WE_RegFile <= '1';
        WE_SREG <= "00111111";
      WHEN "000101" =>
        --CP
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_CP;
        WE_SREG <= "00111111";
      WHEN "000110" =>
        -- SUB
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_SUB;
        WE_RegFile <= '1';
        WE_SREG <= "00111111";
      WHEN "000111" =>
        --ADC, ROL
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_ADC;

        WE_SREG <= "00111111";
        WE_RegFile <= '1';
      WHEN "001000" =>
        --AND
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_AND;
        WE_RegFile <= '1';
        WE_SREG <= "00011110";
      WHEN "001001" =>
        --EOR
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_EOR;
        WE_RegFile <= '1';
        WE_SREG <= "00011110";
      WHEN "001010" =>
        --OR
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_OR;
        WE_RegFile <= '1';
        WE_SREG <= "00011110";
      WHEN "001011" =>
        --mov
        addr_opa <= Instr(8 DOWNTO 4);
        addr_opb <= Instr(9) & Instr (3 DOWNTO 0);
        OPCODE <= op_MOV;
        WE_RegFile <= '1';
      WHEN "100000" =>
        --LD und ST
        IF Instr(9) = '1' THEN
          --ST
          addr_opa <= Instr(8 DOWNTO 4);
          WE_DataMemory <= '1';
        ELSE
          addr_opa <= Instr(8 DOWNTO 4);
          SEL_MUX_RES <= '1';
          WE_RegFile <= '1';
        END IF;
      WHEN "100100" =>
        --PUSH,POP
        IF Instr(9) = '0' THEN
          --POP in 1 takten
          --IF STATE_IN = "00" THEN
          --CLK_Disable_ProgCntr <= '1'; -- program counter anhalten
          --State_Out <= "01";
          --WE_StateMachine <= '1';
          SEL_ADD_SP <= '0'; --SP +
          WE_SP <= '1';
          WE_RegFile <= '1';
          addr_opa <= Instr(8 DOWNTO 4);
          SEL_MUX_RES <= '1';
          SEL_DM_ADR <= '1';
          -- ELSIF STATE_IN = "01" THEN
          --   CLK_Disable_ProgCntr <= '0';
          --   State_Out <= "00";
          --   --WE_StateMachine <= '1';
          --   WE_RegFile <= '1';
          --   addr_opa <= Instr(8 DOWNTO 4);
          --END IF;
        ELSE
          --PUSH
          addr_opa <= Instr(8 DOWNTO 4);
          WE_DataMemory <= '1';
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
              WE_RegFile <= '1';
              WE_SREG <= "00011111";
            WHEN "101" =>
              --asr
              addr_opa <= Instr(8 DOWNTO 4);
              OPCODE <= op_ASR;
              WE_RegFile <= '1';
              WE_SREG <= "00011111";
            WHEN "011" =>
              --inc
              addr_opa <= Instr(8 DOWNTO 4);
              OPCODE <= op_INC;
              K <= "0000000" & '1';
              WE_RegFile <= '1';
              WE_SREG <= "00011110";
            WHEN "110" =>
              --lsr
              addr_opa <= Instr(8 DOWNTO 4);
              OPCODE <= op_LSR;
              WE_RegFile <= '1';
              WE_SREG <= "00011111";
            WHEN OTHERS => NULL;
          END CASE;
        ELSE
          SEL_SCR <= Instr(11) & Instr(7);
          IF instr(1) = '1' THEN
            --dec
            K <= "0000000" & '1';
            addr_opa <= Instr(8 DOWNTO 4);
            OPCODE <= op_DEC;
            WE_SREG <= "00011110";
            WE_RegFile <= '1';
          ELSE
            IF instr(8) = '1' THEN
              --ret
            ELSE
              IF instr(7) = '1' THEN
                --clc
                OPCODE <= op_CLC;
                WE_SREG <= "00000001";
              ELSE
                --sec
                OPCODE <= op_COM;
                WE_SREG <= "00000001";
              END IF;
            END IF;
          END IF;
        END IF;
      WHEN OTHERS =>
        CASE Instr(15 DOWNTO 12) IS
          WHEN "0011" =>
            --cpi
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            OPCODE <= op_CPI;
            WE_SREG <= "00011111";
          WHEN "0101" =>
            --SUBI
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            OPCODE <= op_SUBI;
            WE_SREG <= "00011111";
            WE_RegFile <= '1';
          WHEN "0110" =>
            --ORI
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            OPCODE <= op_ORI;
            WE_SREG <= "00011110";
            WE_RegFile <= '1';
          WHEN "0111" =>
            --andi
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            OPCODE <= op_ANDI;
            WE_SREG <= "00011110";
            WE_RegFile <= '1';

            --ASR, lsr, com, dec, inc
          WHEN "1001" =>

          WHEN "1110" =>
            --LDI  
            K <= Instr(11 DOWNTO 8) & Instr(3 DOWNTO 0);
            OPCODE <= op_LDI;
            addr_opa <= '1' & Instr(7 DOWNTO 4);
            WE_RegFile <= '1';
          WHEN OTHERS => NULL;
        END CASE;
    END CASE;
  END PROCESS dec_mux;

END Behavioral;