-- Quartus II VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;

entity controller is

	port(
		clk		 : in	std_logic;
		reset: in std_logic;
		presenca_cartao: in	std_logic;
		catraca_rodada: in	std_logic;
		timer_clock: in	std_logic;
		saldo_maior_tarifa: in std_logic;
		resposta_banco_existe: in std_logic;
		resposta_banco_ok: in std_logic; -- erro serÃ¡ o inverso do ok(Talvez) --
		ld_reg_id: out std_logic;
	    reset_reg_id: out std_logic;
		set_new_ballance_as_db_out: out std_logic;
		load_db_out: out std_logic;
		reset_timer: out std_logic;
		display_on: out std_logic;
		display_error: out std_logic;
		abrir_catraca: out std_logic;
		leitura_cartao: out std_logic;
		sistema_onibus: out std_logic
	);
end entity;

architecture rtl of controller is
	-- Build an enumerated type for the state machine
	type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10);

	-- Register to hold the current state
	signal state : state_type;
begin
	-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '1' then
			state <= s0;
		elsif (rising_edge(clk)) then
			case state is
				when s0=>
					if presenca_cartao = '1' then
						state <= s1;
					else
						state <= s0;
					end if;
				when s1=>
					state <= s2;
				when s2=>
					if resposta_banco_existe= '1' then
						if 	resposta_banco_ok='1' then
							state <=s3;
						else
							state <= s0;
						end if ;
					else
						state <= s2;
					end if;
				when s3 =>
					state <= s4;
				when s4 =>
					if presenca_cartao = '1' then
						state <= s5;
					else
						state <= s4;
					end if;
				when s5 =>
					state <= s6; -- clock para carregar reg --
				when s6 =>
					if resposta_banco_existe = '1' then
						if resposta_banco_ok ='1' and saldo_maior_tarifa= '1' then
							state <= s7;
						else
							state <= s4;
						end if;
					else
						state <= s6;
					end if;
				when s7 =>
					if catraca_rodada = '0' then
						if timer_clock = '1' then -- TODO: Seria melhor usar rising_edge aqui mas algo da errado
							state <= s8;
						else
							state <= s7;
						end if;
					else
						state <= s9;
					end if;
				when s8 => -- ESTADO DE ERRO
					if timer_clock='1' then
						state <= s4; -- volta a esperar sinal do cartão
					else
						state <= s8;
					end if;
				when s9 =>
					state <= s10;
				when s10 =>
					if resposta_banco_existe ='1' then
						state <= s4;
					else
						state <= s10;
					end if;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	process (state)
	begin
		case state is
			when s0 =>
				ld_reg_id <= '0';
				reset_reg_id <= '0';
				set_new_ballance_as_db_out <= '0';
				load_db_out <= '0';
				reset_timer <= '0';
				display_on <= '0';
				display_error <= '0';
				abrir_catraca <= '0';
				leitura_cartao <= '1';
				sistema_onibus <= '0';
			when s1 =>
				ld_reg_id <= '1';
				reset_reg_id <= '0';
				set_new_ballance_as_db_out <= '0';
				load_db_out <= '0';
				reset_timer <= '0';
				display_on <= '0';
				display_error <= '0';
				abrir_catraca <= '0';
				leitura_cartao <= '1';
				sistema_onibus <= '0';
			when s2 =>
				ld_reg_id <= '0';
				reset_reg_id <= '0';
				set_new_ballance_as_db_out <= '0';
				load_db_out <= '1';
				reset_timer <= '0';
				display_on <= '0';
				display_error <= '0';
				abrir_catraca <= '0';
				leitura_cartao <= '0';
				sistema_onibus <= '0';
			when s3 =>
				ld_reg_id <= '0';
				reset_reg_id <= '0';
				set_new_ballance_as_db_out <= '0';
				load_db_out <= '0';
				reset_timer <= '0';
				display_on <= '0';
				display_error <= '0';
				abrir_catraca <= '0';
				leitura_cartao <= '0';
				sistema_onibus <= '1';
			when s4 =>
				ld_reg_id <= '0';
				reset_reg_id <= '0';
				set_new_ballance_as_db_out <= '0';
				load_db_out <= '0';
				reset_timer <= '0';
				display_on <= '0';
				display_error <= '0';
				abrir_catraca <= '0';
				leitura_cartao <= '1';
				sistema_onibus <= '1';
			when s5 =>
				ld_reg_id <= '1';
				reset_reg_id <= '0';
				set_new_ballance_as_db_out <= '0';
				load_db_out <= '0';
				reset_timer <= '0';
				display_on <= '0';
				display_error <= '0';
				abrir_catraca <= '0';
				leitura_cartao <= '0';
				sistema_onibus <= '1';
			when s6 =>
				ld_reg_id <= '0';
				reset_reg_id <= '0';
				set_new_ballance_as_db_out <= '0';
				load_db_out <= '0';
				reset_timer <= '1';
				display_on <= '0';
				display_error <= '0';
				abrir_catraca <= '0';
				leitura_cartao <= '0';
				sistema_onibus <= '1';
				leitura_cartao <= '0';
			when s7 =>
				ld_reg_id <= '0';
				reset_reg_id <= '0';
				set_new_ballance_as_db_out <= '0';
				load_db_out <= '0';
				reset_timer <= '0';
				display_on <= '0';
				display_error <= '0';
				abrir_catraca <= '1';
				leitura_cartao <= '0';
				sistema_onibus <= '1';
				leitura_cartao <= '0';

			when s8 =>
				ld_reg_id <= '0';
				reset_reg_id <= '0';
				set_new_ballance_as_db_out <= '0';
				load_db_out <= '0';
				reset_timer <= '0';
				display_on <= '0';
				display_error <= '1';
				abrir_catraca <= '0';
				leitura_cartao <= '0';
				sistema_onibus <= '1';
				leitura_cartao <= '0';

			when s9 =>
				ld_reg_id <= '0';
				reset_reg_id <= '0';
				set_new_ballance_as_db_out <= '0';
				load_db_out <= '0';
				reset_timer <= '0';
				display_on <= '0';
				display_error <= '0';
				abrir_catraca <= '0';
				leitura_cartao <= '0';
				sistema_onibus <= '1';
				leitura_cartao <= '0';
			when s10 =>
				ld_reg_id <= '0';
				reset_reg_id <= '0';
				set_new_ballance_as_db_out <= '0';
				load_db_out <= '1';
				reset_timer <= '0';
				display_on <= '0';
				display_error <= '1';
				abrir_catraca <= '0';
				leitura_cartao <= '0';
				sistema_onibus <= '1';
				leitura_cartao <= '0';
			when others =>
				ld_reg_id <= '0';
				reset_reg_id <= '0';
				set_new_ballance_as_db_out <= '0';
				load_db_out <= '0';
				reset_timer <= '0';
				display_on <= '0';
				display_error <= '0';
				abrir_catraca <= '0';
				leitura_cartao <= '0';
				sistema_onibus <= '0';
			end case;
	end process;

end rtl;
