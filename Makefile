
SIM ?= ghdl
TOPLEVEL_LANG ?= vhdl

VHDL_SOURCES += hdl/top_constant.vhd hdl/axi_constant.vhd

TOPLEVEL = top_constant
MODULE = test_axi_constant

EXTRA_ARGS = -fsynopsys -fexplicit --std=08
SIM_ARGS ?= --wave=waveform.ghw --stop-time=100ns

include $(shell cocotb-config --makefiles)/Makefile.sim
