----------------------------------------------------------------------------------
-- Engineer: B. Eng. Saitz, Ruben Herman Felix
-- 
-- Create Date: 01.12.2023 10:27:12
-- Module Name: Instruction_Fetch - Behavioral
-- Project Name: RISC CPU
-- Target Devices: ARTIX 7
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY Instruction_Fetch IS
    PORT (
        clk : IN STD_LOGIC;
        CLK_Disable_ProgCntr : IN STD_LOGIC;
        add_PC_val : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        sel_PC_OUT : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        PC_save_val : IN STD_LOGIC;
        PC_DISABLE_SAVE_FOR_RCAL : IN STD_LOGIC;
        PULL_ERG : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        save_addr_rcal : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
        instr : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END Instruction_Fetch;

ARCHITECTURE Behavioral OF Instruction_Fetch IS

    SIGNAL Addr : STD_LOGIC_VECTOR (8 DOWNTO 0);

    SIGNAL Instr_intern : STD_LOGIC_VECTOR (15 DOWNTO 0);
    SIGNAL add_PC_val_intern : STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL sel_PC_OUT_intern : STD_LOGIC_VECTOR(1 DOWNTO 0);

    COMPONENT Program_Counter
        PORT (
            clk : IN STD_LOGIC;
            CLK_Disable_ProgCntr : IN STD_LOGIC;
            add_PC_val : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            sel_PC_OUT : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            PC_save_val : IN STD_LOGIC;
            PC_DISABLE_SAVE_FOR_RCAL : IN STD_LOGIC;
            PULL_ERG : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            save_addr_rcal : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            Addr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0));
    END COMPONENT;
    COMPONENT prog_mem
        PORT (
            Addr : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
            Instr : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
    END COMPONENT;
BEGIN
    Program_Counter_1 : Program_Counter
    PORT MAP(
        clk => clk,
        CLK_Disable_ProgCntr => CLK_Disable_ProgCntr,
        add_PC_val => add_PC_val_intern,
        sel_PC_OUT => sel_PC_OUT_intern,
        PC_save_val => PC_save_val,
        PC_DISABLE_SAVE_FOR_RCAL => PC_DISABLE_SAVE_FOR_RCAL,
        PULL_ERG => PULL_ERG,
        save_addr_rcal => save_addr_rcal,
        Addr => Addr);
    prog_mem_1 : prog_mem
    PORT MAP(
        Addr => Addr,
        Instr => Instr_intern);

    instr <= Instr_intern;
    add_PC_val_intern <= add_PC_val;
    sel_PC_OUT_intern <= sel_PC_OUT;
END Behavioral;