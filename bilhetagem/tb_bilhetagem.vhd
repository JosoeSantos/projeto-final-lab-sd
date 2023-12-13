library ieee;
  use ieee.std_logic_1164.all;

entity tb_bilhetagem is
end entity;

architecture test of tb_bilhetagem is
  component bilhetagem is
    port (
      clock                 : in  std_logic;
      id_cartao             : in  std_logic_vector(15 downto 0);
      banco_in              : in  std_logic_vector(15 downto 0);
      preco_in              : in  std_logic_vector(15 downto 0);
      presenca_cartao       : in  std_logic;
      catraca_rodada        : in  std_logic;
      resposta_banco_existe : in  std_logic;
      resposta_banco_ok     : in  std_logic;
      saida_banco           : out std_logic_vector(15 downto 0);
      saida_display         : out std_logic_vector(15 downto 0);
      abrir_catraca         : out std_logic;
      leitura_cartao        : out std_logic;
      sistema_onibus        : out std_logic
    );
  end component;

  signal fio_clk                   : std_logic := '0';
  signal fio_presenca_cartao       : std_logic := '1';
  signal fio_catraca_rodada        : std_logic := '0';
  signal fio_timer_clock           : std_logic := '0';
  signal fio_resposta_banco_existe : std_logic := '0';
  signal fio_resposta_banco_ok     : std_logic := '0';
  signal fio_sistema_onibus        : std_logic;

  signal fio_abrir_catraca  : std_logic := '0';
  signal fio_leitura_cartao : std_logic := '0';

  signal fio_id_cartao : std_logic_vector(15 downto 0) := "0000000000001111";
  signal fio_banco_in  : std_logic_vector(15 downto 0) := "0000010000001101";
  signal fio_preco_in  : std_logic_vector(15 downto 0) := (others => '0');

  signal fio_saida_banco   : std_logic_vector(15 downto 0) := (others => '0');
  signal fio_saida_display : std_logic_vector(15 downto 0) := (others => '0');

begin

  instance_dut: bilhetagem
    port map (
      clock                 => fio_clk,
      id_cartao             => fio_id_cartao,
      banco_in              => fio_banco_in,
      preco_in              => fio_preco_in,
      presenca_cartao       => fio_presenca_cartao,
      catraca_rodada        => fio_catraca_rodada,
      resposta_banco_existe => fio_resposta_banco_existe,
      resposta_banco_ok     => fio_resposta_banco_ok,
      saida_banco           => fio_saida_banco,
      saida_display         => fio_saida_display,
      abrir_catraca         => fio_abrir_catraca,
      leitura_cartao        => fio_leitura_cartao,
      sistema_onibus        => fio_sistema_onibus
    );

  fio_clk                   <= not fio_clk after 1 ns;
  fio_timer_clock           <= not fio_timer_clock after 5 ns;
  fio_presenca_cartao       <= '1' after 2 ns, '0' after 4 ns, '1' after 6 ns, '0' after 34 ns, '1' after 48 ns, '0' after 52 ns, '1' after 62 ns, '0' after 69 ns;
  fio_resposta_banco_existe <= '1' after 3 ns, '0' after 25 ns, '1' after 33 ns, '0' after 34 ns, '1' after 38 ns;
  fio_resposta_banco_ok     <= '0' after 3 ns, '1' after 8 ns, '0' after 25 ns, '1' after 32 ns, '0' after 62 ns;
  fio_catraca_rodada        <= '1' after 45 ns;

end architecture;

