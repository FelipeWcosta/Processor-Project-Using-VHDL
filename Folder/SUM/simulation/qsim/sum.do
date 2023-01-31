onerror {quit -f}
vlib work
vlog -work work sum.vo
vlog -work work sum.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.sum_vlg_vec_tst
vcd file -direction sum.msim.vcd
vcd add -internal sum_vlg_vec_tst/*
vcd add -internal sum_vlg_vec_tst/i1/*
add wave /*
run -all
