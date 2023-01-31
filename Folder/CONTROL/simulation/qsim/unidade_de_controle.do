onerror {quit -f}
vlib work
vlog -work work unidade_de_controle.vo
vlog -work work unidade_de_controle.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.unidade_de_controle_vlg_vec_tst
vcd file -direction unidade_de_controle.msim.vcd
vcd add -internal unidade_de_controle_vlg_vec_tst/*
vcd add -internal unidade_de_controle_vlg_vec_tst/i1/*
add wave /*
run -all
