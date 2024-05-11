import cocotb

from cocotb.clock import Clock, Timer
from cocotb.triggers import ClockCycles, RisingEdge

from cocotbext.axi import AxiBus, AxiMaster

ADDR_USER_INPUT_1 = 0x0
ADDR_USER_INPUT_2 = 0x4
ADDR_USER_INPUT_3 = 0x8
ADDR_USER_INPUT_4 = 0xC

@cocotb.test()
async def test_read_input_1(dut):
    axi_master = AxiMaster(AxiBus.from_prefix(dut, "s_axi"), dut.clk, dut.rst, False)

    # start the clock
    cocotb.start_soon(Clock(dut.clk, 1, units="ns").start())
    # assert the reset (active low)
    dut.rst.value = 0
    await ClockCycles(dut.clk, 2)
    dut.rst.value = 1

    data = await axi_master.read(ADDR_USER_INPUT_1, 1)

    # convert the read bytes to int
    val = int.from_bytes(data.data, "little")
    assert val == 42

@cocotb.test()
async def test_read_input_2(dut):
    axi_master = AxiMaster(AxiBus.from_prefix(dut, "s_axi"), dut.clk, dut.rst, False)

    # start the clock
    cocotb.start_soon(Clock(dut.clk, 1, units="ns").start())
    # assert the reset (active low)
    dut.rst.value = 0
    await ClockCycles(dut.clk, 2)
    dut.rst.value = 1

    data = await axi_master.read(ADDR_USER_INPUT_2, 2)

    # convert the read bytes to int
    val = int.from_bytes(data.data, "little")
    assert val == 31415

@cocotb.test()
async def test_read_input_3(dut):
    axi_master = AxiMaster(AxiBus.from_prefix(dut, "s_axi"), dut.clk, dut.rst, False)

    # start the clock
    cocotb.start_soon(Clock(dut.clk, 1, units="ns").start())
    # assert the reset (active low)
    dut.rst.value = 0
    await ClockCycles(dut.clk, 2)
    dut.rst.value = 1

    data = await axi_master.read(ADDR_USER_INPUT_3, 3)

    # convert the read bytes to int
    val = int.from_bytes(data.data, "little")
    assert val == 291093

@cocotb.test()
async def test_read_input_4(dut):
    axi_master = AxiMaster(AxiBus.from_prefix(dut, "s_axi"), dut.clk, dut.rst, False)

    # start the clock
    cocotb.start_soon(Clock(dut.clk, 1, units="ns").start())
    # assert the reset (active low)
    dut.rst.value = 0
    await ClockCycles(dut.clk, 2)
    dut.rst.value = 1

    data = await axi_master.read(ADDR_USER_INPUT_4, 4)

    # convert the read bytes to int
    val = int.from_bytes(data.data, "little")
    assert val == 17091991 # linux release date 
