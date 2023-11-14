LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- ---------------------------------------------------------------------------------
-- Memory initialisation package
-- ---------------------------------------------------------------------------------
PACKAGE pkg_instrmem IS

	TYPE t_instrMem IS ARRAY(0 TO 512 - 1) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
	CONSTANT PROGMEM : t_instrMem := (
		"0000000000000000",
		"1110111100011111",
		"1110000000100101",
		"0000111100010010",
		"1110000000010001",
		"1110000000100101",
		"0001101100010010",

		OTHERS => (OTHERS => '0')
	);

END PACKAGE pkg_instrmem;