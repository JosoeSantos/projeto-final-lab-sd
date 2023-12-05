library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DivisorClock is
	generic
	(
		INPUT_CLOCK: natural := 25000000;
		OUTPUT_CLOCK: natural := 1
	);
	port
	(
		CLOCK_50MHz : in std_logic;
		reset	      : in std_logic;
		CLOCK_1Hz   : out std_logic
	);

end entity;

architecture rtl of DivisorClock is

begin

	process (CLOCK_50MHz,reset)
		variable cnt : integer range 0 to (INPUT_CLOCK * OUTPUT_CLOCK);
		variable clk : std_logic:='0';
	begin
		if (reset = '1') then
				cnt := 0;
		elsif (rising_edge(CLOCK_50MHz)) then
		   if (cnt = (INPUT_CLOCK * OUTPUT_CLOCK)) then
			   clk := not clk;
				cnt := 0;
			else
		      cnt := cnt + 1;
			end if;
		end if;
		CLOCK_1Hz <= clk;
	end process;

end rtl;