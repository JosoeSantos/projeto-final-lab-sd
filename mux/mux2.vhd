library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2 is
	generic
	(
		DATA_WIDTH: natural := 16
	);
	port (
		a	   : in std_logic_vector ((DATA_WIDTH-1) downto 0);
		b	   : in std_logic_vector ((DATA_WIDTH-1) downto 0);
		s     : in std_logic;
		o 		: out std_logic_vector ((DATA_WIDTH-1) downto 0)
	);
end entity;

architecture rtl of mux2 is
begin
	o <= a when s='0' else
		  b;
end rtl;