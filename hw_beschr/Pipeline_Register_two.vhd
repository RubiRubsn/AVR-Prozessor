----------------------------------------------------------------------------------
-- Engineer: B. Eng. Saitz, Ruben Herman Felix
-- 
-- Create Date: 01.12.2023 12:34:25
-- Module Name: Pipeline_Register_two - Behavioral
-- Project Name: RISC CPU
-- Target Devices: ARTIX 7
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Pipeline_Register_two IS
    PORT (
        clk : IN STD_LOGIC;
        Data_opa_PR2_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        Data_opb_PR2_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        SEL_result_PR2_IN : IN STD_LOGIC;
        SEL_ADD_SP_PR2_IN : IN STD_LOGIC;
        WE_SP_PR2_IN : IN STD_LOGIC;
        WE_SREG_PR2_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        WE_DataMemory_PR2_IN : IN STD_LOGIC;
        SEL_DM_ADR_PR2_IN : IN STD_LOGIC;
        Z_PR2_IN : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
        K_PR2_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        OPCODE_PR2_IN : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Write_addr_PR2_IN : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        WE_Regfile_PR2_IN : IN STD_LOGIC;
        WE_Regfile_PR2_OUT : OUT STD_LOGIC;
        Data_opa_PR2_OUT : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        Data_opb_PR2_OUT : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        SEL_result_PR2_OUT : OUT STD_LOGIC;
        SEL_ADD_SP_PR2_OUT : OUT STD_LOGIC;
        WE_SP_PR2_OUT : OUT STD_LOGIC;
        WE_SREG_PR2_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        WE_DataMemory_PR2_OUT : OUT STD_LOGIC;
        SEL_DM_ADR_PR2_OUT : OUT STD_LOGIC;
        Z_PR2_OUT : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
        K_PR2_OUT : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        OPCODE_PR2_OUT : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Write_addr_PR2_OUT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0));
END Pipeline_Register_two;

ARCHITECTURE Behavioral OF Pipeline_Register_two IS
    SIGNAL Data_opa_PR2 : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL Data_opb_PR2 : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL SEL_result_PR2 : STD_LOGIC;
    SIGNAL SEL_ADD_SP_PR2 : STD_LOGIC;
    SIGNAL WE_SP_PR2 : STD_LOGIC;
    SIGNAL WE_SREG_PR2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL WE_DataMemory_PR2 : STD_LOGIC;
    SIGNAL SEL_DM_ADR_PR2 : STD_LOGIC;
    SIGNAL Z_PR2 : STD_LOGIC_VECTOR (9 DOWNTO 0);
    SIGNAL K_PR2 : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL OPCODE_PR2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Write_addr : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL WE_Regfile : STD_LOGIC;
BEGIN
    P_reg : PROCESS (clk)
    BEGIN
        IF clk'event AND clk = '1' THEN
            Data_opa_PR2 <= Data_opa_PR2_IN;
            Data_opb_PR2 <= Data_opb_PR2_IN;
            SEL_result_PR2 <= SEL_result_PR2_IN;
            SEL_ADD_SP_PR2 <= SEL_ADD_SP_PR2_IN;
            WE_SP_PR2 <= WE_SP_PR2_IN;
            WE_SREG_PR2 <= WE_SREG_PR2_IN;
            WE_DataMemory_PR2 <= WE_DataMemory_PR2_IN;
            SEL_DM_ADR_PR2 <= SEL_DM_ADR_PR2_IN;
            Z_PR2 <= Z_PR2_IN;
            K_PR2 <= K_PR2_IN;
            OPCODE_PR2 <= OPCODE_PR2_IN;
            Write_addr <= Write_addr_PR2_IN;
            WE_Regfile <= WE_Regfile_PR2_IN;
        END IF;
    END PROCESS P_reg;

    Data_opa_PR2_OUT <= Data_opa_PR2;
    Data_opb_PR2_OUT <= Data_opb_PR2;
    SEL_result_PR2_OUT <= SEL_result_PR2;
    SEL_ADD_SP_PR2_OUT <= SEL_ADD_SP_PR2;
    WE_SP_PR2_OUT <= WE_SP_PR2;
    WE_SREG_PR2_OUT <= WE_SREG_PR2;
    WE_DataMemory_PR2_OUT <= WE_DataMemory_PR2;
    SEL_DM_ADR_PR2_OUT <= SEL_DM_ADR_PR2;
    Z_PR2_OUT <= Z_PR2;
    K_PR2_OUT <= K_PR2;
    OPCODE_PR2_OUT <= OPCODE_PR2;
    Write_addr_PR2_OUT <= Write_addr;
    WE_Regfile_PR2_OUT <= WE_RegFile;
END Behavioral;