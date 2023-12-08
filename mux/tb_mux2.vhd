library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_mux2 is
end entity;

architecture teste of tb_mux2 is 
component mux2 is
	generic (
		DATA_WIDTH: natural := 4
	);
	port (
		a	   : in std_logic_vector ((DATA_WIDTH-1) downto 0);
		b	   : in std_logic_vector ((DATA_WIDTH-1) downto 0);
		s     : in std_logic;
		o 		: out std_logic_vector ((DATA_WIDTH-1) downto 0)
	);
end component;
signal fio_a, fio_b, fio_o: std_logic_vector(1 downto 0);
signal fio_s: std_logic;

begin

instance: mux2 generic map (DATA_WIDTH => 2) 
	port map (
		a => fio_a,
		b=>fio_b,
		s=>fio_s,
		o=>fio_o
	);

fio_a <= "11";
fio_b <= "10";
fio_s <= '0' after 0 ns, '1' after 1 ns;
end teste;