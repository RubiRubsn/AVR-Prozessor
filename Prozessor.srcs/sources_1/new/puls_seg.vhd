----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2023 11:32:08
-- Design Name: 
-- Module Name: puls_seg - Behavioral
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
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--refresh seg 16ms-1ms
-- bei 800.000 ticks und 50MHz clk -> 16ms refresh
-- bei 120MHz -> 6,6 ms refresh
-- --> 200.000 ticks pro disp
ENTITY puls_seg IS
    PORT (
        clk : IN STD_LOGIC;
        en_seg_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        SEG_in : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        SEG_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        en_seg_out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END puls_seg;

ARCHITECTURE Behavioral OF puls_seg IS
    TYPE SEG IS ARRAY(3 DOWNTO 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL SEG_N : SEG;
    SIGNAL en_seg_in_intern : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL cnt_tics : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL one_vl : STD_LOGIC_VECTOR(17 DOWNTO 0);
    SIGNAL CE_disp_cntr : STD_LOGIC;
    SIGNAL cntr_disp : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL one_disp : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL SEG_MUXED_int : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL SEG_MUXED_int_FF : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL en_seg_out_ff : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
    one_vl <= "000000000000000001";
    one_disp <= "01";
    FF_in : PROCESS (clk, SEG_in, en_seg_in, cntr_disp, SEG_MUXED_int)
    BEGIN
        IF (CLK'event AND CLK = '1') THEN
            SEG_N(0) <= SEG_in(7 DOWNTO 0);
            SEG_N(1) <= SEG_in(15 DOWNTO 8);
            SEG_N(2) <= SEG_in(23 DOWNTO 16);
            SEG_N(3) <= SEG_in(31 DOWNTO 24);
            en_seg_in_intern <= en_seg_in;
            SEG_MUXED_int_FF <= SEG_MUXED_int;
            CASE (cntr_disp) IS
                WHEN "00" =>
                    en_seg_out_ff <= "0001";
                WHEN "01" =>
                    en_seg_out_ff <= "0010";
                WHEN "10" =>
                    en_seg_out_ff <= "0100";
                WHEN "11" =>
                    en_seg_out_ff <= "1000";
                WHEN OTHERS => NULL;
            END CASE;
        END IF;
    END PROCESS FF_in;

    ff_cntr : PROCESS (clk, SEG_in, en_seg_in)
    BEGIN

        IF (CLK'event AND CLK = '1') THEN
            CE_disp_cntr <= '0';
            IF cnt_tics = "110000110100111111" THEN
                cnt_tics <= "000000000000000000";
                CE_disp_cntr <= '1';
            ELSE
                cnt_tics <= STD_LOGIC_VECTOR(unsigned(cnt_tics) + unsigned(one_vl));
            END IF;
        END IF;
    END PROCESS ff_cntr;

    ff_cntr_1 : PROCESS (clk, CE_disp_cntr, one_disp, cntr_disp)
    BEGIN
        IF (CLK'event AND CLK = '1') THEN
            IF CE_disp_cntr = '1' THEN
                cntr_disp <= STD_LOGIC_VECTOR(unsigned(cntr_disp) + unsigned(one_disp));
            END IF;
        END IF;
    END PROCESS ff_cntr_1;

    seg_mux : PROCESS (cntr_disp, SEG_N, en_seg_in_intern)
    BEGIN
        IF en_seg_in_intern(to_integer(unsigned(cntr_disp))) = '1' THEN
            SEG_MUXED_int <= SEG_N(to_integer(unsigned(cntr_disp)));
        ELSE
            SEG_MUXED_int <= "00000000";
        END IF;

    END PROCESS seg_mux;

    SEG_out <= SEG_MUXED_int_FF;
    en_seg_out <= en_seg_out_ff;

END Behavioral;