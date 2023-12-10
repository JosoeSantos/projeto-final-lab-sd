library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity datapath is
	port
	(
	  -- inputs
		id_cartao : in std_logic_vector (15 downto 0);
		banco_in : in std_logic_vector (15 downto 0);
		preco_in : in std_logic_vector (15 downto 0);
		ld_reg_id : in std_logic; 
		reset_reg_id : in std_logic;
		ld_reg_db : in std_logic;
		reset_reg_db : in std_logic;
		set_new_ballance_as_db_out : in std_logic;
		load_db_out : in std_logic;
		reset_timer : in std_logic;
		display_on : in std_logic;
		CLK: in std_logic;
		display_error: in std_logic;
		

    -- outputs
		timer_clock : out std_logic;
		ballance_it_price : out std_logic;
		ballance_eq_price : out std_logic;
		ballance_gt_price : out std_logic;
		abrir_catraca : out std_logic;
		leitura_cartao : out std_logic;
		saida_display : out std_logic_vector (15 downto 0);
		saida_banco: out std_logic_vector (15 downto 0)
	);
end datapath;

architecture dataflow of datapath is
  -- all components should be declared here
	component flip_flop is
		generic
		(
			DATA_WIDTH : natural := 16
		);

		port(
			clock: in std_logic;
			R: in std_logic;
			W: in std_logic;
			D: in std_logic_vector ((DATA_WIDTH-1) downto 0);
			Q: out std_logic_vector ((DATA_WIDTH-1) downto 0)
		);
   end component;

	component comparador is
    generic (
        DATA_WIDTH : natural := 16
    );
    port (
			a	: in std_logic_vector	((DATA_WIDTH-1) downto 0);
			b	: in std_logic_vector	((DATA_WIDTH-1) downto 0);
			maior	: out std_logic;
			menor	: out std_logic;
			igual	: out std_logic
    );
	end component;
	
	component mux2 is
    generic (
        DATA_WIDTH : natural := 16
    );
    port (
			a	   : in std_logic_vector ((DATA_WIDTH-1) downto 0);
			b	   : in std_logic_vector ((DATA_WIDTH-1) downto 0);
			s     : in std_logic;
			o 		: out std_logic_vector ((DATA_WIDTH-1) downto 0)
    );
	end component;
	
	component DivisorClock is
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
   end component;

	component Subtrator is
	generic
		(
			DATA_WIDTH : natural := 16
		);
		port (
			A	   : in std_logic_vector ((DATA_WIDTH-1) downto 0);
			B	   : in std_logic_vector ((DATA_WIDTH-1) downto 0);
			Q : out std_logic_vector ((DATA_WIDTH-1) downto 0)
		);
   end component;

signal fio_Q_reg_banco: std_logic_vector(15 downto 0);
signal fio_Q_reg_preco: std_logic_vector(15 downto 0);
signal fio_Q_mux_cartao: std_logic_vector(15 downto 0);
signal fio_Q_subtrator: std_logic_vector(15 downto 0);
signal fio_Q_mux_sub: std_logic_vector(15 downto 0);
signal fio_Q_mux_display: std_logic_vector(15 downto 0);

-- sinais controladora
-- signal fio_presenca_cartao: std_logic_vector(15 downto 0);
-- signal fio_catraca-rodada: std_logic_vector(15 downto 0);
-- signal fio_abrir_catraca: std_logic_vector(15 downto 0);
-- signal fio_leitura_cartao: std_logic_vector(15 downto 0);
-- signal fio_saida_display: std_logic_vector(15 downto 0);

begin
	--  register instances
	reg_preco: flip_flop generic map (DATA_WIDTH => 16) port map(
		clock => CLK,
		D => preco_in,
		W => ld_reg_id,
		R => reset_reg_id,
		Q => fio_Q_reg_preco
	);

	reg_banco: flip_flop generic map (DATA_WIDTH => 16) port map(
		clock=> CLK,
		D => banco_in,
		W => ld_reg_db,
		R => reset_reg_db,
		Q => fio_Q_reg_banco
	);
	
	reg_mux: flip_flop generic map (DATA_WIDTH => 16) port map(
		clock => CLK,
		D =>  fio_Q_mux_cartao,
		W => ld_reg_db,
		R => reset_reg_db,
		Q => saida_banco
	);

	timer_instance: DivisorClock generic map (OUTPUT_CLOCK => 5) port map(
		CLOCK_50MHz => CLK,
		reset => reset_timer,
		CLOCK_1Hz => timer_clock
	);

	comparador_instance: comparador generic map (DATA_WIDTH => 16) port map( 
		a => fio_Q_reg_banco,
      b => fio_Q_reg_preco,
      menor	=> ballance_it_price,
		igual	=> ballance_eq_price,
		maior	=> ballance_gt_price
	);

	subtrator_instance: Subtrator generic map (DATA_WIDTH => 16) port map (
		A => fio_Q_reg_banco,
      B => fio_Q_reg_preco,
		Q => fio_Q_subtrator
	);
	
	mux_subtrator: mux2 generic map (DATA_WIDTH => 16) port map (
		a => fio_Q_subtrator,
	   b => "1000000000000001",
		o => fio_Q_mux_sub, 
		s => display_error
	);
	
	mux_display: mux2 generic map (DATA_WIDTH => 16) port map (
		a => "0000000000000000",
      b => fio_Q_mux_sub,
		o => fio_Q_mux_display,
		s => display_on
	);
	
	mux_cartao: mux2 generic map (DATA_WIDTH => 16) port map (
		a => id_cartao,
      b => fio_Q_mux_display, -- código de erro
		o => fio_Q_mux_cartao,
		s => set_new_ballance_as_db_out
	);
end dataflow;

