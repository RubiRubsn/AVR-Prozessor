----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2023 12:33:21
-- Design Name: 
-- Module Name: Execute - Behavioral
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
ENTITY Execute IS
    PORT (
        clk : IN STD_LOGIC;
        OPCODE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        OPA : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        OPB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        K : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        WE_SREG : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        SEL_result : IN STD_LOGIC;
        SEL_ADD_SP : IN STD_LOGIC;
        WE_SP : IN STD_LOGIC;
        WE_DataMemory : IN STD_LOGIC;
        SEL_DM_ADR : IN STD_LOGIC;
        Z : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        PIN : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
        PORT_SEG : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        SEG_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        SEG_AN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        REG_DI : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        Status_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END Execute;

ARCHITECTURE Behavioral OF Execute IS

    SIGNAL RAM_DO : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL data_res : STD_LOGIC_VECTOR(7 DOWNTO 0); --output from alu
    SIGNAL Status : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL SREG_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL PIN_intern : STD_LOGIC_VECTOR (20 DOWNTO 0);
    SIGNAL PORT_SEG_intern : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL DOUT_IO : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL SW_IO_DM : STD_LOGIC;
    SIGNAL SEG : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL SEG_EN : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL SEG_out_intern : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL SEG_AN_intern : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL SP_Addr : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL Z_SP_Addr : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL data_opa : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL data_opb : STD_LOGIC_VECTOR(7 DOWNTO 0);

    --------------------------------------------------------------------------
    --              Component declaration
    --------------------------------------------------------------------------

    COMPONENT Stack_Pointer
        PORT (
            clk : IN STD_LOGIC;
            SEL_ADD_SP : IN STD_LOGIC;
            WE_SP : IN STD_LOGIC;
            Addr : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
    END COMPONENT;

    COMPONENT Data_Memory
        PORT (
            CLK : IN STD_LOGIC;
            WE : IN STD_LOGIC;
            A : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            DI : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            DO : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Ports
        PORT (
            clk : IN STD_LOGIC;
            WE : IN STD_LOGIC;
            Addr_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
            Din : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            PIN : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
            PORT_SEG : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            Dout : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            SW_Mux : OUT STD_LOGIC;
            SEG : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
            SEG_EN : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

    COMPONENT ALU
        PORT (
            OPCODE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            OPA : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPB : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            K : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            SREG_IN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            RES : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            Status : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
    END COMPONENT;

    COMPONENT puls_seg
        PORT (
            clk : IN STD_LOGIC;
            en_seg_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            SEG_in : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            SEG_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            en_seg_out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

    COMPONENT SREG
        PORT (
            clk : IN STD_LOGIC;
            Status : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            WE_SREG : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            Status_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
        );
    END COMPONENT;

BEGIN

    data_opa <= OPA;
    data_opb <= OPB;
    Stack_Pointer_1 : Stack_Pointer
    PORT MAP(
        clk => clk,
        SEL_ADD_SP => SEL_ADD_SP,
        WE_SP => WE_SP,
        Addr => SP_Addr
    );

    Data_Memory_1 : Data_Memory
    PORT MAP(
        CLK => clk,
        WE => WE_DataMemory,
        A => Z_SP_Addr,
        DI => data_opa,
        DO => RAM_DO
    );

    Ports_1 : Ports
    PORT MAP(
        clk => clk,
        WE => WE_DataMemory,
        Addr_in => Z_SP_Addr,
        Din => data_opa,
        PIN => PIN_intern,
        PORT_SEG => PORT_SEG_intern,
        Dout => DOUT_IO,
        SW_MUX => SW_IO_DM,
        SEG => SEG,
        SEG_EN => SEG_EN
    );

    -- instance "ALU_1"
    ALU_1 : ALU
    PORT MAP(
        OPCODE => OPCODE,
        OPA => data_opa,
        OPB => data_opb,
        RES => data_res,
        Status => Status,
        K => K,
        SREG_IN => SREG_OUT);

    SREG_1 : SREG
    PORT MAP(
        clk => clk,
        Status => Status,
        WE_SREG => WE_SREG,
        Status_out => SREG_OUT
    );
    puls_seg_1 : puls_seg
    PORT MAP(
        clk => clk,
        en_seg_in => SEG_EN,
        SEG_in => SEG,
        SEG_out => SEG_out_intern,
        en_seg_out => SEG_AN_intern);

    Din_Reg_file_MUX : PROCESS (SW_IO_DM, SEL_result, data_res, RAM_DO, DOUT_IO)
    BEGIN
        REG_DI <= "00000000";

        IF SEL_result = '0' THEN
            REG_DI <= data_res;
            ELSE
            IF SW_IO_DM = '0' THEN
                REG_DI <= RAM_DO;
                ELSE
                REG_DI <= DOUT_IO;
            END IF;
        END IF;
    END PROCESS; -- Din_Reg_file_MUX

    Z_SP_Addr <= Z WHEN SEL_DM_ADR = '0' ELSE
    SP_Addr;

    PIN_intern <= PIN;

    PORT_SEG <= PORT_SEG_intern;
    SEG_out <= SEG_out_intern;
    SEG_AN <= SEG_AN_intern;
    Status_out <= SREG_out;
END Behavioral;