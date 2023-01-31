onerror {quit -f}
vlib work
vlog -work work data_i.vo
vlog -work work data_i.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.data_i_vlg_vec_tst
vcd file -direction data_i.msim.vcd
vcd add -internal data_i_vlg_vec_tst/*
vcd add -internal data_i_vlg_vec_tst/i1/*
add wave /*
run -all
