library IEEE;
  use ieee.std_logic_1164.all;

entity flip_flop is
  generic (
    DATA_WIDTH : natural := 4
  );

  port (
    clock : in  std_logic;
    R     : in  std_logic;
    W     : in  std_logic;
    D     : in  std_logic_vector((DATA_WIDTH - 1) downto 0);
    Q     : out std_logic_vector((DATA_WIDTH - 1) downto 0)
  );
end entity;

architecture RTL of flip_flop is
begin
  Q <= (others => '0') when R = '1' else
  D when clock = '1' and clock'event and W = '1';
end architecture;
