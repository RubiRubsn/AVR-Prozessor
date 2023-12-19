-------------------------------------------------------------------------------
-- Title      : Testbench for design "toplevel"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : toplevel_tb.vhd
-- Author     : Burkart Voss  <bvoss@Troubadix>
-- Company    : 
-- Created    : 2015-06-23
-- Last update: 2015-06-23
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

-------------------------------------------------------------------------------

ENTITY toplevel_tb IS

END toplevel_tb;

-------------------------------------------------------------------------------

ARCHITECTURE behaviour OF toplevel_tb IS

  COMPONENT toplevel
    PORT (
      -- reset : IN STD_LOGIC;
      clk : IN STD_LOGIC;
      PIN : IN STD_LOGIC_VECTOR (20 DOWNTO 0);
      PORT_SEG : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      SEG_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      SEG_AN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT;

  -- component ports
  -- SIGNAL reset : STD_LOGIC;
  SIGNAL clk : STD_LOGIC := '0';
  SIGNAL PIN : STD_LOGIC_VECTOR(20 DOWNTO 0);
  --  signal WE_SREG : std_logic_vector(7 downto 0);
  -- signal Status   : STD_LOGIC_VECTOR (7 downto 0);
BEGIN -- behaviour

  -- component instantiation
  DUT : toplevel
  PORT MAP(
    -- reset => reset,
    clk => clk,
    PIN => PIN--,
    --WE_SREG => WE_SREG,
    --Status => Status
  );

  PIN <= (OTHERS => '0');
  -- clock generation
  clk <= NOT clk AFTER 10 ns;

  -- waveform generation
  -- WaveGen_Proc : PROCESS
  -- BEGIN
  --   -- insert signal assignments here
  --   WAIT FOR 20ns;
  --   reset <= '1';
  --   WAIT FOR 101ns;
  --   reset <= '0';
  --   WAIT;

  -- END PROCESS WaveGen_Proc;

END behaviour;

-------------------------------------------------------------------------------

CONFIGURATION toplevel_tb_behaviour_cfg OF toplevel_tb IS
  FOR behaviour
  END FOR;
END toplevel_tb_behaviour_cfg;

-------------------------------------------------------------------------------