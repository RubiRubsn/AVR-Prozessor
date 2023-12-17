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
        Write_addr_in : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        WE_Regfile_IN : IN STD_LOGIC;
        WE_SREG_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        save_addr_rcal : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        PC_DISABLE_SAVE_FOR_RCAL : OUT STD_LOGIC;
        Write_disable_PR1 : OUT STD_LOGIC;
        WE_Regfile_OUT : OUT STD_LOGIC;
        Write_addr_out : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
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
        OPCODE : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        add_PC_val : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
        sel_PC_OUT : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        PC_save_val : OUT STD_LOGIC);
END DEC;

ARCHITECTURE Behavioral OF DEC IS
    SIGNAL addr_opa : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL addr_opb : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL OPCODE_intern : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL WE_RegFile_intern : STD_LOGIC;
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
    SIGNAL Z_addr_out : STD_LOGIC_VECTOR (9 DOWNTO 0);
    SIGNAL Z_addr : STD_LOGIC_VECTOR (9 DOWNTO 0);
    SIGNAL SEL_ADD_SP_intern : STD_LOGIC;
    SIGNAL SEL_DM_ADR_intern : STD_LOGIC;
    SIGNAL WE_SP_intern : STD_LOGIC;
    SIGNAL SP_Addr : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL WE_Regfile_IN_intern : STD_LOGIC;

    SIGNAL Forwarding_mux_addr_a_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Forwarding_mux_addr_b_out : STD_LOGIC_VECTOR(7 DOWNTO 0);

    SIGNAL Write_disable_PR1_intern : STD_LOGIC;

    SIGNAL add_PC_val_intern : STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL sel_PC_OUT_intern : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL SEL_PUSH_PC_NORM_intern : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL PC_PUSH_NORM_MUX : STD_LOGIC_VECTOR (7 DOWNTO 0);

    COMPONENT decoder
        PORT (
            clk : IN STD_LOGIC;
            Instr : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            STATE_IN : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            WE_SREG_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            SREG_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            PC_DISABLE_SAVE_FOR_RCAL : OUT STD_LOGIC;
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
            STATE_OUT : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            Write_disable_PR1 : OUT STD_LOGIC;
            add_PC_val : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sel_PC_OUT : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            PC_save_val : OUT STD_LOGIC;
            SEL_PUSH_PC_NORM : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
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
            Write_addr : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
            WE_RegFile : IN STD_LOGIC;
            data_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            data_opa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            data_opb : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            Z : OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    WE_Regfile_IN_intern <= WE_RegFile_IN;
    decoder_1 : decoder
    PORT MAP(
        clk => clk,
        Instr => Instr_in,
        STATE_IN => STATE_SM_TO_DEC,
        WE_SREG_IN => WE_SREG_IN,
        SREG_IN => Status_IN,
        PC_DISABLE_SAVE_FOR_RCAL => PC_DISABLE_SAVE_FOR_RCAL,
        addr_opa => addr_opa,
        addr_opb => addr_opb,
        OPCODE => OPCODE_intern,
        WE_RegFile => WE_RegFile_intern,
        WE_SREG => WE_SREG_intern,
        K => K_intern,
        WE_DataMemory => WE_DataMemory_intern,
        SEL_MUX_RES => SEL_MUX_RES_intern,
        SEL_ADD_SP => SEL_ADD_SP_intern,
        SEL_DM_ADR => SEL_DM_ADR_intern,
        WE_SP => WE_SP_intern,
        CLK_Disable_ProgCntr => CLK_Disable_ProgCntr_intern,
        WE_StateMachine => WE_StateMachine,
        STATE_OUT => STATE_DEC_TO_SM,
        Write_disable_PR1 => Write_disable_PR1_intern,
        add_PC_val => add_PC_val_intern,
        sel_PC_OUT => sel_PC_OUT_intern,
        PC_save_val => PC_save_val,
        SEL_PUSH_PC_NORM => SEL_PUSH_PC_NORM_intern
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
        Write_addr => Write_addr_in,
        WE_RegFile => WE_Regfile_IN_intern,
        data_in => REG_DI,
        data_opa => data_opa_intern,
        data_opb => data_opb_intern,
        Z => Z_addr);

    Forwarding_mux_addr_a : PROCESS (clk, data_opa_intern, addr_opa, Write_addr_in, WE_Regfile_IN_intern, REG_DI)
    BEGIN
        Forwarding_mux_addr_a_out <= data_opa_intern;
        IF addr_opa = Write_addr_in AND WE_Regfile_IN_intern = '1' THEN
            Forwarding_mux_addr_a_out <= REG_DI;
        END IF;
    END PROCESS Forwarding_mux_addr_a;

    Forwarding_mux_addr_b : PROCESS (clk, data_opb_intern, addr_opb, Write_addr_in, WE_Regfile_IN_intern, REG_DI)
    BEGIN
        Forwarding_mux_addr_b_out <= data_opb_intern;
        IF addr_opb = Write_addr_in AND WE_Regfile_IN_intern = '1'THEN
            Forwarding_mux_addr_b_out <= REG_DI;
        END IF;
    END PROCESS Forwarding_mux_addr_b;

    Forwarding_mux_addr_Z_Oben : PROCESS (clk, Write_addr_in, WE_Regfile_IN_intern, REG_DI, Z_addr)
    BEGIN
        -- Forwarding_mux_addr_b_out <= data_opb_intern;
        IF Write_addr_in = "11111" AND WE_Regfile_IN_intern = '1'THEN
            Z_addr_out(9 DOWNTO 8) <= REG_DI(1 DOWNTO 0);
            ELSE
            Z_addr_out(9 DOWNTO 8) <= Z_addr(9 DOWNTO 8);
            --     Forwarding_mux_addr_b_out <= REG_DI;
        END IF;
    END PROCESS Forwarding_mux_addr_Z_Oben;

    Forwarding_mux_addr_Z_Unten : PROCESS (clk, Write_addr_in, WE_Regfile_IN_intern, REG_DI, Z_addr)
    BEGIN
        -- Forwarding_mux_addr_b_out <= data_opb_intern;
        IF Write_addr_in = "11110" AND WE_Regfile_IN_intern = '1'THEN
            Z_addr_out(7 DOWNTO 0) <= REG_DI;
            ELSE
            Z_addr_out(7 DOWNTO 0) <= Z_addr(7 DOWNTO 0);
            --     Forwarding_mux_addr_b_out <= REG_DI;
        END IF;
    END PROCESS Forwarding_mux_addr_Z_Unten;

    PC_PUSH_NORM_MUX_pro : PROCESS (clk, Forwarding_mux_addr_a_out, save_addr_rcal, SEL_PUSH_PC_NORM_intern)
    BEGIN
        PC_PUSH_NORM_MUX <= Forwarding_mux_addr_a_out;
        CASE SEL_PUSH_PC_NORM_intern IS
            WHEN "00" =>
                PC_PUSH_NORM_MUX <= Forwarding_mux_addr_a_out;
            WHEN "01" =>
                PC_PUSH_NORM_MUX <= save_addr_rcal(7 DOWNTO 0);
            WHEN "10" =>
                PC_PUSH_NORM_MUX <= "0000000" & save_addr_rcal(8);

            WHEN OTHERS => NULL;
        END CASE;
    END PROCESS PC_PUSH_NORM_MUX_pro;

    data_opa <= PC_PUSH_NORM_MUX;
    data_opb <= Forwarding_mux_addr_b_out;
    WE_SREG <= WE_SREG_intern;
    K <= K_intern;
    WE_DataMemory <= WE_DataMemory_intern;
    SEL_result <= SEL_MUX_RES_intern;
    SEL_ADD_SP <= SEL_ADD_SP_intern;
    SEL_DM_ADR <= SEL_DM_ADR_intern;
    WE_SP <= WE_SP_intern;
    CLK_Disable_ProgCntr <= CLK_Disable_ProgCntr_intern;
    Z <= Z_addr_out;
    OPCODE <= OPCODE_intern;
    Write_addr_out <= addr_opa;
    WE_Regfile_OUT <= WE_RegFile_intern;
    Write_disable_PR1 <= Write_disable_PR1_intern;
    add_PC_val <= add_PC_val_intern;
    sel_PC_OUT <= sel_PC_OUT_intern;
END Behavioral;