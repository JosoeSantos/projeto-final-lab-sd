if {[file exists work]} {
vdel -lib work -all
}
vlib work
vcom -explicit  -93 "../comp/comparador.vhd"
vcom -explicit  -93 "../DivisorClock50MHz_To_1Hz/DivisorClock.vhd"
vcom -explicit  -93 "../mux/mux2.vhd"
vcom -explicit  -93 "../registrador/flip_flop.vhd"
vcom -explicit  -93 "../subtrator/subtrator.vhd"
vcom -explicit  -93 "../datapath/datapath.vhd"
vcom -explicit  -93 "../controller/controller.vhd"
vcom -explicit  -93 "bilhetagem.vhd"
vcom -explicit  -93 "tb_bilhetagem.vhd"
vsim -t 1ns   -lib work tb_bilhetagem
add wave sim:/tb_bilhetagem/*
add wave sim:/tb_bilhetagem/instance_dut/instance_controler/state
view wave
view structure
view signals
run 75ns
wave zoom full