library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use ieee.numeric_std.all;

entity bilhetagem is
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
end entity;

architecture connection of bilhetagem is
  component datapath is
    port (
      id_cartao                  : in  std_logic_vector(15 downto 0);
      banco_in                   : in  std_logic_vector(15 downto 0);
      preco_in                   : in  std_logic_vector(15 downto 0);
      ld_reg_id                  : in  std_logic;
      reset_reg_id               : in  std_logic;
      ld_reg_db                  : in  std_logic;
      reset_reg_db               : in  std_logic;
      set_new_ballance_as_db_out : in  std_logic;
      load_db_out                : in  std_logic;
      reset_timer                : in  std_logic;
      display_on                 : in  std_logic;
      CLK                        : in  std_logic;
      display_error              : in  std_logic;
      -- outputs
      timer_clock                : out std_logic;
      ballance_it_price          : out std_logic;
      ballance_eq_price          : out std_logic;
      ballance_gt_price          : out std_logic;
      saida_display              : out std_logic_vector(15 downto 0);
      saida_banco                : out std_logic_vector(15 downto 0)
    );
  end component;

  component controller is
    port (
      clk                        : in  std_logic;
      reset                      : in  std_logic;
      presenca_cartao            : in  std_logic;
      catraca_rodada             : in  std_logic;
      timer_clock                : in  std_logic;
      saldo_maior_tarifa         : in  std_logic;
      resposta_banco_existe      : in  std_logic;
      resposta_banco_ok          : in  std_logic; -- erro serÃ¡ o inverso do ok(Talvez) --
      ld_reg_id                  : out std_logic;
      ld_reg_db                  : out std_logic;
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

  signal timer_clock                : std_logic;
  signal ballance_gt_price          : std_logic;
  signal ld_reg_id                  : std_logic;
  signal reset_reg_id               : std_logic;
  signal set_new_ballance_as_db_out : std_logic;
  signal load_db_out                : std_logic;
  signal reset_timer                : std_logic;
  signal display_on                 : std_logic;
  signal display_error              : std_logic;
  signal ld_reg_db                  : std_logic;
begin
  instance_controler: controller
    port map (
      clk                        => clock,
      reset                      => '0',
      presenca_cartao            => presenca_cartao,
      catraca_rodada             => catraca_rodada,
      timer_clock                => timer_clock,
      saldo_maior_tarifa         => ballance_gt_price,
      resposta_banco_existe      => resposta_banco_existe,
      resposta_banco_ok          => resposta_banco_ok,
      ld_reg_id                  => ld_reg_id,
      reset_reg_id               => reset_reg_id,
      ld_reg_db                  => ld_reg_db,
      set_new_ballance_as_db_out => set_new_ballance_as_db_out,
      load_db_out                => load_db_out,
      reset_timer                => reset_timer,
      display_on                 => display_on,
      display_error              => display_error,
      abrir_catraca              => abrir_catraca,
      leitura_cartao             => leitura_cartao,
      sistema_onibus             => sistema_onibus
    );

  instance_datapath: datapath
    port map (
      id_cartao                  => id_cartao,
      banco_in                   => banco_in,
      preco_in                   => preco_in,
      ld_reg_id                  => ld_reg_id,
      reset_reg_id               => reset_reg_id,
      ld_reg_db                  => ld_reg_db,
      reset_reg_db               => reset_reg_id,
      set_new_ballance_as_db_out => set_new_ballance_as_db_out,
      load_db_out                => load_db_out,
      reset_timer                => reset_timer,
      display_on                 => display_on,
      CLK                        => clock,
      display_error              => display_error,
      timer_clock                => timer_clock,
      ballance_gt_price          => ballance_gt_price,
      saida_display              => saida_display,
      saida_banco                => saida_banco
    );

end architecture;
