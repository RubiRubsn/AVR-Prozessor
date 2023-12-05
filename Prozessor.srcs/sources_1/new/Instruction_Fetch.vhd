----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2023 10:27:12
-- Design Name: 
-- Module Name: Instruction_Fetch - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY Instruction_Fetch IS
    PORT (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        CLK_Disable_ProgCntr : IN STD_LOGIC;
        ld_PC_val : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        sel_PC_LDI_VAL : IN STD_LOGIC;
        sel_PC_ADD_VAL : IN STD_LOGIC;
        instr : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END Instruction_Fetch;

ARCHITECTURE Behavioral OF Instruction_Fetch IS

    -- outputs of "Program_Counter_1"
    SIGNAL Addr : STD_LOGIC_VECTOR (8 DOWNTO 0);

    -- outputs of "prog_mem_1"
    SIGNAL Instr_intern : STD_LOGIC_VECTOR (15 DOWNTO 0);
    SIGNAL ld_PC_val_intern : STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL sel_PC_LDI_VAL_intern : STD_LOGIC;
    SIGNAL sel_PC_ADD_VAL_intern : STD_LOGIC;

    COMPONENT Program_Counter
        PORT (
            reset : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            CLK_Disable_ProgCntr : IN STD_LOGIC;
            ld_PC_val : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            sel_PC_LDI_VAL : IN STD_LOGIC;
            sel_PC_ADD_VAL : IN STD_LOGIC;
            Addr : OUT STD_LOGIC_VECTOR (8 DOWNTO 0));
    END COMPONENT;
    COMPONENT prog_mem
        PORT (
            Addr : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
            Instr : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
    END COMPONENT;
BEGIN
    -- instance "Program_Counter_1"
    Program_Counter_1 : Program_Counter
    PORT MAP(
        reset => reset,
        clk => clk,
        CLK_Disable_ProgCntr => CLK_Disable_ProgCntr,
        ld_PC_val => ld_PC_val_intern,
        sel_PC_LDI_VAL => sel_PC_LDI_VAL_intern,
        sel_PC_ADD_VAL => sel_PC_ADD_VAL_intern,
        Addr => Addr);

    -- instance "prog_mem_1"
    prog_mem_1 : prog_mem
    PORT MAP(
        Addr => Addr,
        Instr => Instr_intern);

    instr <= Instr_intern;
    ld_PC_val_intern <= ld_PC_val;
    sel_PC_LDI_VAL_intern <= sel_PC_LDI_VAL;
    sel_PC_ADD_VAL_intern <= sel_PC_ADD_VAL;
END Behavioral;