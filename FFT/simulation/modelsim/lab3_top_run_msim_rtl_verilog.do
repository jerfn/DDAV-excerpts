transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+//Mac/Home/Documents/DAV/lab3 {//Mac/Home/Documents/DAV/lab3/butterfly.sv}
vlog -sv -work work +incdir+//Mac/Home/Documents/DAV/lab3 {//Mac/Home/Documents/DAV/lab3/fft.sv}
vlog -sv -work work +incdir+//Mac/Home/Documents/DAV/lab3 {//Mac/Home/Documents/DAV/lab3/ft_tb.sv}
vlog -sv -work work +incdir+//Mac/Home/Documents/DAV/lab3 {//Mac/Home/Documents/DAV/lab3/fft16.sv}

