----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2023 12:32:28
-- Design Name: 
-- Module Name: DEC - Behavioral
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
ENTITY DEC IS
    PORT (
        clk : IN STD_LOGIC;
        Instr_in : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        Status_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        REG_DI : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        Data_opa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        Data_opb : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        SEL_result : OUT STD_LOGIC;
        SEL_ADD_SP : OUT STD_LOGIC;
        WE_SP : OUT STD_LOGIC;
        CLK_Disable_ProgCntr : OUT STD_LOGIC;
        WE_SREG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        WE_DataMemory : OUT STD_LOGIC;
        SEL_DM_ADR : OUT STD_LOGIC;
        Z : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
        K : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        OPCODE : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END DEC;

ARCHITECTURE Behavioral OF DEC IS
    SIGNAL addr_opa : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL addr_opb : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL OPCODE_intern : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL WE_RegFile : STD_LOGIC;
    SIGNAL sel_immediate : STD_LOGIC;
    SIGNAL K_intern : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL WE_DataMemory_intern : STD_LOGIC;
    SIGNAL SEL_MUX_RES_intern : STD_LOGIC;
    SIGNAL CLK_Disable_ProgCntr_intern : STD_LOGIC;
    SIGNAL WE_StateMachine : STD_LOGIC;
    SIGNAL STATE_DEC_TO_SM : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL WE_SREG_intern : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL STATE_SM_TO_DEC : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL data_opa_intern : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL data_opb_intern : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL Z_addr : STD_LOGIC_VECTOR (9 DOWNTO 0);
    SIGNAL SEL_ADD_SP_intern : STD_LOGIC;
    SIGNAL SEL_DM_ADR_intern : STD_LOGIC;
    SIGNAL WE_SP_intern : STD_LOGIC;
    SIGNAL SP_Addr : STD_LOGIC_VECTOR(9 DOWNTO 0);

    COMPONENT decoder
        PORT (
            Instr : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            STATE_IN : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            addr_opa : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            addr_opb : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            OPCODE : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            WE_RegFile : OUT STD_LOGIC;
            WE_SREG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            K : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            WE_DataMemory : OUT STD_LOGIC;
            SEL_MUX_RES : OUT STD_LOGIC;
            SEL_ADD_SP : OUT STD_LOGIC;
            SEL_DM_ADR : OUT STD_LOGIC;
            WE_SP : OUT STD_LOGIC;
            CLK_Disable_ProgCntr : OUT STD_LOGIC;
            WE_StateMachine : OUT STD_LOGIC;
            STATE_OUT : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT State_Machine
        PORT (
            clk : STD_LOGIC;
            State_in : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
            W_E : IN STD_LOGIC;
            State_Out : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Reg_File
        PORT (
            clk : IN STD_LOGIC;
            addr_opa : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
            addr_opb : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
            WE_RegFile : IN STD_LOGIC;
            data_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            data_opa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            data_opb : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            Z : OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    decoder_1 : decoder
    PORT MAP(
        Instr => Instr_in,
        STATE_IN => STATE_SM_TO_DEC,
        addr_opa => addr_opa,
        addr_opb => addr_opb,
        OPCODE => OPCODE_intern,
        WE_RegFile => WE_RegFile,
        WE_SREG => WE_SREG_intern,
        K => K_intern,
        WE_DataMemory => WE_DataMemory_intern,
        SEL_MUX_RES => SEL_MUX_RES_intern,
        SEL_ADD_SP => SEL_ADD_SP_intern,
        SEL_DM_ADR => SEL_DM_ADR_intern,
        WE_SP => WE_SP_intern,
        CLK_Disable_ProgCntr => CLK_Disable_ProgCntr_intern,
        WE_StateMachine => WE_StateMachine,
        STATE_OUT => STATE_DEC_TO_SM
    );

    STATE_MACHINE_1 : State_Machine
    PORT MAP(
        clk => clk,
        State_in => STATE_DEC_TO_SM,
        W_E => WE_StateMachine,
        State_Out => STATE_SM_TO_DEC
    );

    -- instance "Reg_File_1"

    Reg_File_1 : Reg_File
    PORT MAP(
        clk => clk,
        addr_opa => addr_opa,
        addr_opb => addr_opb,
        WE_RegFile => WE_RegFile,
        data_in => REG_DI,
        data_opa => data_opa_intern,
        data_opb => data_opb_intern,
        Z => Z_addr);

    data_opa <= data_opa_intern;
    data_opb <= data_opb_intern;
    WE_SREG <= WE_SREG_intern;
    K <= K_intern;
    WE_DataMemory <= WE_DataMemory_intern;
    SEL_result <= SEL_MUX_RES_intern;
    SEL_ADD_SP <= SEL_ADD_SP_intern;
    SEL_DM_ADR <= SEL_DM_ADR_intern;
    WE_SP <= WE_SP_intern;
    CLK_Disable_ProgCntr <= CLK_Disable_ProgCntr_intern;
    Z <= Z_addr;
    OPCODE <= OPCODE_intern;
END Behavioral;