/*****************************************************************************
*  Filename:          mm_accelerator.c
*  Description:       Memory-Mapped Accelerator Driver
*  Date:              2019/12/06 08:45:57 (by Multi-Dataflow Composer - Platform Composer)
*****************************************************************************/

#include "mm_accelerator.h"

int mm_accelerator_roberts(
	// port out_pel
	int size_out_pel, int* data_out_pel,
	// port in_pel
	int size_in_pel, int* data_in_pel,
	// port in_size
	int size_in_size, int* data_in_size
	) {
	
	volatile int* config = (int*) XPAR_MM_ACCELERATOR_0_CFG_BASEADDR;

	// configure I/O
	*(config + 1) = size_in_size - 1;
	*(config + 3) = size_out_pel - 1;
	*(config + 2) = size_in_pel - 1;
	
	// send data port in_size
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x04>>2)) = 0x00000002; // verify idle
	//*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x00>>2)) = 0x00001000;	// irq en (optional)
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x18>>2)) = (int) data_in_size; // src
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x20>>2)) = XPAR_MM_ACCELERATOR_0_MEM_BASEADDR + MM_ACCELERATOR_MEM_1_OFFSET; // dst
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x28>>2)) = size_in_size*4; // size [B]
	while((*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x04>>2)) & 0x2) != 0x2);
	// send data port in_pel
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x04>>2)) = 0x00000002; // verify idle
	//*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x00>>2)) = 0x00001000;	// irq en (optional)
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x18>>2)) = (int) data_in_pel; // src
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x20>>2)) = XPAR_MM_ACCELERATOR_0_MEM_BASEADDR + MM_ACCELERATOR_MEM_2_OFFSET; // dst
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x28>>2)) = size_in_pel*4; // size [B]
	while((*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x04>>2)) & 0x2) != 0x2);
	
	// start execution (check matching ID
	*(config) = 0x2000001;
	
	// wait for completion
	while( ((*(config)) & 0x4) != 0x4 );
			
	// receive data port out_pel
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x04>>2)) = 0x00000002; // verify idle
	//*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x00>>2)) = 0x00001000;	// irq en (optional)
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x18>>2)) = XPAR_MM_ACCELERATOR_0_MEM_BASEADDR + MM_ACCELERATOR_MEM_3_OFFSET; // src
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x20>>2)) = (int) data_out_pel; // dst
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x28>>2)) = size_out_pel*4; // size [B]
	while((*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x04>>2)) & 0x2) != 0x2);
	
	// stop execution
	//*(config) = 0x0;
	
	return 0;
}

int mm_accelerator_sobel(
	// port out_pel
	int size_out_pel, int* data_out_pel,
	// port in_pel
	int size_in_pel, int* data_in_pel,
	// port in_size
	int size_in_size, int* data_in_size
	) {
	
	volatile int* config = (int*) XPAR_MM_ACCELERATOR_0_CFG_BASEADDR;

	// configure I/O
	*(config + 1) = size_in_size - 1;
	*(config + 3) = size_out_pel - 1;
	*(config + 2) = size_in_pel - 1;
	
	// send data port in_size
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x04>>2)) = 0x00000002; // verify idle
	//*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x00>>2)) = 0x00001000;	// irq en (optional)
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x18>>2)) = (int) data_in_size; // src
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x20>>2)) = XPAR_MM_ACCELERATOR_0_MEM_BASEADDR + MM_ACCELERATOR_MEM_1_OFFSET; // dst
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x28>>2)) = size_in_size*4; // size [B]
	while((*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x04>>2)) & 0x2) != 0x2);
	// send data port in_pel
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x04>>2)) = 0x00000002; // verify idle
	//*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x00>>2)) = 0x00001000;	// irq en (optional)
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x18>>2)) = (int) data_in_pel; // src
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x20>>2)) = XPAR_MM_ACCELERATOR_0_MEM_BASEADDR + MM_ACCELERATOR_MEM_2_OFFSET; // dst
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x28>>2)) = size_in_pel*4; // size [B]
	while((*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x04>>2)) & 0x2) != 0x2);
	
	// start execution (check matching ID
	*(config) = 0x1000001;
	
	// wait for completion
	while( ((*(config)) & 0x4) != 0x4 );
			
	// receive data port out_pel
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x04>>2)) = 0x00000002; // verify idle
	//*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x00>>2)) = 0x00001000;	// irq en (optional)
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x18>>2)) = XPAR_MM_ACCELERATOR_0_MEM_BASEADDR + MM_ACCELERATOR_MEM_3_OFFSET; // src
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x20>>2)) = (int) data_out_pel; // dst
	*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x28>>2)) = size_out_pel*4; // size [B]
	while((*((volatile int*) XPAR_AXI_CDMA_0_BASEADDR + (0x04>>2)) & 0x2) != 0x2);
	
	// stop execution
	//*(config) = 0x0;
	
	return 0;
}
