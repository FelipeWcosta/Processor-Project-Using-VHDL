onerror {quit -f}
vlib work
vlog -work work processador_demonstracao.vo
vlog -work work processador_demonstracao.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.processador_demonstracao_vlg_vec_tst
vcd file -direction processador_demonstracao.msim.vcd
vcd add -internal processador_demonstracao_vlg_vec_tst/*
vcd add -internal processador_demonstracao_vlg_vec_tst/i1/*
add wave /*
run -all
