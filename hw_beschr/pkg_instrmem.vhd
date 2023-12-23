LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- ---------------------------------------------------------------------------------
-- Memory initialisation package
-- ---------------------------------------------------------------------------------
PACKAGE pkg_instrmem IS

	TYPE t_instrMem IS ARRAY(0 TO 512 - 1) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
	CONSTANT PROGMEM : t_instrMem := (
		"1100000111011011",
		"1001001100001111",
		"1110000000000000",
		"1110000011110000",
		"1110010011100000",
		"1000001100000000",
		"1110110000000110",
		"1110010011100100",
		"1000001100000000",
		"1110010011100001",
		"1000001100000000",
		"1110100000001000",
		"1110010011100011",
		"1000001100000000",
		"1110110000000111",
		"1110010011100010",
		"1000001100000000",
		"1001000100001111",
		"1001010100001000",
		"0010111111010000",
		"1101000011101101",
		"1001001100101111",
		"1110000011110000",
		"1110010011100000",
		"1000000100100000",
		"0111111100101110",
		"1000001100100000",
		"1001000100101111",
		"1110000011110000",
		"1110010011100001",
		"1000001111010000",
		"1100000010111110",
		"0010111010000000",
		"1001001100101111",
		"1110000000101010",
		"0010111010100010",
		"1110000000100000",
		"0010111010010001",
		"0010111010110010",
		"1001000100101111",
		"1101000100000110",
		"0010110111011000",
		"1001001100101111",
		"1001001100111111",
		"0010110100101000",
		"1110000000111010",
		"0010111010000010",
		"0010111010010011",
		"1101000100101010",
		"0001100100001000",
		"1110000001110000",
		"0001110101111001",
		"0001101100010111",
		"1001000100111111",
		"1001000100101111",
		"1101000011001010",
		"1001001100101111",
		"1110000011110000",
		"1110010011100000",
		"1000000100100000",
		"0111111100101101",
		"1000001100100000",
		"1001000100101111",
		"1110000011110000",
		"1110010011100010",
		"1000001111010000",
		"1100111111010000",
		"0010111010000000",
		"1001001100101111",
		"1110011000100100",
		"0010111010100010",
		"1110000000100000",
		"0010111010010001",
		"0010111010110010",
		"1001000100101111",
		"1101000011100011",
		"0010110111011000",
		"1001001100101111",
		"1001001100111111",
		"0010110100101000",
		"0000111100100010",
		"0000111100100010",
		"1110000100111001",
		"0010111010000010",
		"0010111010010011",
		"1101000100000101",
		"0001100100001000",
		"1110000001110000",
		"0001110101111001",
		"0001101100010111",
		"1001000100111111",
		"1001000100101111",
		"1101000010100101",
		"1001001100101111",
		"1110000011110000",
		"1110010011100000",
		"1000000100100000",
		"0111111100101011",
		"1000001100100000",
		"1001000100101111",
		"1110000011110000",
		"1110010011100011",
		"1000001111010000",
		"1100111110111000",
		"0010111010000000",
		"1001001100101111",
		"1110111000101000",
		"0010111010100010",
		"1110000000100011",
		"0010111010010001",
		"0010111010110010",
		"1001000100101111",
		"1101000010111110",
		"0010110111011000",
		"1001001100101111",
		"1001001100111111",
		"0010110100101000",
		"0000111100100010",
		"0000111100100010",
		"1110111100111010",
		"0010111010000010",
		"0010111010010011",
		"1101000011100000",
		"0001100100001000",
		"1110000001110000",
		"0001110101111001",
		"0001101100010111",
		"1001000100111111",
		"1001000100101111",
		"1101000010000000",
		"1001001100101111",
		"1110000011110000",
		"1110010011100000",
		"1000000100100000",
		"0111111100100111",
		"1000001100100000",
		"1110010011100100",
		"1000001111010000",
		"1001000100101111",
		"1100111110110111",
		"1100000001010001",
		"1001001100101111",
		"1110000000100111",
		"1110000011110000",
		"1110010011100000",
		"1000001100100000",
		"1110000011011010",
		"1101000001101110",
		"1110010011100100",
		"1000001111010000",
		"1110000000100000",
		"0010111100010010",
		"0010111001110010",
		"1110000000100000",
		"0001100100100110",
		"0010111100000010",
		"0010111001100010",
		"1001000100101111",
		"1100000000101100",
		"1001001100101111",
		"1110111100101111",
		"1110000011110000",
		"1110010011100000",
		"1000001100100000",
		"1001000100101111",
		"1001001100001111",
		"1001001100011111",
		"0010110100000110",
		"0010110100010111",
		"1001001100101111",
		"0010110100101100",
		"0011111100101111",
		"1001000100101111",
		"1111001011111001",
		"1001001100001111",
		"1001001100011111",
		"1110000000001111",
		"1110001000010111",
		"0001100100000110",
		"1110000001110000",
		"0001110101110111",
		"0001101100010111",
		"1001001100011111",
		"0111100000010000",
		"1001000100011111",
		"1001000100011111",
		"1001000100001111",
		"1111011010000001",
		"1001001100001111",
		"1001001100011111",
		"1110111000001000",
		"1110000000010011",
		"0001100100000110",
		"1110000001110000",
		"0001110101110111",
		"0001101100010111",
		"1001001100011111",
		"0111100000010000",
		"1001000100011111",
		"1001000100011111",
		"1001000100001111",
		"1111000000001001",
		"1100111110011101",
		"1001001100001111",
		"1001001100011111",
		"1110011000000100",
		"1110000000010000",
		"0001100100000110",
		"1110000001110000",
		"0001110101110111",
		"0001101100010111",
		"1001001100011111",
		"0111100000010000",
		"1001000100011111",
		"1001000100011111",
		"1001000100001111",
		"1111000000001001",
		"1100111101101001",
		"0011000000001010",
		"1111000000001000",
		"1100111101000011",
		"1100111100110101",
		"1001000100011111",
		"1001000100001111",
		"1001010100001000",
		"1110101100001111",
		"0010111111010000",
		"1100000000110101",
		"1110100100000000",
		"0010111111010000",
		"1100000000110010",
		"1110100000000000",
		"0010111111010000",
		"1100000000101111",
		"1110111100001000",
		"0010111111010000",
		"1100000000101100",
		"1110100000000010",
		"0010111111010000",
		"1100000000101001",
		"1110100100000010",
		"0010111111010000",
		"1100000000100110",
		"1110100100001001",
		"0010111111010000",
		"1100000000100011",
		"1110101100000000",
		"0010111111010000",
		"1100000000100000",
		"1110101000000100",
		"0010111111010000",
		"1100000000011101",
		"1110111100001001",
		"0010111111010000",
		"1100000000011010",
		"1110110000000000",
		"0010111111010000",
		"1100000000010111",
		"1001001100001111",
		"0011000011011010",
		"1111001011100001",
		"0011000011011001",
		"1111001011101001",
		"0011000011011000",
		"1111001011110001",
		"0011000011010111",
		"1111001011111001",
		"0011000011010110",
		"1111001100000001",
		"0011000011010101",
		"1111001100001001",
		"0011000011010100",
		"1111001100010001",
		"0011000011010011",
		"1111001100011001",
		"0011000011010010",
		"1111001100100001",
		"0011000011010001",
		"1111001100101001",
		"0011000011010000",
		"1111001100110001",
		"1001000100001111",
		"1001010100001000",
		"1001001111111111",
		"1001001111101111",
		"1110000011110000",
		"1110001111100101",
		"1000001001110000",
		"1110001111101000",
		"1000001001100000",
		"1001000111101111",
		"1001000111111111",
		"1001010100001000",
		"1001001111111111",
		"1001001111101111",
		"1110000011110000",
		"1110001111100011",
		"1000000000110000",
		"1110001111100110",
		"1000000001000000",
		"1001000111101111",
		"1001000111111111",
		"1001010100001000",
		"1001001100001111",
		"1001001100011111",
		"1001001100101111",
		"1001001100111111",
		"1001001101001111",
		"1001001101011111",
		"1001001101101111",
		"1001001101111111",
		"0010110100101000",
		"0010110100111001",
		"0010110101001010",
		"0010110101011011",
		"0001101100000000",
		"0001101100010001",
		"1110000101100001",
		"0001111100100010",
		"0001111100110011",
		"1001010101101010",
		"1111010000001001",
		"1100000000001101",
		"0001111100000000",
		"0001111100010001",
		"1110000001110000",
		"0001101100000100",
		"0001111101110101",
		"0001101100010111",
		"1111010000100000",
		"0000111100000100",
		"0001111100010101",
		"1001010010001000",
		"1100111111110000",
		"1001010000001000",
		"1100111111101110",
		"0010111010000010",
		"0010111010010011",
		"1001000101111111",
		"1001000101101111",
		"1001000101011111",
		"1001000101001111",
		"1001000100111111",
		"1001000100101111",
		"1001000100011111",
		"1001000100001111",
		"1001010100001000",
		"1001001110001111",
		"1001001110011111",
		"1001001110111111",
		"1001001110101111",
		"1001001111001111",
		"1110000011000000",
		"0010111110101100",
		"0010111110111100",
		"0010110110001000",
		"0010110110011001",
		"0011000010010000",
		"1111000001001001",
		"0011000010000000",
		"1111000000111001",
		"1001010110000110",
		"1111010000010000",
		"0000111110101001",
		"0001111110111100",
		"0000111110011001",
		"0001111111001100",
		"1100111111110111",
		"0010111010011011",
		"0010111010001010",
		"1001000111001111",
		"1001000110101111",
		"1001000110111111",
		"1001000110011111",
		"1001000110001111",
		"1001010100001000",
		"1110111100011111",
		"0010111011000001",
		"1100000000011011",
		"0010110010000011",
		"0010110010010100",
		"1101111111011101",
		"0010110001101000",
		"0010110001111001",
		"1101111110011010",
		"1101111100011101",
		"1100000001010011",
		"0010110010000011",
		"0010110010100100",
		"1001001100001111",
		"1110000000000000",
		"0010111010010000",
		"0010111010110000",
		"1001000100001111",
		"1101111110100100",
		"0010110001101000",
		"0010110001111001",
		"1101111110001101",
		"1101111100010000",
		"1100000001000110",
		"1001001100001111",
		"1001001100011111",
		"0010110100000011",
		"0001100100000100",
		"1111001100011000",
		"1110000000010000",
		"0010111001110001",
		"0010111001100000",
		"1101111110000010",
		"1001000100011111",
		"1001000100001111",
		"1101111100000011",
		"1001001100011111",
		"1110000000010000",
		"0010111011000001",
		"1001000100011111",
		"1100000000110101",
		"1001001100001111",
		"1001001100011111",
		"1110000000010000",
		"0010110100000011",
		"0000110100000100",
		"0001111100010001",
		"0010111001110001",
		"0010111001100000",
		"1101111101110001",
		"1001000100011111",
		"1001000100001111",
		"1101111011110010",
		"1100000000101000",
		"1001001100011111",
		"1110000000010000",
		"0010111001110001",
		"0010111001100001",
		"1001000100011111",
		"1101111101100111",
		"1101111001001100",
		"1100000000100000",
		"1100111111000100",
		"1100111111001011",
		"1100111111010111",
		"1001001111111111",
		"1001001111101111",
		"1001001100001111",
		"1001001101001111",
		"1001001100011111",
		"1110000011110000",
		"1110001111100000",
		"1000000100000000",
		"0001010100000101",
		"1111000010011001",
		"1110111100011111",
		"0010010100010101",
		"0010001100010000",
		"0010111001010000",
		"0010111101000001",
		"0111000001000001",
		"1111011100100001",
		"0010111101000001",
		"0111000101000000",
		"1111011101001001",
		"0010111101000001",
		"0111000001001000",
		"1111011100111001",
		"0010111101000001",
		"0111000001000100",
		"1111011100101001",
		"0010111101000001",
		"0111000001000010",
		"1111011001011001",
		"1001000100011111",
		"1001000101001111",
		"1001000100001111",
		"1001000111101111",
		"1001000111111111",
		"1001010100001000",
		"1110000000000000",
		"0010111001010000",
		"0010111001110000",
		"0010111001100000",
		"0010111011000000",
		"1101111000011111",
		"1101111101000010",
		"1101111111010101",
		"1100111111111101",

		OTHERS => (OTHERS => '0')
	);

END PACKAGE pkg_instrmem;