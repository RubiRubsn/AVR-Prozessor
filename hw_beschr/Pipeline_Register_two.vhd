----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2023 12:34:25
-- Design Name: 
-- Module Name: Pipeline_Register_two - Behavioral
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
        OPCODE_PR2_OUT : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END Pipeline_Register_two;

ARCHITECTURE Behavioral OF Pipeline_Register_two IS

BEGIN
    Data_opa_PR2_OUT <= Data_opa_PR2_IN;
    Data_opb_PR2_OUT <= Data_opb_PR2_IN;
    SEL_result_PR2_OUT <= SEL_result_PR2_IN;
    SEL_ADD_SP_PR2_OUT <= SEL_ADD_SP_PR2_IN;
    WE_SP_PR2_OUT <= WE_SP_PR2_IN;
    WE_SREG_PR2_OUT <= WE_SREG_PR2_IN;
    WE_DataMemory_PR2_OUT <= WE_DataMemory_PR2_IN;
    SEL_DM_ADR_PR2_OUT <= SEL_DM_ADR_PR2_IN;
    Z_PR2_OUT <= Z_PR2_IN;
    K_PR2_OUT <= K_PR2_IN;
    OPCODE_PR2_OUT <= OPCODE_PR2_IN;
END Behavioral;