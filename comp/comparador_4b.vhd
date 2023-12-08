library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity comparador_4b is
port
(
	a4b: in std_logic_vector(3 downto 0);
	b4b: in std_logic_vector(3 downto 0);
	maior4b: out std_logic;
	menor4b: out std_logic;
	igual4b: out std_logic
);
end comparador_4b;

architecture estrutural of comparador_4b is

component comparador is 

	generic
	(
		DATA_WIDTH : natural := 16
	);

	port 
	(
		a	: in std_logic_vector	((DATA_WIDTH-1) downto 0);
		b	: in std_logic_vector	((DATA_WIDTH-1) downto 0);
		maior	: out std_logic;
		menor	: out std_logic;
		igual	: out std_logic
	);
end component;

begin
	inst4: comparador generic map (4) port map(a4b, b4b, maior4b, menor4b, igual4b);
end estrutural;
