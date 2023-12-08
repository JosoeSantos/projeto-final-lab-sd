#vsim -do tb_script.do
#puts {
#  Arquivo Exemplo de um FFD para Guia de aula_10
#  Laboratoria de Sistemas Digitais 
#  Autores: Professores da Area de Eletronica UFMG
#}

# Exemplo simples de como usar um script em TCL 
# para automatizar as simulacoes com ModelSim
# Para cada novo projeto devem ser modificados 
# os nomes relativos aos arquivos dentro do projeto. 

if {[file exists work]} {
vdel -lib work -all
}
vlib work
vcom -explicit  -93 "datapath.vhd"
vcom -explicit  -93 "tb_datapath.vhd"
vsim -t 1ns   -lib work tb_datapath
add wave sim:/tb_datapath/*
add wave sim:/tb_datapath/datapath_instance/fio_Q_reg_banco  
add wave sim:/tb_datapath/datapath_instance/fio_Q_reg_preco 
add wave sim:/tb_datapath/datapath_instance/fio_Q_mux_cartao 
add wave sim:/tb_datapath/datapath_instance/fio_Q_subtrator 
add wave sim:/tb_datapath/datapath_instance/fio_Q_mux_sub 
add wave sim:/tb_datapath/datapath_instance/fio_Q_mux_display 
# do {wave.do}
view wave
view structure
view signals
run 20ns
wave zoom full
#quit -force

