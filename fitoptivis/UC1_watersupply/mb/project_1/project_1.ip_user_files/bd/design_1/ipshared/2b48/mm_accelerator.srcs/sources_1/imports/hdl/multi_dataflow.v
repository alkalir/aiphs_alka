// ----------------------------------------------------------------------------
//
// Multi-Dataflow Composer tool - Platform Composer
// Multi-Dataflow Network module 
// Date: 2018/11/08 13:25:28
//
// ----------------------------------------------------------------------------

module multi_dataflow (
	input [31 : 0] din_data,
	input din_wr,
	output din_full,
	
	output  [63 : 0] dout_2_data,
	output  dout_2_wr,
	input  dout_2_full,
	output  [63 : 0] dout_1_data,
	output  dout_1_wr,
	input  dout_1_full,
	output  [63 : 0] dout_0_data,
	output  dout_0_wr,
	input  dout_0_full,
	
	input [7:0] ID,
	input clr,
	output [31:0 ]count_data,
	output [31:0] count_full,
			
	input clock,
	input reset,
	output wire tr_mac_16_0_in_data_rd,
	output wire tr_mac_16_1_in_data_rd,
	output wire tr_mac_16_2_in_data_rd
);	

// internal signals
// ----------------------------------------------------------------------------
// Sboxes Config Wire(s)
wire [5 : 0] sel;
		


// Actors Wire(s)
	
// actor forward_0
wire [31 : 0] fifo_big_forward_0_in_data_data;
wire fifo_big_forward_0_in_data_wr;
wire fifo_big_forward_0_in_data_full;
wire [31 : 0] forward_0_in_data_data;
wire forward_0_in_data_rd;
wire forward_0_in_data_empty;
wire [31 : 0] forward_0_out_data_0_data;
wire forward_0_out_data_0_wr;
wire forward_0_out_data_0_full;
wire [31 : 0] forward_0_out_data_1_data;
wire forward_0_out_data_1_wr;
wire forward_0_out_data_1_full;
wire [31 : 0] forward_0_out_data_2_data;
wire forward_0_out_data_2_wr;
wire forward_0_out_data_2_full;
	
// actor splitter_0
wire [31 : 0] fifo_big_splitter_0_in_data_data;
wire fifo_big_splitter_0_in_data_wr;
wire fifo_big_splitter_0_in_data_full;
wire [31 : 0] splitter_0_in_data_data;
wire splitter_0_in_data_rd;
wire splitter_0_in_data_empty;
wire [31 : 0] splitter_0_out_data_0_data;
wire splitter_0_out_data_0_wr;
wire splitter_0_out_data_0_full;
wire [31 : 0] splitter_0_out_data_1_data;
wire splitter_0_out_data_1_wr;
wire splitter_0_out_data_1_full;
	
// actor mac_8_0
wire [31 : 0] fifo_big_mac_8_0_in_data_data;
wire fifo_big_mac_8_0_in_data_wr;
wire fifo_big_mac_8_0_in_data_full;
wire [31 : 0] mac_8_0_in_data_data;
wire mac_8_0_in_data_rd;
wire mac_8_0_in_data_empty;
wire [63 : 0] mac_8_0_out_data_data;
wire mac_8_0_out_data_wr;
wire mac_8_0_out_data_full;
	
// actor mac_8_1
wire [31 : 0] fifo_big_mac_8_1_in_data_data;
wire fifo_big_mac_8_1_in_data_wr;
wire fifo_big_mac_8_1_in_data_full;
wire [31 : 0] mac_8_1_in_data_data;
wire mac_8_1_in_data_rd;
wire mac_8_1_in_data_empty;
wire [63 : 0] mac_8_1_out_data_data;
wire mac_8_1_out_data_wr;
wire mac_8_1_out_data_full;
	
// actor adder_0
wire [63 : 0] fifo_big_adder_0_in_data_0_data;
wire fifo_big_adder_0_in_data_0_wr;
wire fifo_big_adder_0_in_data_0_full;
wire [63 : 0] adder_0_in_data_0_data;
wire adder_0_in_data_0_rd;
wire adder_0_in_data_0_empty;
wire [63 : 0] fifo_big_adder_0_in_data_1_data;
wire fifo_big_adder_0_in_data_1_wr;
wire fifo_big_adder_0_in_data_1_full;
wire [63 : 0] adder_0_in_data_1_data;
wire adder_0_in_data_1_rd;
wire adder_0_in_data_1_empty;
wire [63 : 0] adder_0_out_data_data;
wire adder_0_out_data_wr;
wire adder_0_out_data_full;
	
// actor mac_16_0
wire [31 : 0] fifo_big_mac_16_0_in_data_data;
wire fifo_big_mac_16_0_in_data_wr;
wire fifo_big_mac_16_0_in_data_full;
wire [31 : 0] mac_16_0_in_data_data;
wire mac_16_0_in_data_rd;
wire mac_16_0_in_data_empty;
wire [63 : 0] mac_16_0_out_data_data;
wire mac_16_0_out_data_wr;
wire mac_16_0_out_data_full;
	
// actor mac_16_1
wire [31 : 0] fifo_big_mac_16_1_in_data_data;
wire fifo_big_mac_16_1_in_data_wr;
wire fifo_big_mac_16_1_in_data_full;
wire [31 : 0] mac_16_1_in_data_data;
wire mac_16_1_in_data_rd;
wire mac_16_1_in_data_empty;
wire [63 : 0] mac_16_1_out_data_data;
wire mac_16_1_out_data_wr;
wire mac_16_1_out_data_full;
	
// actor mac_16_2
wire [31 : 0] fifo_big_mac_16_2_in_data_data;
wire fifo_big_mac_16_2_in_data_wr;
wire fifo_big_mac_16_2_in_data_full;
wire [31 : 0] mac_16_2_in_data_data;
wire mac_16_2_in_data_rd;
wire mac_16_2_in_data_empty;
wire [63 : 0] mac_16_2_out_data_data;
wire mac_16_2_out_data_wr;
wire mac_16_2_out_data_full;
	
// actor sbox_0
wire [31 : 0] sbox_0_in1_data;
wire sbox_0_in1_wr;
wire sbox_0_in1_full;
wire [31 : 0] sbox_0_out1_data;
wire sbox_0_out1_wr;
wire sbox_0_out1_full;
wire [31 : 0] sbox_0_out2_data;
wire sbox_0_out2_wr;
wire sbox_0_out2_full;
	
// actor sbox_1
wire [31 : 0] sbox_1_in1_data;
wire sbox_1_in1_wr;
wire sbox_1_in1_full;
wire [31 : 0] sbox_1_in2_data;
wire sbox_1_in2_wr;
wire sbox_1_in2_full;
wire [31 : 0] sbox_1_out1_data;
wire sbox_1_out1_wr;
wire sbox_1_out1_full;
	
// actor sbox_2
wire [31 : 0] sbox_2_in1_data;
wire sbox_2_in1_wr;
wire sbox_2_in1_full;
wire [31 : 0] sbox_2_out1_data;
wire sbox_2_out1_wr;
wire sbox_2_out1_full;
wire [31 : 0] sbox_2_out2_data;
wire sbox_2_out2_wr;
wire sbox_2_out2_full;
	
// actor sbox_3
wire [63 : 0] sbox_3_in1_data;
wire sbox_3_in1_wr;
wire sbox_3_in1_full;
wire [63 : 0] sbox_3_out1_data;
wire sbox_3_out1_wr;
wire sbox_3_out1_full;
wire [63 : 0] sbox_3_out2_data;
wire sbox_3_out2_wr;
wire sbox_3_out2_full;
	
// actor sbox_4
wire [63 : 0] sbox_4_in1_data;
wire sbox_4_in1_wr;
wire sbox_4_in1_full;
wire [63 : 0] sbox_4_in2_data;
wire sbox_4_in2_wr;
wire sbox_4_in2_full;
wire [63 : 0] sbox_4_out1_data;
wire sbox_4_out1_wr;
wire sbox_4_out1_full;
	
// actor sbox_5
wire [63 : 0] sbox_5_in1_data;
wire sbox_5_in1_wr;
wire sbox_5_in1_full;
wire [63 : 0] sbox_5_in2_data;
wire sbox_5_in2_wr;
wire sbox_5_in2_full;
wire [63 : 0] sbox_5_out1_data;
wire sbox_5_out1_wr;
wire sbox_5_out1_full;
// ----------------------------------------------------------------------------

// body
// ----------------------------------------------------------------------------
// Network Configurator
configurator config_0 (
	.sel(sel),
	.ID(ID)
);



// fifo_big_forward_0_in_data
fifo_big #(
	.depth(64),
	.size(32)
) fifo_big_forward_0_in_data(
	.datain(fifo_big_forward_0_in_data_data),
	.dataout(forward_0_in_data_data),
	.enr(forward_0_in_data_rd),
	.enw(fifo_big_forward_0_in_data_wr),
	.empty(forward_0_in_data_empty),
	.full(fifo_big_forward_0_in_data_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor forward_0
forward actor_forward_0 (
	// Input Signal(s)
	.in_data(forward_0_in_data_data),
	.in_data_rd(forward_0_in_data_rd),
	.in_data_empty(forward_0_in_data_empty)
	,
	
	// Output Signal(s)
	.out_data_0(forward_0_out_data_0_data),
	.out_data_0_wr(forward_0_out_data_0_wr),
	.out_data_0_full(forward_0_out_data_0_full),
	.out_data_1(forward_0_out_data_1_data),
	.out_data_1_wr(forward_0_out_data_1_wr),
	.out_data_1_full(forward_0_out_data_1_full),
	.out_data_2(forward_0_out_data_2_data),
	.out_data_2_wr(forward_0_out_data_2_wr),
	.out_data_2_full(forward_0_out_data_2_full)
	,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// fifo_big_splitter_0_in_data
fifo_big #(
	.depth(64),
	.size(32)
) fifo_big_splitter_0_in_data(
	.datain(fifo_big_splitter_0_in_data_data),
	.dataout(splitter_0_in_data_data),
	.enr(splitter_0_in_data_rd),
	.enw(fifo_big_splitter_0_in_data_wr),
	.empty(splitter_0_in_data_empty),
	.full(fifo_big_splitter_0_in_data_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor splitter_0
splitter actor_splitter_0 (
	// Input Signal(s)
	.in_data(splitter_0_in_data_data),
	.in_data_rd(splitter_0_in_data_rd),
	.in_data_empty(splitter_0_in_data_empty)
	,
	
	// Output Signal(s)
	.out_data_0(splitter_0_out_data_0_data),
	.out_data_0_wr(splitter_0_out_data_0_wr),
	.out_data_0_full(splitter_0_out_data_0_full),
	.out_data_1(splitter_0_out_data_1_data),
	.out_data_1_wr(splitter_0_out_data_1_wr),
	.out_data_1_full(splitter_0_out_data_1_full)
	,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// fifo_big_mac_8_0_in_data
fifo_big #(
	.depth(64),
	.size(32)
) fifo_big_mac_8_0_in_data(
	.datain(fifo_big_mac_8_0_in_data_data),
	.dataout(mac_8_0_in_data_data),
	.enr(mac_8_0_in_data_rd),
	.enw(fifo_big_mac_8_0_in_data_wr),
	.empty(mac_8_0_in_data_empty),
	.full(fifo_big_mac_8_0_in_data_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor mac_8_0
mac_8 actor_mac_8_0 (
	// Input Signal(s)
	.in_data(mac_8_0_in_data_data),
	.in_data_rd(mac_8_0_in_data_rd),
	.in_data_empty(mac_8_0_in_data_empty)
	,
	
	// Output Signal(s)
	.out_data(mac_8_0_out_data_data),
	.out_data_wr(mac_8_0_out_data_wr),
	.out_data_full(mac_8_0_out_data_full)
	,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// fifo_big_mac_8_1_in_data
fifo_big #(
	.depth(64),
	.size(32)
) fifo_big_mac_8_1_in_data(
	.datain(fifo_big_mac_8_1_in_data_data),
	.dataout(mac_8_1_in_data_data),
	.enr(mac_8_1_in_data_rd),
	.enw(fifo_big_mac_8_1_in_data_wr),
	.empty(mac_8_1_in_data_empty),
	.full(fifo_big_mac_8_1_in_data_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor mac_8_1
mac_8 actor_mac_8_1 (
	// Input Signal(s)
	.in_data(mac_8_1_in_data_data),
	.in_data_rd(mac_8_1_in_data_rd),
	.in_data_empty(mac_8_1_in_data_empty)
	,
	
	// Output Signal(s)
	.out_data(mac_8_1_out_data_data),
	.out_data_wr(mac_8_1_out_data_wr),
	.out_data_full(mac_8_1_out_data_full)
	,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// fifo_big_adder_0_in_data_0
fifo_big #(
	.depth(64),
	.size(64)
) fifo_big_adder_0_in_data_0(
	.datain(fifo_big_adder_0_in_data_0_data),
	.dataout(adder_0_in_data_0_data),
	.enr(adder_0_in_data_0_rd),
	.enw(fifo_big_adder_0_in_data_0_wr),
	.empty(adder_0_in_data_0_empty),
	.full(fifo_big_adder_0_in_data_0_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);
// fifo_big_adder_0_in_data_1
fifo_big #(
	.depth(64),
	.size(64)
) fifo_big_adder_0_in_data_1(
	.datain(fifo_big_adder_0_in_data_1_data),
	.dataout(adder_0_in_data_1_data),
	.enr(adder_0_in_data_1_rd),
	.enw(fifo_big_adder_0_in_data_1_wr),
	.empty(adder_0_in_data_1_empty),
	.full(fifo_big_adder_0_in_data_1_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor adder_0
adder actor_adder_0 (
	// Input Signal(s)
	.in_data_0(adder_0_in_data_0_data),
	.in_data_0_rd(adder_0_in_data_0_rd),
	.in_data_0_empty(adder_0_in_data_0_empty),
	.in_data_1(adder_0_in_data_1_data),
	.in_data_1_rd(adder_0_in_data_1_rd),
	.in_data_1_empty(adder_0_in_data_1_empty)
	,
	
	// Output Signal(s)
	.out_data(adder_0_out_data_data),
	.out_data_wr(adder_0_out_data_wr),
	.out_data_full(adder_0_out_data_full)
	,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// fifo_big_mac_16_0_in_data
fifo_big #(
	.depth(64),
	.size(32)
) fifo_big_mac_16_0_in_data(
	.datain(fifo_big_mac_16_0_in_data_data),
	.dataout(mac_16_0_in_data_data),
	.enr(mac_16_0_in_data_rd),
	.enw(fifo_big_mac_16_0_in_data_wr),
	.empty(mac_16_0_in_data_empty),
	.full(fifo_big_mac_16_0_in_data_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor mac_16_0
mac_16 actor_mac_16_0 (
	// Input Signal(s)
	.in_data(mac_16_0_in_data_data),
	.in_data_rd(mac_16_0_in_data_rd),
	.in_data_empty(mac_16_0_in_data_empty)
	,
	
	// Output Signal(s)
	.out_data(mac_16_0_out_data_data),
	.out_data_wr(mac_16_0_out_data_wr),
	.out_data_full(mac_16_0_out_data_full)
	,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// fifo_big_mac_16_1_in_data
fifo_big #(
	.depth(2),
	.size(32)
) fifo_big_mac_16_1_in_data(
	.datain(fifo_big_mac_16_1_in_data_data),
	.dataout(mac_16_1_in_data_data),
	.enr(mac_16_1_in_data_rd),
	.enw(fifo_big_mac_16_1_in_data_wr),
	.empty(mac_16_1_in_data_empty),
	.full(fifo_big_mac_16_1_in_data_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

reg [31:0] count_data, count_full;

// count data
always@(posedge clock or negedge reset)
 if(!reset)
    count_data <= 0;
  else if(clr)
    count_data <= 0;
  else if(fifo_big_mac_16_1_in_data_wr)
    count_data <= count_data + 1;
    

always@(posedge clock or negedge reset)
 if(!reset)
    count_full <= 0;
  else if(clr)
    count_full <= 0;
  else if(fifo_big_mac_16_1_in_data_full)
    count_full <= count_full + 1;
    
    

// actor mac_16_1
mac_16 actor_mac_16_1 (
	// Input Signal(s)
	.in_data(mac_16_1_in_data_data),
	.in_data_rd(mac_16_1_in_data_rd),
	.in_data_empty(mac_16_1_in_data_empty)
	,
	
	// Output Signal(s)
	.out_data(mac_16_1_out_data_data),
	.out_data_wr(mac_16_1_out_data_wr),
	.out_data_full(mac_16_1_out_data_full)
	,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);


// fifo_big_mac_16_2_in_data
fifo_big #(
	.depth(64),
	.size(32)
) fifo_big_mac_16_2_in_data(
	.datain(fifo_big_mac_16_2_in_data_data),
	.dataout(mac_16_2_in_data_data),
	.enr(mac_16_2_in_data_rd),
	.enw(fifo_big_mac_16_2_in_data_wr),
	.empty(mac_16_2_in_data_empty),
	.full(fifo_big_mac_16_2_in_data_full),
	
	// System Signal(s)
	.clk(clock),
	.rst(reset)
);

// actor mac_16_2
mac_16 actor_mac_16_2 (
	// Input Signal(s)
	.in_data(mac_16_2_in_data_data),
	.in_data_rd(mac_16_2_in_data_rd),
	.in_data_empty(mac_16_2_in_data_empty)
	,
	
	// Output Signal(s)
	.out_data(mac_16_2_out_data_data),
	.out_data_wr(mac_16_2_out_data_wr),
	.out_data_full(mac_16_2_out_data_full)
	,
	
	// System Signal(s)
	.clock(clock),
	.reset(reset)
);



// actor sbox_0
sbox1x2 #(
	.SIZE(32)
)
sbox_0 (
	// Input Signal(s)
	.in1_data(sbox_0_in1_data),
	.in1_wr(sbox_0_in1_wr),
	.in1_full(sbox_0_in1_full),
	
	// Output Signal(s)
	.out1_data(sbox_0_out1_data),
	.out1_wr(sbox_0_out1_wr),
	.out1_full(sbox_0_out1_full),
	.out2_data(sbox_0_out2_data),
	.out2_wr(sbox_0_out2_wr),
	.out2_full(sbox_0_out2_full),
	
	// Selector
	.sel(sel[0])	
);


// actor sbox_1
sbox2x1 #(
	.SIZE(32)
)
sbox_1 (
	// Input Signal(s)
	.in1_data(sbox_1_in1_data),
	.in1_wr(sbox_1_in1_wr),
	.in1_full(sbox_1_in1_full),
	.in2_data(sbox_1_in2_data),
	.in2_wr(sbox_1_in2_wr),
	.in2_full(sbox_1_in2_full),
	
	// Output Signal(s)
	.out1_data(sbox_1_out1_data),
	.out1_wr(sbox_1_out1_wr),
	.out1_full(sbox_1_out1_full),
	
	// Selector
	.sel(sel[1])	
);


// actor sbox_2
sbox1x2 #(
	.SIZE(32)
)
sbox_2 (
	// Input Signal(s)
	.in1_data(sbox_2_in1_data),
	.in1_wr(sbox_2_in1_wr),
	.in1_full(sbox_2_in1_full),
	
	// Output Signal(s)
	.out1_data(sbox_2_out1_data),
	.out1_wr(sbox_2_out1_wr),
	.out1_full(sbox_2_out1_full),
	.out2_data(sbox_2_out2_data),
	.out2_wr(sbox_2_out2_wr),
	.out2_full(sbox_2_out2_full),
	
	// Selector
	.sel(sel[2])	
);


// actor sbox_3
sbox1x2 #(
	.SIZE(64)
)
sbox_3 (
	// Input Signal(s)
	.in1_data(sbox_3_in1_data),
	.in1_wr(sbox_3_in1_wr),
	.in1_full(sbox_3_in1_full),
	
	// Output Signal(s)
	.out1_data(sbox_3_out1_data),
	.out1_wr(sbox_3_out1_wr),
	.out1_full(sbox_3_out1_full),
	.out2_data(sbox_3_out2_data),
	.out2_wr(sbox_3_out2_wr),
	.out2_full(sbox_3_out2_full),
	
	// Selector
	.sel(sel[3])	
);


// actor sbox_4
sbox2x1 #(
	.SIZE(64)
)
sbox_4 (
	// Input Signal(s)
	.in1_data(sbox_4_in1_data),
	.in1_wr(sbox_4_in1_wr),
	.in1_full(sbox_4_in1_full),
	.in2_data(sbox_4_in2_data),
	.in2_wr(sbox_4_in2_wr),
	.in2_full(sbox_4_in2_full),
	
	// Output Signal(s)
	.out1_data(sbox_4_out1_data),
	.out1_wr(sbox_4_out1_wr),
	.out1_full(sbox_4_out1_full),
	
	// Selector
	.sel(sel[4])	
);


// actor sbox_5
sbox2x1 #(
	.SIZE(64)
)
sbox_5 (
	// Input Signal(s)
	.in1_data(sbox_5_in1_data),
	.in1_wr(sbox_5_in1_wr),
	.in1_full(sbox_5_in1_full),
	.in2_data(sbox_5_in2_data),
	.in2_wr(sbox_5_in2_wr),
	.in2_full(sbox_5_in2_full),
	
	// Output Signal(s)
	.out1_data(sbox_5_out1_data),
	.out1_wr(sbox_5_out1_wr),
	.out1_full(sbox_5_out1_full),
	
	// Selector
	.sel(sel[5])	
);

// Module(s) Assignments
assign fifo_big_forward_0_in_data_data = din_data;
assign fifo_big_forward_0_in_data_wr = din_wr;
assign din_full = fifo_big_forward_0_in_data_full;

assign fifo_big_splitter_0_in_data_data = sbox_0_out1_data;
assign fifo_big_splitter_0_in_data_wr = sbox_0_out1_wr;
assign sbox_0_out1_full = fifo_big_splitter_0_in_data_full;

assign fifo_big_mac_16_0_in_data_data = forward_0_out_data_1_data;
assign fifo_big_mac_16_0_in_data_wr = forward_0_out_data_1_wr;
assign forward_0_out_data_1_full = fifo_big_mac_16_0_in_data_full;

assign sbox_1_in1_data = sbox_2_out1_data;
assign sbox_1_in1_wr = sbox_2_out1_wr;
assign sbox_2_out1_full = sbox_1_in1_full;

assign fifo_big_mac_8_0_in_data_data = splitter_0_out_data_0_data;
assign fifo_big_mac_8_0_in_data_wr = splitter_0_out_data_0_wr;
assign splitter_0_out_data_0_full = fifo_big_mac_8_0_in_data_full;

assign fifo_big_mac_8_1_in_data_data = splitter_0_out_data_1_data;
assign fifo_big_mac_8_1_in_data_wr = splitter_0_out_data_1_wr;
assign splitter_0_out_data_1_full = fifo_big_mac_8_1_in_data_full;

assign dout_1_data = mac_16_0_out_data_data;
assign dout_1_wr = mac_16_0_out_data_wr;
assign mac_16_0_out_data_full = dout_1_full;

assign sbox_5_in1_data = sbox_3_out1_data;
assign sbox_5_in1_wr = sbox_3_out1_wr;
assign sbox_3_out1_full = sbox_5_in1_full;

assign fifo_big_adder_0_in_data_0_data = mac_8_0_out_data_data;
assign fifo_big_adder_0_in_data_0_wr = mac_8_0_out_data_wr;
assign mac_8_0_out_data_full = fifo_big_adder_0_in_data_0_full;

assign fifo_big_adder_0_in_data_1_data = mac_8_1_out_data_data;
assign fifo_big_adder_0_in_data_1_wr = mac_8_1_out_data_wr;
assign mac_8_1_out_data_full = fifo_big_adder_0_in_data_1_full;

assign sbox_4_in1_data = adder_0_out_data_data;
assign sbox_4_in1_wr = adder_0_out_data_wr;
assign adder_0_out_data_full = sbox_4_in1_full;

assign sbox_0_in1_data = forward_0_out_data_0_data;
assign sbox_0_in1_wr = forward_0_out_data_0_wr;
assign forward_0_out_data_0_full = sbox_0_in1_full;

assign fifo_big_mac_16_1_in_data_data = sbox_1_out1_data;
assign fifo_big_mac_16_1_in_data_wr = sbox_1_out1_wr;
assign sbox_1_out1_full = fifo_big_mac_16_1_in_data_full;

assign sbox_1_in2_data = sbox_0_out2_data;
assign sbox_1_in2_wr = sbox_0_out2_wr;
assign sbox_0_out2_full = sbox_1_in2_full;

assign sbox_2_in1_data = forward_0_out_data_2_data;
assign sbox_2_in1_wr = forward_0_out_data_2_wr;
assign forward_0_out_data_2_full = sbox_2_in1_full;

assign fifo_big_mac_16_2_in_data_data = sbox_2_out2_data;
assign fifo_big_mac_16_2_in_data_wr = sbox_2_out2_wr;
assign sbox_2_out2_full = fifo_big_mac_16_2_in_data_full;

assign sbox_3_in1_data = mac_16_1_out_data_data;
assign sbox_3_in1_wr = mac_16_1_out_data_wr;
assign mac_16_1_out_data_full = sbox_3_in1_full;

assign dout_0_data = sbox_4_out1_data;
assign dout_0_wr = sbox_4_out1_wr;
assign sbox_4_out1_full = dout_0_full;

assign sbox_4_in2_data = sbox_3_out2_data;
assign sbox_4_in2_wr = sbox_3_out2_wr;
assign sbox_3_out2_full = sbox_4_in2_full;

assign dout_2_data = sbox_5_out1_data;
assign dout_2_wr = sbox_5_out1_wr;
assign sbox_5_out1_full = dout_2_full;

assign sbox_5_in2_data = mac_16_2_out_data_data;
assign sbox_5_in2_wr = mac_16_2_out_data_wr;
assign mac_16_2_out_data_full = sbox_5_in2_full;


//// trace port assignments
assign tr_mac_16_0_in_data_rd = mac_16_0_in_data_rd;
assign tr_mac_16_1_in_data_rd = mac_16_1_in_data_rd;
assign tr_mac_16_2_in_data_rd = mac_16_2_in_data_rd;

endmodule

