vlib work

vlog tlight.sv
vlog tb_tlight.sv

vsim work.tb_tlight

add wave -position insertpoint\
	/tb_tlight/r					\
	/tb_tlight/a					\
	/tb_tlight/g					\
	/tb_tlight/clk					

run 200 ns