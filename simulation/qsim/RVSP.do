onerror {exit -code 1}
vlib work
vlog -work work RVSP.vo
vlog -work work testa_processador_debug.vwf.vt
vsim -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate_ver -L altera_lnsim_ver work.processador_debug_vlg_vec_tst
vcd file -direction RVSP.msim.vcd
vcd add -internal processador_debug_vlg_vec_tst/*
vcd add -internal processador_debug_vlg_vec_tst/i1/*
proc simTimestamp {} {
    echo "Simulation time: $::now ps"
    if { [string equal running [runStatus]] } {
        after 2500 simTimestamp
    }
}
after 2500 simTimestamp
run -all
quit -f
