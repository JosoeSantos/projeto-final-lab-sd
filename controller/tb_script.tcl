#
#vsim -do tb_script.do

if {[file exists work]} {
vdel -lib work -all
}
vlib work
vcom -explicit  -93 "controller.vhd"
vcom -explicit  -93 "tb_controller.vhd"
vsim -t 1ns   -lib work tb_controller
add wave sim:/tb_controller/*
#do {wave.do}
view wave
view structure
view signals
run 200ns
#quit -force

