-- top constant
-- used for simulation

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity top_constant is
    generic (
        -- Width of ID for for write address, write data, read address and read data
        C_S_AXI_ID_WIDTH	: integer	:= 1;
        -- Width of S_AXI data bus
        C_S_AXI_DATA_WIDTH	: integer	:= 32;
        -- Width of S_AXI address bus
        C_S_AXI_ADDR_WIDTH	: integer	:= 9;
        -- Width of optional user defined signal in write address channel
        C_S_AXI_AWUSER_WIDTH	: integer	:= 0;
        -- Width of optional user defined signal in read address channel
        C_S_AXI_ARUSER_WIDTH	: integer	:= 0;
        -- Width of optional user defined signal in write data channel
        C_S_AXI_WUSER_WIDTH	: integer	:= 0;
        -- Width of optional user defined signal in read data channel
        C_S_AXI_RUSER_WIDTH	: integer	:= 0;
        -- Width of optional user defined signal in write response channel
        C_S_AXI_BUSER_WIDTH	: integer	:= 0
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        s_axi_awid : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
        s_axi_awaddr : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        s_axi_awlen : in std_logic_vector(7 downto 0);
        s_axi_awsize : in std_logic_vector(2 downto 0);
        s_axi_awburst : in std_logic_vector(1 downto 0);
        s_axi_awlock : in std_logic;
        s_axi_awcache : in std_logic_vector(3 downto 0);
        s_axi_awprot : in std_logic_vector(2 downto 0);
        s_axi_awqos : in std_logic_vector(3 downto 0);
        s_axi_awregion : in std_logic_vector(3 downto 0);
        s_axi_awuser : in std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
        s_axi_awvalid : in std_logic;
        s_axi_awready : out std_logic;
        s_axi_wdata : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        s_axi_wstrb : in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
        s_axi_wlast : in std_logic;
        s_axi_wuser : in std_logic_vector(C_S_AXI_WUSER_WIDTH-1 downto 0);
        s_axi_wvalid : in std_logic;
        s_axi_wready : out std_logic;
        s_axi_bid : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
        s_axi_bresp : out std_logic_vector(1 downto 0);
        s_axi_buser : out std_logic_vector(C_S_AXI_BUSER_WIDTH-1 downto 0);
        s_axi_bvalid : out std_logic;
        s_axi_bready : in std_logic;
        s_axi_arid : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
        s_axi_araddr : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        s_axi_arlen : in std_logic_vector(7 downto 0);
        s_axi_arsize : in std_logic_vector(2 downto 0);
        s_axi_arburst : in std_logic_vector(1 downto 0);
        s_axi_arlock : in std_logic;
        s_axi_arcache : in std_logic_vector(3 downto 0);
        s_axi_arprot : in std_logic_vector(2 downto 0);
        s_axi_arqos : in std_logic_vector(3 downto 0);
        s_axi_arregion : in std_logic_vector(3 downto 0);
        s_axi_aruser : in std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
        s_axi_arvalid : in std_logic;
        s_axi_arready : out std_logic;
        s_axi_rid : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
        s_axi_rdata	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        s_axi_rresp	: out std_logic_vector(1 downto 0);
        s_axi_rlast : out std_logic;
        s_axi_ruser : out std_logic_vector(C_S_AXI_RUSER_WIDTH-1 downto 0);
        s_axi_rvalid : out std_logic;
        s_axi_rready : in std_logic
    );
end entity;

architecture rtl of top_constant is

    constant USER_INPUT_CONSTANT_1 : integer := 42;
    constant USER_INPUT_CONSTANT_2 : integer := 31415;
    constant USER_INPUT_CONSTANT_3 : integer := 291093;
    constant USER_INPUT_CONSTANT_4 : integer := 17091991;

    component axi_constant is
        port (
        -- User defined interface
	    INPUT_CONSTANT_1 : in std_logic_vector (C_S_AXI_DATA_WIDTH-1 downto 0);
	    INPUT_CONSTANT_2 : in std_logic_vector (C_S_AXI_DATA_WIDTH-1 downto 0);
	    INPUT_CONSTANT_3 : in std_logic_vector (C_S_AXI_DATA_WIDTH-1 downto 0);
	    INPUT_CONSTANT_4 : in std_logic_vector (C_S_AXI_DATA_WIDTH-1 downto 0);
        -- AXI interface
        -- Global Clock Signal
        S_AXI_ACLK	: in std_logic;
        -- Global Reset Signal. This Signal is Active LOW
        S_AXI_ARESETN	: in std_logic;
        -- Write Address ID
        S_AXI_AWID	: in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
        -- Write address
        S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        -- Burst length. The burst length gives the exact number of transfers in a burst
        S_AXI_AWLEN	: in std_logic_vector(7 downto 0);
        -- Burst size. This signal indicates the size of each transfer in the burst
        S_AXI_AWSIZE	: in std_logic_vector(2 downto 0);
        -- Burst type. The burst type and the size information, 
        -- determine how the address for each transfer within the burst is calculated.
        S_AXI_AWBURST	: in std_logic_vector(1 downto 0);
        -- Lock type. Provides additional information about the
        -- atomic characteristics of the transfer.
        S_AXI_AWLOCK	: in std_logic;
        -- Memory type. This signal indicates how transactions
        -- are required to progress through a system.
        S_AXI_AWCACHE	: in std_logic_vector(3 downto 0);
        -- Protection type. This signal indicates the privilege
        -- and security level of the transaction, and whether
        -- the transaction is a data access or an instruction access.
        S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
        -- Quality of Service, QoS identifier sent for each
        -- write transaction.
        S_AXI_AWQOS	: in std_logic_vector(3 downto 0);
        -- Region identifier. Permits a single physical interface
        -- on a slave to be used for multiple logical interfaces.
        S_AXI_AWREGION	: in std_logic_vector(3 downto 0);
        -- Optional User-defined signal in the write address channel.
        S_AXI_AWUSER	: in std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
        -- Write address valid. This signal indicates that
        -- the channel is signaling valid write address and
        -- control information.
        S_AXI_AWVALID	: in std_logic;
        -- Write address ready. This signal indicates that
        -- the slave is ready to accept an address and associated
        -- control signals.
        S_AXI_AWREADY	: out std_logic;
        -- Write Data
        S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        -- Write strobes. This signal indicates which byte
        -- lanes hold valid data. There is one write strobe
        -- bit for each eight bits of the write data bus.
        S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
        -- Write last. This signal indicates the last transfer
        -- in a write burst.
        S_AXI_WLAST	: in std_logic;
        -- Optional User-defined signal in the write data channel.
        S_AXI_WUSER	: in std_logic_vector(C_S_AXI_WUSER_WIDTH-1 downto 0);
        -- Write valid. This signal indicates that valid write
        -- data and strobes are available.
        S_AXI_WVALID	: in std_logic;
        -- Write ready. This signal indicates that the slave
        -- can accept the write data.
        S_AXI_WREADY	: out std_logic;
        -- Response ID tag. This signal is the ID tag of the
        -- write response.
        S_AXI_BID	: out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
        -- Write response. This signal indicates the status
        -- of the write transaction.
        S_AXI_BRESP	: out std_logic_vector(1 downto 0);
        -- Optional User-defined signal in the write response channel.
        S_AXI_BUSER	: out std_logic_vector(C_S_AXI_BUSER_WIDTH-1 downto 0);
        -- Write response valid. This signal indicates that the
        -- channel is signaling a valid write response.
        S_AXI_BVALID	: out std_logic;
        -- Response ready. This signal indicates that the master
        -- can accept a write response.
        S_AXI_BREADY	: in std_logic;
        -- Read address ID. This signal is the identification
        -- tag for the read address group of signals.
        S_AXI_ARID	: in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
        -- Read address. This signal indicates the initial
        -- address of a read burst transaction.
        S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        -- Burst length. The burst length gives the exact number of transfers in a burst
        S_AXI_ARLEN	: in std_logic_vector(7 downto 0);
        -- Burst size. This signal indicates the size of each transfer in the burst
        S_AXI_ARSIZE	: in std_logic_vector(2 downto 0);
        -- Burst type. The burst type and the size information, 
        -- determine how the address for each transfer within the burst is calculated.
        S_AXI_ARBURST	: in std_logic_vector(1 downto 0);
        -- Lock type. Provides additional information about the
        -- atomic characteristics of the transfer.
        S_AXI_ARLOCK	: in std_logic;
        -- Memory type. This signal indicates how transactions
        -- are required to progress through a system.
        S_AXI_ARCACHE	: in std_logic_vector(3 downto 0);
        -- Protection type. This signal indicates the privilege
        -- and security level of the transaction, and whether
        -- the transaction is a data access or an instruction access.
        S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
        -- Quality of Service, QoS identifier sent for each
        -- read transaction.
        S_AXI_ARQOS	: in std_logic_vector(3 downto 0);
        -- Region identifier. Permits a single physical interface
        -- on a slave to be used for multiple logical interfaces.
        S_AXI_ARREGION	: in std_logic_vector(3 downto 0);
        -- Optional User-defined signal in the read address channel.
        S_AXI_ARUSER	: in std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
        -- Write address valid. This signal indicates that
        -- the channel is signaling valid read address and
        -- control information.
        S_AXI_ARVALID	: in std_logic;
        -- Read address ready. This signal indicates that
        -- the slave is ready to accept an address and associated
        -- control signals.
        S_AXI_ARREADY	: out std_logic;
        -- Read ID tag. This signal is the identification tag
        -- for the read data group of signals generated by the slave.
        S_AXI_RID	: out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
        -- Read Data
        S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        -- Read response. This signal indicates the status of
        -- the read transfer.
        S_AXI_RRESP	: out std_logic_vector(1 downto 0);
        -- Read last. This signal indicates the last transfer
        -- in a read burst.
        S_AXI_RLAST	: out std_logic;
        -- Optional User-defined signal in the read address channel.
        S_AXI_RUSER	: out std_logic_vector(C_S_AXI_RUSER_WIDTH-1 downto 0);
        -- Read valid. This signal indicates that the channel
        -- is signaling the required read data.
        S_AXI_RVALID	: out std_logic;
        -- Read ready. This signal indicates that the master can
        -- accept the read data and response information.
        S_AXI_RREADY	: in std_logic
    );
    end component;

    signal c_input_constant_1 : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal c_input_constant_2 : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal c_input_constant_3 : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal c_input_constant_4 : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
begin

    c_input_constant_1 <= std_logic_vector(to_unsigned(USER_INPUT_CONSTANT_1, c_input_constant_1'length));
    c_input_constant_2 <= std_logic_vector(to_unsigned(USER_INPUT_CONSTANT_2, c_input_constant_2'length));
    c_input_constant_3 <= std_logic_vector(to_unsigned(USER_INPUT_CONSTANT_3, c_input_constant_3'length));
    c_input_constant_4 <= std_logic_vector(to_unsigned(USER_INPUT_CONSTANT_4, c_input_constant_4'length));


    dut: axi_constant
        port map (
            INPUT_CONSTANT_1 => c_input_constant_1,
            INPUT_CONSTANT_2 => c_input_constant_2,
            INPUT_CONSTANT_3 => c_input_constant_3,
            INPUT_CONSTANT_4 => c_input_constant_4,

            S_AXI_ACLK   => clk,
            S_AXI_ARESETN => rst,
            S_AXI_AWID => s_axi_awid,
            S_AXI_AWADDR => s_axi_awaddr,
            S_AXI_AWLEN => s_axi_awlen,
            S_AXI_AWSIZE  => s_axi_awsize,
            S_AXI_AWBURST => s_axi_awburst,
            S_AXI_AWLOCK => s_axi_awlock,
            S_AXI_AWCACHE => s_axi_awcache,
            S_AXI_AWPROT => s_axi_awprot,
            S_AXI_AWQOS  => s_axi_awqos,
            S_AXI_AWREGION => s_axi_awregion,
            S_AXI_AWUSER => s_axi_awuser,
            S_AXI_AWVALID => s_axi_awvalid,
            S_AXI_AWREADY => s_axi_awready,
            S_AXI_WDATA => s_axi_wdata,
            S_AXI_WSTRB  => s_axi_wstrb,
            S_AXI_WLAST  => s_axi_wlast,
            S_AXI_WUSER  => s_axi_wuser,
            S_AXI_WVALID => s_axi_wvalid,
            S_AXI_WREADY => s_axi_wready,
            S_AXI_BID  => s_axi_bid,
            S_AXI_BRESP  => s_axi_bresp,
            S_AXI_BUSER  => s_axi_buser,
            S_AXI_BVALID => s_axi_bvalid,
            S_AXI_BREADY => s_axi_bready,
            S_AXI_ARID  => s_axi_arid,
            S_AXI_ARADDR => s_axi_araddr,
            S_AXI_ARLEN  => s_axi_arlen,
            S_AXI_ARSIZE => s_axi_arsize,
            S_AXI_ARBURST => s_axi_arburst,
            S_AXI_ARLOCK => s_axi_arlock,
            S_AXI_ARCACHE => s_axi_arcache,
            S_AXI_ARPROT => s_axi_arprot,
            S_AXI_ARQOS  => s_axi_arqos,
            S_AXI_ARREGION => s_axi_arregion,
            S_AXI_ARUSER => s_axi_aruser,
            S_AXI_ARVALID => s_axi_arvalid,
            S_AXI_ARREADY => s_axi_arready,
            S_AXI_RID  => s_axi_rid,
            S_AXI_RDATA  => s_axi_rdata,
            S_AXI_RRESP  => s_axi_rresp,
            S_AXI_RLAST  => s_axi_rlast,
            S_AXI_RUSER  => s_axi_ruser,
            S_AXI_RVALID => s_axi_rvalid,
            S_AXI_RREADY => s_axi_rready
        );

end architecture;