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

  instance_dut: controller port map(
    clk => fio_clk,
    reset => fio_reset,
    presenca_cartao => fio_presenca_cartao,
    catraca_rodada => fio_catraca_rodada,
    timer_clock => fio_timer_clock,
    saldo_maior_tarifa => fio_saldo_maior_tarifa,
    resposta_banco_existe => fio_resposta_banco_existe,
    resposta_banco_ok => fio_resposta_banco_ok,
    ld_reg_id => fio_ld_reg_id,
    reset_reg_id => fio_reset_reg_id,
    set_new_ballance_as_db_out => fio_set_new_ballance_as_db_out,
    load_db_out => fio_load_db_out,
    reset_timer => fio_reset_timer,
    display_on => fio_display_on,
    display_error => fio_display_error,
    abrir_catraca => fio_abrir_catraca,
    leitura_cartao => fio_leitura_cartao,
    sistema_onibus => fio_sistema_onibus
  );

  fio_clk <= not fio_clk after 1 ns;

  -- esse processo vai gerar os estados pelas entradas do controlador
  -- e vai realizar assertivas para verificar se o controlador esta funcionando
  -- as entradas e saidas daqui devem seguir o que estÃ¡ descrito na FSM de baixo nÃ­vel
  -- esse cÃ³digo pode ser reusado para testar a mÃ¡quina de alto nÃ­vel
  
  process
  begin
    wait for 1 ns; -- s0: espera cartÃ£o do motorista
		assert fio_ld_reg_id = '1' report "fio_ld_reg_id deve ser 1" severity error;
		assert fio_reset_reg_id = '0' report "fio_reset_reg_id deve ser 0" severity error;
		assert fio_sistema_onibus = '0' report "fio_sistema_onibus deve ser 0" severity error;
		assert fio_abrir_catraca = '0' report "fio_catraca_rodada deve ser 0" severity error;
    wait for 1 ns; -- transiÃ§Ã£o para s1: Le credencial
    	fio_presenca_cartao <= '1';
	wait for 1 ns; -- s1: Le credencial
		assert fio_ld_reg_id = '0' report "fio_ld_reg_id deve ser 0" severity error;
		assert fio_load_db_out = '1' report "load_db_out deve ser 1" severity error;
	wait for 1 ns; -- s1: transiÃ§Ã£o para s2: Espera resposta do banco
		assert fio_load_db_out = '0' report "load_db_out deve ser 0" severity error;
    wait for 3 ns; -- s2: Espera resposta do banco
		assert fio_leitura_cartao = '0' report "fio_resposta_banco_existe deve ser 1" severity error;
		fio_resposta_banco_existe <= '1';
		fio_resposta_banco_ok <= '1';
	wait for 1 ns; -- s2: transiÃ§Ã£o para s3: Ativa sistema Ã´nibus
		assert fio_sistema_onibus = '1' report "sistema_onibus deve ser 1" severity error;
	wait for 2 ns; -- s3: transiÃ§Ã£o para s4: Espera sinal de presenÃ§a de cartÃ£o
		-- s4
		assert fio_leitura_cartao = '1' report "leitura_cartao deve ser 1" severity error;
		fio_presenca_cartao <= '1';
	wait for 1 ns;
		-- s5
		assert fio_load_db_out = '1' report "load_db_out deve ser 1" severity error;
  wait for 1 ns;
    -- s6

  end process;

end architecture;
