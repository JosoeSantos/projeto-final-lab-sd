-- Quartus II VHDL Template
-- Unsigned Adder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Subtrator is

	generic
	(
		DATA_WIDTH : natural := 16
	);

	port 
	(
		A	   : in std_logic_vector ((DATA_WIDTH-1) downto 0);
		B	   : in std_logic_vector ((DATA_WIDTH-1) downto 0);
		Q : out std_logic_vector ((DATA_WIDTH-1) downto 0)
	);

end entity;

architecture rtl of Subtrator is
begin

	Q <= std_logic_vector(unsigned(a) - unsigned(b));

end rtl;
