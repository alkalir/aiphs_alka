// ----------------------------------------------------------------------------
//
// This file has been automatically generated by:
// Multi-Dataflow Composer tool - Platform Composer
// Template Interface Layer module - Memory-Mapped type
// on 2019/12/06 08:45:57
// More info available at http://sites.unica.it/rpct/
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
	parameter integer C_S01_AXI_ADDR_WIDTH	= 16,
	parameter integer C_S01_AXI_AWUSER_WIDTH	= 0,
	parameter integer C_S01_AXI_ARUSER_WIDTH	= 0,
	parameter integer C_S01_AXI_WUSER_WIDTH	= 0,
	parameter integer C_S01_AXI_RUSER_WIDTH	= 0,
	parameter integer C_S01_AXI_BUSER_WIDTH	= 0,
	
	// Parameters of Axi Slave Bus Interface S00_AXI
	parameter integer C_S00_AXI_DATA_WIDTH	= 32,
	parameter integer C_S00_AXI_ADDR_WIDTH	= 4
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
    output wire tr_start,
    output wire tr_done,
    output wire tr_line_buffer_0_in_pel_rd,
    output wire tr_fifo_big_line_buffer_0_in_pel_wr,
    output wire tr_fifo_big_line_buffer_0_real_size_wr,
    output wire tr_line_buffer_0_real_size_rd
);


// ----------------------------------------------------------------------------
// Module Signals
// ----------------------------------------------------------------------------
// Parameters
// local memory 1 (in_size)
localparam SIZE_MEM_1 = 4;
localparam [15:0] BASE_ADDR_MEM_1 = 0;
parameter SIZE_ADDR_1 = $clog2(SIZE_MEM_1);
// local memory 3 (out_pel)
localparam SIZE_MEM_3 = 1024;
localparam [15:0] BASE_ADDR_MEM_3 = SIZE_MEM_2 + BASE_ADDR_MEM_2;
parameter SIZE_ADDR_3 = $clog2(SIZE_MEM_3);
// local memory 2 (in_pel)
localparam SIZE_MEM_2 = 2048;
localparam [15:0] BASE_ADDR_MEM_2 = SIZE_MEM_1 + BASE_ADDR_MEM_1;
parameter SIZE_ADDR_2 = $clog2(SIZE_MEM_2);

// Wire(s) and Reg(s)
wire [31 : 0] slv_reg0;
wire start;
wire [31 : 0] slv_reg1;
wire [31 : 0] slv_reg3;
wire [31 : 0] slv_reg2;
wire s01_axi_rden;
wire s01_axi_wren;
wire [C_S01_AXI_ADDR_WIDTH-3 : 0] s01_axi_address;
wire [31 : 0] s01_axi_data_in;
reg [31 : 0] s01_axi_data_out;
wire done;
wire done_input;
wire [6-1 : 0] in_size_data;
wire in_size_push;
wire in_size_full;
wire [8-1 : 0] in_pel_data;
wire in_pel_push;
wire in_pel_full;
wire en_in_size;
wire done_in_size;
wire last_in_size;
wire [SIZE_ADDR_1-1:0] count_in_size;
wire wren_mem_1;
wire rden_mem_1;
wire [SIZE_ADDR_1-1:0] address_mem_1;
wire [6-1:0] data_in_mem_1;
wire [6-1:0] data_out_mem_1;
wire [6-1:0] data_out_1;
wire ce_1;
wire en_in_pel;
wire done_in_pel;
wire last_in_pel;
wire [SIZE_ADDR_2-1:0] count_in_pel;
wire wren_mem_2;
wire rden_mem_2;
wire [SIZE_ADDR_2-1:0] address_mem_2;
wire [8-1:0] data_in_mem_2;
wire [8-1:0] data_out_mem_2;
wire [8-1:0] data_out_2;
wire ce_2;
wire [8-1 : 0] out_pel_data;
wire out_pel_push;
wire out_pel_full;
wire done_output;
wire en_out_pel;
wire done_out_pel;
wire last_out_pel;
wire [SIZE_ADDR_3-1:0] count_out_pel;
wire rden_mem_3;
wire wren_mem_3;
wire [SIZE_ADDR_3-1:0] address_mem_3;
wire [8-1:0] data_in_mem_3;
wire [8-1:0] data_out_mem_3;
wire [8-1:0] data_out_3;
wire ce_3;


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
	.slv_reg1(slv_reg1),
	.slv_reg3(slv_reg3),
	.slv_reg2(slv_reg2),
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
// local memory 1 (in_size)
local_memory # (
	.SIZE_WORD(6),
	.SIZE_MEM(SIZE_MEM_1),
	.SIZE_ADDR(SIZE_ADDR_1)
) i_local_memory_1 (
	.aclk_a(s01_axi_aclk),
	.ce_a(ce_1),
	.rden_a(s01_axi_rden),
	.wren_a(s01_axi_wren),
	.address_a(s01_axi_address-BASE_ADDR_MEM_1),
	.data_in_a(s01_axi_data_in[6-1:0]),
	.data_out_a(data_out_1),
	.aclk_b(s01_axi_aclk),
	.ce_b(rden_mem_1),
	.rden_b(rden_mem_1),
	.wren_b(wren_mem_1),
	.address_b(address_mem_1),
	.data_in_b(data_in_mem_1),
	.data_out_b(data_out_mem_1)
);

assign ce_1 = (s01_axi_rden || s01_axi_wren)
&& (s01_axi_address >= BASE_ADDR_MEM_1)
&& (s01_axi_address < BASE_ADDR_MEM_2);
// local memory 3 (out_pel)
local_memory # (
	.SIZE_WORD(8),
	.SIZE_MEM(SIZE_MEM_3),
	.SIZE_ADDR(SIZE_ADDR_3)
) i_local_memory_3 (
	.aclk_a(s01_axi_aclk),
	.ce_a(ce_3),
	.rden_a(s01_axi_rden),
	.wren_a(s01_axi_wren),
	.address_a(s01_axi_address-BASE_ADDR_MEM_3),
	.data_in_a(s01_axi_data_in[8-1:0]),
	.data_out_a(data_out_3),
	.aclk_b(s01_axi_aclk),
	.ce_b(wren_mem_3),
	.rden_b(rden_mem_3),
	.wren_b(wren_mem_3),
	.address_b(address_mem_3),
	.data_in_b(data_in_mem_3),
	.data_out_b(data_out_mem_3)
);

assign ce_3 = (s01_axi_rden || s01_axi_wren)
&& (s01_axi_address >= BASE_ADDR_MEM_3)
;
// local memory 2 (in_pel)
local_memory # (
	.SIZE_WORD(8),
	.SIZE_MEM(SIZE_MEM_2),
	.SIZE_ADDR(SIZE_ADDR_2)
) i_local_memory_2 (
	.aclk_a(s01_axi_aclk),
	.ce_a(ce_2),
	.rden_a(s01_axi_rden),
	.wren_a(s01_axi_wren),
	.address_a(s01_axi_address-BASE_ADDR_MEM_2),
	.data_in_a(s01_axi_data_in[8-1:0]),
	.data_out_a(data_out_2),
	.aclk_b(s01_axi_aclk),
	.ce_b(rden_mem_2),
	.rden_b(rden_mem_2),
	.wren_b(wren_mem_2),
	.address_b(address_mem_2),
	.data_in_b(data_in_mem_2),
	.data_out_b(data_out_mem_2)
);

assign ce_2 = (s01_axi_rden || s01_axi_wren)
&& (s01_axi_address >= BASE_ADDR_MEM_2)
&& (s01_axi_address < BASE_ADDR_MEM_3);

always@(ce_1 or data_out_1 or ce_3 or data_out_3 or ce_2 or data_out_2)
		if (ce_1)
			s01_axi_data_out = {{26{1'b0}},data_out_1}; else 
		if (ce_3)
			s01_axi_data_out = {{24{1'b0}},data_out_3}; else 
		if (ce_2)
			s01_axi_data_out = {{24{1'b0}},data_out_2};
		else
			s01_axi_data_out = 0;
// ----------------------------------------------------------------------------


// Coprocessor Front-End(s)
// ----------------------------------------------------------------------------
front_end i_front_end_in_size(
	.aclk(s01_axi_aclk),
	.aresetn(s01_axi_aresetn),
	.start(start),
	.last(last_in_size),
	.full(in_size_full),
	.en(en_in_size),
	.rden(rden_mem_1),
	.wr(in_size_push),
	.done(done_in_size)	
);

counter #(			
	.SIZE(SIZE_ADDR_1) ) 
i_counter_in_size (
	.aclk(s01_axi_aclk),
	.aresetn(s01_axi_aresetn),
	.clr(slv_reg0[2]),
	.en(en_in_size),
	.max(slv_reg1[SIZE_ADDR_1-1:0]),
	.count(count_in_size),
	.last(last_in_size)
);

assign address_mem_1 = count_in_size;
assign wren_mem_1 = 1'b0;
assign data_in_mem_1 = {6{1'b0}};
front_end i_front_end_in_pel(
	.aclk(s01_axi_aclk),
	.aresetn(s01_axi_aresetn),
	.start(start),
	.last(last_in_pel),
	.full(in_pel_full),
	.en(en_in_pel),
	.rden(rden_mem_2),
	.wr(in_pel_push),
	.done(done_in_pel)	
);

counter #(			
	.SIZE(SIZE_ADDR_2) ) 
i_counter_in_pel (
	.aclk(s01_axi_aclk),
	.aresetn(s01_axi_aresetn),
	.clr(slv_reg0[2]),
	.en(en_in_pel),
	.max(slv_reg2[SIZE_ADDR_2-1:0]),
	.count(count_in_pel),
	.last(last_in_pel)
);

assign address_mem_2 = count_in_pel;
assign wren_mem_2 = 1'b0;
assign data_in_mem_2 = {8{1'b0}};
		
assign done_input = done_in_size && done_in_pel;
// ----------------------------------------------------------------------------
	
// Multi-Dataflow Reconfigurable Datapath
// ----------------------------------------------------------------------------
// to adapt profiling
multi_dataflow reconf_dpath (
	// Multi-Dataflow Input(s)
	.in_size_data(in_size_data),
	.in_size_wr(in_size_push),
	.in_size_full(in_size_full),
	.in_pel_data(in_pel_data),
	.in_pel_wr(in_pel_push),
	.in_pel_full(in_pel_full),
	// Multi-Dataflow Output(s)
	.out_pel_data(out_pel_data),
	.out_pel_wr(out_pel_push),
	.out_pel_full(out_pel_full),
	.clock(s00_axi_aclk),
	.reset(s00_axi_aresetn),
	// Multi-Dataflow Kernel ID
	.ID(slv_reg0[31:24]),
    .tr_line_buffer_0_in_pel_rd (tr_line_buffer_0_in_pel_rd),
    .tr_fifo_big_line_buffer_0_in_pel_wr (tr_fifo_big_line_buffer_0_in_pel_wr),
    .tr_fifo_big_line_buffer_0_real_size_wr (tr_fifo_big_line_buffer_0_real_size_wr),
    .tr_line_buffer_0_real_size_rd (tr_line_buffer_0_real_size_rd)
);
assign in_size_data = data_out_mem_1;
assign in_pel_data = data_out_mem_2;
assign data_in_mem_3 = out_pel_data;
// ----------------------------------------------------------------------------	

// Coprocessor Back-End(s)
// ----------------------------------------------------------------------------
back_end i_back_end_out_pel(
	.aclk(s01_axi_aclk),
	.aresetn(s01_axi_aresetn),
	.start(start),
	.last(last_out_pel),
	.wr(out_pel_push),
	.wren(wren_mem_3),
	.en(en_out_pel),
	.full(out_pel_full),
	.done(done_out_pel)
);

counter #(			
	.SIZE(SIZE_ADDR_3) ) 
i_counter_out_pel (
	.aclk(s01_axi_aclk),
	.aresetn(s01_axi_aresetn),
	.clr(slv_reg0[2]),
	.en(en_out_pel),
	.max(slv_reg3[SIZE_ADDR_3-1:0]),
	.count(count_out_pel),
	.last(last_out_pel)
);

assign address_mem_3 = count_out_pel;
assign rden_mem_3 = 1'b0;

assign done_output = done_out_pel;
assign done = done_input && done_output;

assign tr_start = start;
assign tr_done = done;

// ----------------------------------------------------------------------------

endmodule
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------

