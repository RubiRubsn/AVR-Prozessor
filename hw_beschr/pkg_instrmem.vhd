LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- ---------------------------------------------------------------------------------
-- Memory initialisation package
-- ---------------------------------------------------------------------------------
PACKAGE pkg_instrmem IS

	TYPE t_instrMem IS ARRAY(0 TO 512 - 1) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
	CONSTANT PROGMEM : t_instrMem := (
		"0000000000000000",
		"1110110100010101",
		"1001010100011010",
		"1001010100010011",
		"1001010100010000",

		OTHERS => (OTHERS => '0')
	);

END PACKAGE pkg_instrmem;