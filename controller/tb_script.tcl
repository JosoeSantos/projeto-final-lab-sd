#
#vsim -do tb_script.do
# cd C:/Users/jssan/OneDrive/LabSD/ProjetoFinal/components/controller
# set ms [examine sim/:tb:uut:imem:mem_array_size]

if {[file exists work]} {
vdel -lib work -all
}
vlib work
vcom -explicit  -93 "controller.vhd"
vcom -explicit  -93 "tb_controller.vhd"
vsim -t 1ns   -lib work tb_controller
add wave sim:/tb_controller/*
#do {wave.do}
add wave sim:/tb_controller/instance_dut/state
view wave
view structure
view signals
run 200ns
wave zoom full
#quit -force

