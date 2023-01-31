onerror {quit -f}
vlib work
vlog -work work RF_Rp.vo
vlog -work work RF_Rp.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.RF_Rp_vlg_vec_tst
vcd file -direction RF_Rp.msim.vcd
vcd add -internal RF_Rp_vlg_vec_tst/*
vcd add -internal RF_Rp_vlg_vec_tst/i1/*
add wave /*
run -all
