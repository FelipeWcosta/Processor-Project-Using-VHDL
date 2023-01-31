onerror {quit -f}
vlib work
vlog -work work ir.vo
vlog -work work ir.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.ir_vlg_vec_tst
vcd file -direction ir.msim.vcd
vcd add -internal ir_vlg_vec_tst/*
vcd add -internal ir_vlg_vec_tst/i1/*
add wave /*
run -all
