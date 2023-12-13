library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use ieee.numeric_std.all;

entity tb_datapath is
end entity;

architecture test of tb_datapath is
  component datapath is
    port (
      -- inputs
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

  -- inputs
  signal fio_id_cartao : std_logic_vector(15 downto 0) := "0000000000000000";
  signal fio_banco_in  : std_logic_vector(15 downto 0) := "0000000000000000";
  signal fio_preco_in  : std_logic_vector(15 downto 0) := "0000000000000011";
  -- WRITE DOS REGS
  signal fio_id_reg_id   : std_logic := '1';
  signal fio_load_db_out : std_logic := '1';
  signal fio_id_reg_db   : std_logic := '1';
  -- RESET DOS REGS
  signal fio_reset_reg_id : std_logic := '0';
  signal fio_reset_reg_db : std_logic := '0';

  signal fio_v_ballance_as_db_out : std_logic := '0';
  signal fio_reset_timer          : std_logic := '0';
  signal fio_display_on           : std_logic := '0';
  signal fio_CLK                  : std_logic := '0';
  signal fio_display_error        : std_logic := '0';
  signal fio_presenca_cartao      : std_logic := '0';
  signal fio_catraca_rodada       : std_logic := '0';
  signal fio_abrir_catraca        : std_logic := '0';
  signal fio_leitura_cartao       : std_logic := '0';

  -- outputs
  signal fio_presenca_cartao_out : std_logic;
  signal fio_catraca_rodada_out  : std_logic;
  signal fio_timer_clock         : std_logic;
  signal fio_ballance_it_price   : std_logic;
  signal fio_ballance_eq_price   : std_logic;
  signal fio_ballance_gt_price   : std_logic;
  signal fio_abrir_catraca_out   : std_logic;
  signal fio_leitura_cartao_out  : std_logic;
  signal fio_saida_display       : std_logic_vector(15 downto 0);
  signal fio_saida_banco         : std_logic_vector(15 downto 0);
begin
  -- port map
  datapath_instance: datapath
    port map (
      -- inputs
      id_cartao            => fio_id_cartao,
      banco_in             => fio_banco_in,
      preco_in             => fio_preco_in,
      ld_reg_id            => fio_id_reg_id,
      reset_reg_id         => fio_reset_reg_id,
      ld_reg_db            => fio_id_reg_db,
      reset_reg_db         => fio_reset_reg_db,
      set_new_ballance_as_db_out => fio_v_ballance_as_db_out,
      load_db_out          => fio_load_db_out,
      reset_timer          => fio_reset_timer,
      display_on           => fio_display_on,
      CLK                  => fio_CLK,
      display_error        => fio_display_error,
      timer_clock          => fio_timer_clock,
      ballance_it_price    => fio_ballance_it_price,
      ballance_eq_price    => fio_ballance_eq_price,
      ballance_gt_price    => fio_ballance_gt_price,
      saida_display        => fio_saida_display,
      saida_banco          => fio_saida_banco
    );

  --stimulus processF
  fio_CLK <= not fio_CLK after 1 ns;

  fio_banco_in             <= "0000000000000111" after 1 ns;
  fio_preco_in             <= "0000000000000011" after 1 ns;
  fio_id_cartao            <= "0000000000000001" after 1 ns;
  fio_presenca_cartao      <= '0' after 2 ns;
  fio_catraca_rodada       <= '0' after 2 ns;
  fio_id_reg_id            <= '1' after 2 ns;
  fio_reset_reg_id         <= '0' after 2 ns;
  fio_id_reg_db            <= '1' after 2 ns;
  fio_reset_reg_db         <= '0' after 2 ns;
  fio_v_ballance_as_db_out <= '0' after 2 ns;
  fio_load_db_out          <= '1' after 2 ns;
  fio_reset_timer          <= '0' after 2 ns;
  fio_display_on           <= '1' after 2 ns;
  fio_display_error        <= '0' after 2 ns;
  fio_abrir_catraca        <= '0' after 2 ns;
  fio_leitura_cartao       <= '0' after 2 ns;
end architecture;
