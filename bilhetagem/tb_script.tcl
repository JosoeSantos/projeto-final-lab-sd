if {[file exists work]} {
vdel -lib work -all
}
vlib work
vcom -explicit  -93 "bilhetagem.vhd"
vcom -explicit  -93 "tb_bilhetagem.vhd"
vsim -t 1ns   -lib work tb_bilhetagem
add wave sim:/tb_bilhetagem/*
add wave sim:/tb_bilhetagem/instance_dut/ld_reg_id
view wave
view structure
view signals
run 75ns
wave zoom full