library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity tb_datapath is
end tb_datapath;


architecture test of tb_datapath is
	component datapath is
		port
		(
		 -- inputs
			id_cartao 					: in std_logic_vector (15 downto 0);
			banco_in 					: in std_logic_vector (15 downto 0);
			preco_in 					: in std_logic_vector (15 downto 0);
			id_reg_id 					: in std_logic; 
			reset_reg_id 				: in std_logic;
			id_reg_db 					: in std_logic;
			reset_reg_db 				: in std_logic;
			v_ballance_as_db_out 		: in std_logic;
			load_db_out 				: in std_logic;
			reset_timer 				: in std_logic;
			display_on 					: in std_logic;
			CLK							: in std_logic;
			display_error               : in std_logic;
			
		-- outputs
			presenca_cartao 			: out std_logic;
			catraca_rodada 				: out std_logic;
			timer_clock 				: out std_logic;
			ballance_it_price 			: out std_logic;
			ballance_eq_price 			: out std_logic;
			ballance_gt_price 			: out std_logic;
			abrir_catraca 				: out std_logic;
			leitura_cartao 				: out std_logic;
			saida_display 				: out std_logic_vector (15 downto 0);
			saida_banco					: out std_logic_vector (15 downto 0)
		);
	end component;

    -- inputs
    signal fio_id_cartao: std_logic_vector (15 downto 0) :=  "0000000000000000";
    signal fio_banco_in: std_logic_vector (15 downto 0) := "0000000000000000";
    signal fio_preco_in: std_logic_vector (15 downto 0) := "0000000000000000";
    signal fio_id_reg_id: std_logic :='0'; 
    signal fio_reset_reg_id: std_logic :='0';
    signal fio_id_reg_db: std_logic :='0';
    signal fio_reset_reg_db: std_logic :='0';
    signal fio_v_ballance_as_db_out: std_logic :='0';
    signal fio_load_db_out: std_logic :='0';
    signal fio_reset_timer: std_logic :='0';
    signal fio_display_on: std_logic :='0';
    signal fio_CLK: std_logic :='0';
    signal fio_display_error: std_logic :='0';

    -- outputs
    signal fio_presenca_cartao: std_logic;
    signal fio_catraca_rodada: std_logic;
    signal fio_timer_clock: std_logic;
    signal fio_ballance_it_price: std_logic;
    signal fio_ballance_eq_price: std_logic;
    signal fio_ballance_gt_price: std_logic;
    signal fio_abrir_catraca: std_logic;
    signal fio_leitura_cartao: std_logic;
    signal fio_saida_display: std_logic_vector (15 downto 0);
    signal fio_saida_banco: std_logic_vector (15 downto 0);
begin
 -- port map
    datapath_instance : datapath
        port map (
            -- inputs
            id_cartao                => fio_id_cartao,
            banco_in                 => fio_banco_in,
            preco_in                 => fio_preco_in,
            id_reg_id                => fio_id_reg_id,
            reset_reg_id             => fio_reset_reg_id,
            id_reg_db                => fio_id_reg_db,
            reset_reg_db             => fio_reset_reg_db,
            v_ballance_as_db_out     => fio_v_ballance_as_db_out,
            load_db_out              => fio_load_db_out,
            reset_timer              => fio_reset_timer,
            display_on               => fio_display_on,
            CLK                      => fio_CLK,
            display_error            => fio_display_error,
            presenca_cartao          => fio_presenca_cartao,
            catraca_rodada           => fio_catraca_rodada,
            timer_clock              => fio_timer_clock,
            ballance_it_price        => fio_ballance_it_price,
            ballance_eq_price        => fio_ballance_eq_price,
            ballance_gt_price        => fio_ballance_gt_price,
            abrir_catraca            => fio_abrir_catraca,
            leitura_cartao           => fio_leitura_cartao,
            saida_display            => fio_saida_display,
            saida_banco              => fio_saida_banco
        );


    --stimulus process
	fio_CLK <= not fio_CLK after 1 ns;

	fio_banco_in <= "0000000000000111" after 1 ns;
    fio_preco_in <= "0000000000000011" after 1 ns;
end test;