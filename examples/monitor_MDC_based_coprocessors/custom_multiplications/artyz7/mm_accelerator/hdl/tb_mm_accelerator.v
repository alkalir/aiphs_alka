`timescale 1ns / 1ps
// ----------------------------------------------------------------------------
//
// Multi-Dataflow Composer tool - Platform Composer
// TIL Test Bench module 
// Date: 2018/11/08 13:25:28
//
// ----------------------------------------------------------------------------	

// ----------------------------------------------------------------------------
// Module Interface
// ----------------------------------------------------------------------------
module tb_copr;
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// Module Parameters
// ----------------------------------------------------------------------------
parameter SIZEID = 8;				// size of Kernel ID signal
parameter SIZEADDRESS = 12;			// size of the local memory address signal
parameter SIZECOUNT = 12;			// size of the size counters
parameter SIZEPORT = 2;	// bits needed to codify the number of ports
parameter SIZEDATA = 32;	// size of the data signal
parameter SIZEBURST = 8;			// size of the burst counter
parameter SIZESIGNAL = 1; 			// size of the control signals
parameter FIFO_DEPTH = 4; 				//	FIFO depth
parameter f_ptr_width = 5; 			//	because depth =16 + OVERFLOW
parameter f_half_full_value = 8;	//
parameter f_almost_full_value = 14;	//
parameter f_almost_empty_value = 2;	//
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// Module Signals
// ----------------------------------------------------------------------------
// Input Reg(s)
reg clk;
reg rst;
reg [SIZEDATA-1 : 0] 		datain;		// local memory - data in
reg [SIZEADDRESS-1 : 0] 	addressrd;	// local memory - read address
reg [SIZEADDRESS-1 : 0] 	addresswr; 	// local memory - write address
reg 						enablerd;	// local memory - enable read port
reg							enablewr;   // local memory - enable write port
reg 						write;      // local memory - write enable
reg [SIZEID-1 : 0] 			kernelIDin; // kernel ID
reg 						kernelIDen;
reg [SIZEDATA-1 : 0] 		confin_1;
reg 						en_1;
reg [SIZEDATA-1 : 0] 		confin_2;
reg 						en_2;
reg [SIZEDATA-1 : 0] 		confin_0;
reg 						en_0;
reg [SIZEDATA-1 : 0] 		confin_3;
reg 						en_3;
// Output Wire(s)
wire [SIZEDATA-1 : 0] 		dataout;
wire [SIZEID-1 : 0] 		kernelIDout;
//wire 						finish;

integer i;
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// Unit Under Test Instantiation
// ----------------------------------------------------------------------------
coprocessor #(
	.SIZEID(SIZEID),
	.SIZEADDRESS(SIZEADDRESS),
	.SIZECOUNT(SIZECOUNT),
	.SIZEPORT(SIZEPORT),
	.SIZEDATA(SIZEDATA),
	.SIZEBURST(SIZEBURST),
	.SIZESIGNAL(SIZESIGNAL),
	.FIFO_DEPTH(FIFO_DEPTH)//,
	//.f_ptr_width(f_ptr_width)//,
	//.f_half_full_value(f_ptr_width), 
	//.f_almost_full_value(f_almost_full_value),
	//.f_almost_empty_value(f_almost_empty_value) 
	)
uut (
	.clk(clk),
	.rst(rst),
	.datain(datain),
	.addressrd(addressrd),
	.addresswr(addresswr),
	.enablerd(enablerd),
	.enablewr(enablewr),
	.write(write),
	.kernelIDin(kernelIDin),
	.kernelIDen(kernelIDen),
	.kernelIDout(kernelIDout),
	.confin_1(confin_1),
	.en_1(en_1),
	.confin_2(confin_2),
	.en_2(en_2),
	.confin_0(confin_0),
	.en_0(en_0),
	.confin_3(confin_3),
	.en_3(en_3),
	.dataout(dataout)
	//.finish(finish)
);
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// Body
// ----------------------------------------------------------------------------

// Clock Always
always 
	#5 clk = ~clk;

// Input(s) Setting
initial begin

	// Initialize Input(s)
	clk = 0;
	rst = 0;
	datain = 0;
	addressrd = 0;
	addresswr = 0;
	enablerd = 0;
	enablewr = 0;
	write = 0;
	kernelIDin = 0;
	kernelIDen = 0;
	confin_1 = 0;
	en_1 = 0;
	confin_2 = 0;
	en_2 = 0;
	confin_0 = 0;
	en_0 = 0;
	confin_3 = 0;
	en_3 = 0;
	// Reset System
	#12	rst = 1;
	#10	rst = 0;
	
	// Write Data into Memory
	#10	enablewr = 1;	// enable writing port
		write = 1;		// enable write
		for(i=0;i<4;i=i+1)
		begin
		datain = 0+i;		// written data 0
		addresswr = 0+i;	// write address -1
		#10;
		end
		enablewr = 0; 	// disable writing port
		write = 0;		// disable write

	// Setting Configuration Registers
	#10
		confin_1 = (1<<(SIZEADDRESS+SIZECOUNT))	// burst port 1
										| (4<<SIZEADDRESS)			// size port 1
										| 1 *10;	// baseaddr port 1
		en_1 = 1;
		confin_2 = (1<<(SIZEADDRESS+SIZECOUNT))	// burst port 2
										| (4<<SIZEADDRESS)			// size port 2
										| 2 *10;	// baseaddr port 2
		en_2 = 1;
		confin_0 = (1<<(SIZEADDRESS+SIZECOUNT))	// burst port 0
										| (4<<SIZEADDRESS)			// size port 0
										| 0 *10;	// baseaddr port 0
		en_0 = 1;
		confin_3 = (1<<(SIZEADDRESS+SIZECOUNT))	// burst port 3
										| (4<<SIZEADDRESS)			// size port 3
										| 3 *10;	// baseaddr port 3
		en_3 = 1;
	#10
		en_1 = 0;
		en_2 = 0;
		en_0 = 0;
		en_3 = 0;
	
	// Setting Kernel ID (Start Computation)
	#10	kernelIDin = 1;	// kernel ID 1
		kernelIDen = 1;
	#10 kernelIDen = 0;

	#200 $stop;
end
// ----------------------------------------------------------------------------

endmodule		
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
