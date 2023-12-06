library ieee;
library ieee;
  use ieee.std_logic_1164.all;

entity tb_controller is
end entity;

architecture test of tb_controller is
  component controller is
    port (
      clk                        : in  std_logic;
      reset                      : in  std_logic;
      presenca_cartao            : in  std_logic;
      catraca_rodada             : in  std_logic;
      timer_clock                : in  std_logic;
      saldo_maior_tarifa         : in  std_logic;
      resposta_banco_existe      : in  std_logic;
      resposta_banco_ok          : in  std_logic; -- erro serÃƒÂ¡ o inverso do ok(Talvez) --
      ld_reg_id                  : out std_logic;
      reset_reg_id               : out std_logic;
      set_new_ballance_as_db_out : out std_logic;
      load_db_out                : out std_logic;
      reset_timer                : out std_logic;
      display_on                 : out std_logic;
      display_error              : out std_logic;
      abrir_catraca              : out std_logic;
      leitura_cartao             : out std_logic;
      sistema_onibus             : out std_logic
    );
  end component;

  signal fio_clk                   : std_logic := '0';
  signal fio_reset                 : std_logic := '0';
  signal fio_presenca_cartao       : std_logic := '0';
  signal fio_catraca_rodada        : std_logic := '0';
  signal fio_timer_clock           : std_logic := '0';
  signal fio_saldo_maior_tarifa    : std_logic := '0';
  signal fio_resposta_banco_existe : std_logic := '0';
  signal fio_resposta_banco_ok     : std_logic := '0';

  signal fio_ld_reg_id                  : std_logic;
  signal fio_reset_reg_id               : std_logic;
  signal fio_set_new_ballance_as_db_out : std_logic;
  signal fio_load_db_out                : std_logic;
  signal fio_reset_timer                : std_logic;
  signal fio_display_on                 : std_logic;
  signal fio_display_error              : std_logic;
  signal fio_abrir_catraca              : std_logic;
  signal fio_leitura_cartao             : std_logic;
  signal fio_sistema_onibus             : std_logic;

begin

  instance_dut: controller
    port map (
      clk                        => fio_clk,
      reset                      => fio_reset,
      presenca_cartao            => fio_presenca_cartao,
      catraca_rodada             => fio_catraca_rodada,
      timer_clock                => fio_timer_clock,
      saldo_maior_tarifa         => fio_saldo_maior_tarifa,
      resposta_banco_existe      => fio_resposta_banco_existe,
      resposta_banco_ok          => fio_resposta_banco_ok,
      ld_reg_id                  => fio_ld_reg_id,
      reset_reg_id               => fio_reset_reg_id,
      set_new_ballance_as_db_out => fio_set_new_ballance_as_db_out,
      load_db_out                => fio_load_db_out,
      reset_timer                => fio_reset_timer,
      display_on                 => fio_display_on,
      display_error              => fio_display_error,
      abrir_catraca              => fio_abrir_catraca,
      leitura_cartao             => fio_leitura_cartao,
      sistema_onibus             => fio_sistema_onibus
    );

  fio_clk             <= not fio_clk after 1 ns;
  fio_presenca_cartao <= '1' after 2 ns, '0' after 4 ns, '1' after 6 ns;
  fio_resposta_banco_existe <= '1' after 4 ns, '0' after 25 ns, '1' after 33 ns;
  fio_resposta_banco_ok     <= '0' after 4 ns, '1' after 8 ns, '0' after 25 ns, '1' after 32 ns;
  fio_saldo_maior_tarifa    <= '1' after 25 ns;
end architecture;
