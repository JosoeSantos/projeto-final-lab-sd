library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity tb_flip_flop_d is
end tb_flip_flop_d;

architecture teste of tb_flip_flop_d is

component flip_flop is 
	port(
		clock: in std_logic;
		R: in std_logic;
		D: in std_logic;
	   Q: out std_logic
	);
end component;


signal fio_clk: std_logic := '0';
signal fio_D: std_logic := '0';
signal fio_R: std_logic := '0';
signal fio_Q: std_logic;

begin

instancia: flip_flop port map(clock=>fio_clk,R=>fio_R,D=>fio_D, Q=>fio_Q);

fio_clk <= not fio_clk after 5 ns;
--fio_R <= not fio_R after 10 ns ;
--fio_D <= not fio_D after 20 ns;

end teste;