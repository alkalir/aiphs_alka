// ----------------------------------------------------------------------------
//
// Multi-Dataflow Composer tool - Platform Composer
// Template Interface Layer module - Memory-Mapped type
// Date: 2018/11/08 13:25:28
//
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// Module Interface
// ----------------------------------------------------------------------------
module mm_accelerator#
(
	// Parameters of Axi Slave Bus Interface S01_AXI
	parameter integer C_S01_AXI_ID_WIDTH	= 1,
	parameter integer C_S01_AXI_DATA_WIDTH	= 32,
	parameter integer C_S01_AXI_ADDR_WIDTH	= 12,	// memory size 4096
	parameter integer C_S01_AXI_AWUSER_WIDTH	= 0,
	parameter integer C_S01_AXI_ARUSER_WIDTH	= 0,
	parameter integer C_S01_AXI_WUSER_WIDTH	= 0,
	parameter integer C_S01_AXI_RUSER_WIDTH	= 0,
	parameter integer C_S01_AXI_BUSER_WIDTH	= 0,
	
	// Parameters of Axi Slave Bus Interface S00_AXI
	parameter integer C_S00_AXI_DATA_WIDTH	= 32,
	parameter integer C_S00_AXI_ADDR_WIDTH	= 5
)
(
	// Ports of Axi Slave Bus Interface S01_AXI
	input wire  s01_axi_aclk,
	input wire  s01_axi_aresetn,
	input wire [C_S01_AXI_ID_WIDTH-1 : 0] s01_axi_awid,
	input wire [C_S01_AXI_ADDR_WIDTH-1 : 0] s01_axi_awaddr,
	input wire [7 : 0] s01_axi_awlen,
	input wire [2 : 0] s01_axi_awsize,
	input wire [1 : 0] s01_axi_awburst,
	input wire  s01_axi_awlock,
	input wire [3 : 0] s01_axi_awcache,
	input wire [2 : 0] s01_axi_awprot,
	input wire [3 : 0] s01_axi_awqos,
	input wire [3 : 0] s01_axi_awregion,
	input wire [C_S01_AXI_AWUSER_WIDTH-1 : 0] s01_axi_awuser,
	input wire  s01_axi_awvalid,
	output wire  s01_axi_awready,
	input wire [C_S01_AXI_DATA_WIDTH-1 : 0] s01_axi_wdata,
	input wire [(C_S01_AXI_DATA_WIDTH/8)-1 : 0] s01_axi_wstrb,
	input wire  s01_axi_wlast,
	input wire [C_S01_AXI_WUSER_WIDTH-1 : 0] s01_axi_wuser,
	input wire  s01_axi_wvalid,
	output wire  s01_axi_wready,
	output wire [C_S01_AXI_ID_WIDTH-1 : 0] s01_axi_bid,
	output wire [1 : 0] s01_axi_bresp,
	output wire [C_S01_AXI_BUSER_WIDTH-1 : 0] s01_axi_buser,
	output wire  s01_axi_bvalid,
	input wire  s01_axi_bready,
	input wire [C_S01_AXI_ID_WIDTH-1 : 0] s01_axi_arid,
	input wire [C_S01_AXI_ADDR_WIDTH-1 : 0] s01_axi_araddr,
	input wire [7 : 0] s01_axi_arlen,
	input wire [2 : 0] s01_axi_arsize,
	input wire [1 : 0] s01_axi_arburst,
	input wire  s01_axi_arlock,
	input wire [3 : 0] s01_axi_arcache,
	input wire [2 : 0] s01_axi_arprot,
	input wire [3 : 0] s01_axi_arqos,
	input wire [3 : 0] s01_axi_arregion,
	input wire [C_S01_AXI_ARUSER_WIDTH-1 : 0] s01_axi_aruser,
	input wire  s01_axi_arvalid,
	output wire  s01_axi_arready,
	output wire [C_S01_AXI_ID_WIDTH-1 : 0] s01_axi_rid,
	output wire [C_S01_AXI_DATA_WIDTH-1 : 0] s01_axi_rdata,
	output wire [1 : 0] s01_axi_rresp,
	output wire  s01_axi_rlast,
	output wire [C_S01_AXI_RUSER_WIDTH-1 : 0] s01_axi_ruser,
	output wire  s01_axi_rvalid,
	input wire  s01_axi_rready,
	
	// Ports of Axi Slave Bus Interface S00_AXI
	input wire  s00_axi_aclk,
	input wire  s00_axi_aresetn,
	input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
	input wire [2 : 0] s00_axi_awprot,
	input wire  s00_axi_awvalid,
	output wire  s00_axi_awready,
	input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
	input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
	input wire  s00_axi_wvalid,
	output wire  s00_axi_wready,
	output wire [1 : 0] s00_axi_bresp,
	output wire  s00_axi_bvalid,
	input wire  s00_axi_bready,
	input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
	input wire [2 : 0] s00_axi_arprot,
	input wire  s00_axi_arvalid,
	output wire  s00_axi_arready,
	output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
	output wire [1 : 0] s00_axi_rresp,
	output wire  s00_axi_rvalid,
	input wire  s00_axi_rready,
	
	// trace port 
	output wire  tr_start,
	output wire  tr_done,
	output wire tr_mac_16_2_in_data_rd,
	output wire tr_mac_16_1_in_data_rd,
	output wire tr_mac_16_0_in_data_rd
);


// ----------------------------------------------------------------------------
// Module Signals
// ----------------------------------------------------------------------------
// Wire(s) and Reg(s)
wire [31 : 0] slv_reg0;
wire start;
wire [31 : 0] slv_reg2;
wire [31 : 0] slv_reg3;
wire [31 : 0] slv_reg1;
wire [31 : 0] slv_reg4;
wire [31 : 0] slv_reg5;
wire [31 : 0] slv_reg6;
wire s01_axi_rden;
wire s01_axi_wren;
wire [C_S01_AXI_ADDR_WIDTH-3 : 0] s01_axi_address;
wire [31 : 0] s01_axi_data_in;
reg [31 : 0] s01_axi_data_out;
wire done;
wire done_input;
wire [32-1 : 0] din_data;
wire din_push;
wire din_full;
wire en_din;
wire done_din;
wire last_din;
wire [7:0] count_din;
wire wren_mem_1;
wire rden_mem_1;
wire [7:0] address_mem_1;
wire [31:0] data_in_mem_1;
wire [31:0] data_out_mem_1;
wire [31:0] data_out_1;
wire ce_1;
wire [64-1 : 0] dout_2_data;
wire dout_2_push;
wire dout_2_full;
wire [64-1 : 0] dout_1_data;
wire dout_1_push;
wire dout_1_full;
wire [64-1 : 0] dout_0_data;
wire dout_0_push;
wire dout_0_full;
wire done_output;
wire en_dout_2;
wire done_dout_2;
wire last_dout_2;
wire [7:0] count_dout_2;
wire rden_mem_2;
wire wren_mem_2;
wire [7:0] address_mem_2;
wire [31:0] data_in_mem_2;
wire [31:0] data_out_mem_2;
wire [31:0] data_out_2;
wire ce_2;
wire en_dout_1;
wire done_dout_1;
wire last_dout_1;
wire [7:0] count_dout_1;
wire rden_mem_3;
wire wren_mem_3;
wire [7:0] address_mem_3;
wire [31:0] data_in_mem_3;
wire [31:0] data_out_mem_3;
wire [31:0] data_out_3;
wire ce_3;
wire en_dout_0;
wire done_dout_0;
wire last_dout_0;
wire [7:0] count_dout_0;
wire rden_mem_4;
wire wren_mem_4;
wire [7:0] address_mem_4;
wire [31:0] data_in_mem_4;
wire [31:0] data_out_mem_4;
wire [31:0] data_out_4;
wire ce_4;

wire clear_monitor;
wire [31 : 0] count_data, count_full;

wire [31 : 0] sig_monitor_output;

// ----------------------------------------------------------------------------
// Body
// ----------------------------------------------------------------------------
// Configuration Registers
// ----------------------------------------------------------------------------
// Instantiation of Configuration Registers
config_registers # ( 
	.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
	.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
) i_config_registers (
	.S_AXI_ACLK(s00_axi_aclk),
	.S_AXI_ARESETN(s00_axi_aresetn),
	.S_AXI_AWADDR(s00_axi_awaddr),
	.S_AXI_AWPROT(s00_axi_awprot),
	.S_AXI_AWVALID(s00_axi_awvalid),
	.S_AXI_AWREADY(s00_axi_awready),
	.S_AXI_WDATA(s00_axi_wdata),
	.S_AXI_WSTRB(s00_axi_wstrb),
	.S_AXI_WVALID(s00_axi_wvalid),
	.S_AXI_WREADY(s00_axi_wready),
	.S_AXI_BRESP(s00_axi_bresp),
	.S_AXI_BVALID(s00_axi_bvalid),
	.S_AXI_BREADY(s00_axi_bready),
	.S_AXI_ARADDR(s00_axi_araddr),
	.S_AXI_ARPROT(s00_axi_arprot),
	.S_AXI_ARVALID(s00_axi_arvalid),
	.S_AXI_ARREADY(s00_axi_arready),
	.S_AXI_RDATA(s00_axi_rdata),
	.S_AXI_RRESP(s00_axi_rresp),
	.S_AXI_RVALID(s00_axi_rvalid),
	.S_AXI_RREADY(s00_axi_rready),
	.done(done),
	.start(start),
	.clear_monitor(clear_monitor),
	.count_data(count_data),
	.count_full(count_full),
	.slv_reg2(slv_reg2),
	.slv_reg3(slv_reg3),
	.slv_reg1(slv_reg1),
	.slv_reg4(slv_reg4),
	.slv_reg5(slv_reg5),
	.slv_reg6(sig_monitor_output),
    .slv_reg0(slv_reg0)
);
// ----------------------------------------------------------------------------

// Local Memories
// ----------------------------------------------------------------------------
// Instantiation of Local Memories
// ----------------------------------------------------------------------------
S01_AXI_ipif # (
	.C_S_AXI_ID_WIDTH(C_S01_AXI_ID_WIDTH),
	.C_S_AXI_DATA_WIDTH(C_S01_AXI_DATA_WIDTH),
	.C_S_AXI_ADDR_WIDTH(C_S01_AXI_ADDR_WIDTH),
	.C_S_AXI_AWUSER_WIDTH(C_S01_AXI_AWUSER_WIDTH),
	.C_S_AXI_ARUSER_WIDTH(C_S01_AXI_ARUSER_WIDTH),
	.C_S_AXI_WUSER_WIDTH(C_S01_AXI_WUSER_WIDTH),
	.C_S_AXI_RUSER_WIDTH(C_S01_AXI_RUSER_WIDTH),
	.C_S_AXI_BUSER_WIDTH(C_S01_AXI_BUSER_WIDTH)
) i_axi_full_ipif (
	.S_AXI_ACLK(s01_axi_aclk),
	.S_AXI_ARESETN(s01_axi_aresetn),
	.S_AXI_AWID(s01_axi_awid),
	.S_AXI_AWADDR(s01_axi_awaddr),
	.S_AXI_AWLEN(s01_axi_awlen),
	.S_AXI_AWSIZE(s01_axi_awsize),
	.S_AXI_AWBURST(s01_axi_awburst),
	.S_AXI_AWLOCK(s01_axi_awlock),
	.S_AXI_AWCACHE(s01_axi_awcache),
	.S_AXI_AWPROT(s01_axi_awprot),
	.S_AXI_AWQOS(s01_axi_awqos),
	.S_AXI_AWREGION(s01_axi_awregion),
	.S_AXI_AWUSER(s01_axi_awuser),
	.S_AXI_AWVALID(s01_axi_awvalid),
	.S_AXI_AWREADY(s01_axi_awready),
	.S_AXI_WDATA(s01_axi_wdata),
	.S_AXI_WSTRB(s01_axi_wstrb),
	.S_AXI_WLAST(s01_axi_wlast),
	.S_AXI_WUSER(s01_axi_wuser),
	.S_AXI_WVALID(s01_axi_wvalid),
	.S_AXI_WREADY(s01_axi_wready),
	.S_AXI_BID(s01_axi_bid),
	.S_AXI_BRESP(s01_axi_bresp),
	.S_AXI_BUSER(s01_axi_buser),
	.S_AXI_BVALID(s01_axi_bvalid),
	.S_AXI_BREADY(s01_axi_bready),
	.S_AXI_ARID(s01_axi_arid),
	.S_AXI_ARADDR(s01_axi_araddr),
	.S_AXI_ARLEN(s01_axi_arlen),
	.S_AXI_ARSIZE(s01_axi_arsize),
	.S_AXI_ARBURST(s01_axi_arburst),
	.S_AXI_ARLOCK(s01_axi_arlock),
	.S_AXI_ARCACHE(s01_axi_arcache),
	.S_AXI_ARPROT(s01_axi_arprot),
	.S_AXI_ARQOS(s01_axi_arqos),
	.S_AXI_ARREGION(s01_axi_arregion),
	.S_AXI_ARUSER(s01_axi_aruser),
	.S_AXI_ARVALID(s01_axi_arvalid),
	.S_AXI_ARREADY(s01_axi_arready),
	.S_AXI_RID(s01_axi_rid),
	.S_AXI_RDATA(s01_axi_rdata),
	.S_AXI_RRESP(s01_axi_rresp),
	.S_AXI_RLAST(s01_axi_rlast),
	.S_AXI_RUSER(s01_axi_ruser),
	.S_AXI_RVALID(s01_axi_rvalid),
	.S_AXI_RREADY(s01_axi_rready),
	.rden(s01_axi_rden),
	.wren(s01_axi_wren),
	.address(s01_axi_address),
	.data_in(s01_axi_data_in),
	.data_out(s01_axi_data_out)
);
// local memory 2
local_memory # (
	.SIZE_MEM(256),
	.SIZE_ADDR(8)
) i_local_memory_2 (
	.aclk(s01_axi_aclk),
	.ce_a(ce_2),
	.rden_a(s01_axi_rden),
	.wren_a(s01_axi_wren),
	.address_a(s01_axi_address),
	.data_in_a(s01_axi_data_in),
	.data_out_a(data_out_2),
	.rden_b(rden_mem_2),
	.wren_b(wren_mem_2),
	.address_b(address_mem_2),
	.data_in_b(data_in_mem_2),
	.data_out_b(data_out_mem_2)
);

assign ce_2 = (s01_axi_rden || s01_axi_wren) && (s01_axi_address[9:8] == 1);
// local memory 3
local_memory # (
	.SIZE_MEM(256),
	.SIZE_ADDR(8)
) i_local_memory_3 (
	.aclk(s01_axi_aclk),
	.ce_a(ce_3),
	.rden_a(s01_axi_rden),
	.wren_a(s01_axi_wren),
	.address_a(s01_axi_address),
	.data_in_a(s01_axi_data_in),
	.data_out_a(data_out_3),
	.rden_b(rden_mem_3),
	.wren_b(wren_mem_3),
	.address_b(address_mem_3),
	.data_in_b(data_in_mem_3),
	.data_out_b(data_out_mem_3)
);

assign ce_3 = (s01_axi_rden || s01_axi_wren) && (s01_axi_address[9:8] == 2);
// local memory 1
local_memory # (
	.SIZE_MEM(256),
	.SIZE_ADDR(8)
) i_local_memory_1 (
	.aclk(s01_axi_aclk),
	.ce_a(ce_1),
	.rden_a(s01_axi_rden),
	.wren_a(s01_axi_wren),
	.address_a(s01_axi_address),
	.data_in_a(s01_axi_data_in),
	.data_out_a(data_out_1),
	.rden_b(rden_mem_1),
	.wren_b(wren_mem_1),
	.address_b(address_mem_1),
	.data_in_b(data_in_mem_1),
	.data_out_b(data_out_mem_1)
);

assign ce_1 = (s01_axi_rden || s01_axi_wren) && (s01_axi_address[9:8] == 0);
// local memory 4
local_memory # (
	.SIZE_MEM(256),
	.SIZE_ADDR(8)
) i_local_memory_4 (
	.aclk(s01_axi_aclk),
	.ce_a(ce_4),
	.rden_a(s01_axi_rden),
	.wren_a(s01_axi_wren),
	.address_a(s01_axi_address),
	.data_in_a(s01_axi_data_in),
	.data_out_a(data_out_4),
	.rden_b(rden_mem_4),
	.wren_b(wren_mem_4),
	.address_b(address_mem_4),
	.data_in_b(data_in_mem_4),
	.data_out_b(data_out_mem_4)
);

assign ce_4 = (s01_axi_rden || s01_axi_wren) && (s01_axi_address[9:8] == 3);

always@(s01_axi_address or data_out_2 or data_out_3 or data_out_1 or data_out_4)
	case(s01_axi_address[9:8])
		1:	s01_axi_data_out = data_out_2;
		2:	s01_axi_data_out = data_out_3;
		0:	s01_axi_data_out = data_out_1;
		3:	s01_axi_data_out = data_out_4;
		default:	s01_axi_data_out = 0;
	endcase
// ----------------------------------------------------------------------------

// Coprocessor Front-End(s)
// ----------------------------------------------------------------------------
front_end i_front_end_din(
	.aclk(s01_axi_aclk),
	.aresetn(s01_axi_aresetn),
	.start(start),
	.last(last_din),
	.full(din_full),
	.en(en_din),
	.rden(rden_mem_1),
	.wr(din_push),
	.done(done_din)	
);

counter #(			
	.SIZE(8) ) 
i_counter_din (
	.aclk(s01_axi_aclk),
	.aresetn(s01_axi_aresetn),
	.clr(slv_reg0[2]),
	.en(en_din),
	.max(slv_reg1[7:0]),
	.count(count_din),
	.last(last_din)
);

assign address_mem_1 = count_din;
assign wren_mem_1 = 1'b0;
assign data_in_mem_1 = 32'b0;
		
assign done_input = done_din;
// ----------------------------------------------------------------------------
	
// Multi-Dataflow Reconfigurable Datapath
// ----------------------------------------------------------------------------


// to adapt profiling
multi_dataflow reconf_dpath (
	// Multi-Dataflow Input(s)
	.din_data(din_data),
	.din_wr(din_push),
	.din_full(din_full),
	// Multi-Dataflow Output(s)
	.dout_2_data(dout_2_data),
	.dout_2_wr(dout_2_push),
	.dout_2_full(dout_2_full),
	.dout_1_data(dout_1_data),
	.dout_1_wr(dout_1_push),
	.dout_1_full(dout_1_full),
	.dout_0_data(dout_0_data),
	.dout_0_wr(dout_0_push),
	.dout_0_full(dout_0_full),
	.clock(s00_axi_aclk),
	.reset(s00_axi_aresetn),
	.clr(clear_monitor), 
    .count_data(count_data),   
    .count_full(count_full), 
	// Multi-Dataflow Kernel ID
	.ID(slv_reg0[31:24]),
	.tr_mac_16_0_in_data_rd(tr_mac_16_0_in_data_rd),
	.tr_mac_16_1_in_data_rd(tr_mac_16_1_in_data_rd),
	.tr_mac_16_2_in_data_rd(tr_mac_16_2_in_data_rd)	
);
assign din_data = data_out_mem_1;
assign data_in_mem_2 = dout_2_data;
assign data_in_mem_3 = dout_1_data;
assign data_in_mem_4 = dout_0_data;

// ----------------------------------------------------------------------------	

// Coprocessor Back-End(s)
// ----------------------------------------------------------------------------
back_end i_back_end_dout_2(
	.aclk(s01_axi_aclk),
	.aresetn(s01_axi_aresetn),
	.start(start),
	.last(last_dout_2),
	.wr(dout_2_push),
	.wren(wren_mem_2),
	.en(en_dout_2),
	.full(dout_2_full),
	.done(done_dout_2)
);

counter #(			
	.SIZE(8) ) 
i_counter_dout_2 (
	.aclk(s01_axi_aclk),
	.aresetn(s01_axi_aresetn),
	.clr(slv_reg0[2]),
	.en(en_dout_2),
	.max(slv_reg2[7:0]),
	.count(count_dout_2),
	.last(last_dout_2)
);

assign address_mem_2 = count_dout_2;
assign rden_mem_2 = 1'b0;

back_end i_back_end_dout_1(
	.aclk(s01_axi_aclk),
	.aresetn(s01_axi_aresetn),
	.start(start),
	.last(last_dout_1),
	.wr(dout_1_push),
	.wren(wren_mem_3),
	.en(en_dout_1),
	.full(dout_1_full),
	.done(done_dout_1)
);

counter #(			
	.SIZE(8) ) 
i_counter_dout_1 (
	.aclk(s01_axi_aclk),
	.aresetn(s01_axi_aresetn),
	.clr(slv_reg0[2]),
	.en(en_dout_1),
	.max(slv_reg3[7:0]),
	.count(count_dout_1),
	.last(last_dout_1)
);

assign address_mem_3 = count_dout_1;
assign rden_mem_3 = 1'b0;

back_end i_back_end_dout_0(
	.aclk(s01_axi_aclk),
	.aresetn(s01_axi_aresetn),
	.start(start),
	.last(last_dout_0),
	.wr(dout_0_push),
	.wren(wren_mem_4),
	.en(en_dout_0),
	.full(dout_0_full),
	.done(done_dout_0)
);

counter #(			
	.SIZE(8) ) 
i_counter_dout_0 (
	.aclk(s01_axi_aclk),
	.aresetn(s01_axi_aresetn),
	.clr(slv_reg0[2]),
	.en(en_dout_0),
	.max(slv_reg4[7:0]),
	.count(count_dout_0),
	.last(last_dout_0)
);

assign address_mem_4 = count_dout_0;
assign rden_mem_4 = 1'b0;

assign done_output = done_dout_2 && done_dout_1 && done_dout_0;
assign done = done_input && done_output;

assign tr_start = start;
assign tr_done = done;

//// ----------------------------------------------------------------------------

//// 2nd level monitor (FEBE)
//// ----------------------------------------------------------------------------
//monitor_FEBE FEBE1(
//        .timing(s01_axi_aclk),
//        .rst (clear_monitor),
//        .start(start),
//        .done(done),
//        .monitor_output(sig_monitor_output)
//);

// ----------------------------------------------------------------------------

endmodule
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------