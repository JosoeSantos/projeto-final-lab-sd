library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subtractor is
    generic (
        DATA_WIDTH : natural := 4
    );
    port (
        a      : in  std_logic_vector(DATA_WIDTH - 1 downto 0);
        b      : in  std_logic_vector(DATA_WIDTH - 1 downto 0);
        result : out std_logic_vector(DATA_WIDTH - 1 downto 0)
    );
end entity;

architecture rtl of subtractor is
begin
    process (a, b)
    begin
       
		result <= std_logic_vector(unsigned(a) - unsigned(b));
     
    end process;
end rtl;
