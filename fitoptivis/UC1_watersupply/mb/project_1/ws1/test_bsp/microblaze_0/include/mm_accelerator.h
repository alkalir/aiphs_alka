/*****************************************************************************
*  Filename:          mm_accelerator.h
*  Description:       Memory-Mapped Accelerator Driver Header
*  Date:              2018/11/08 13:25:28 (by Multi-Dataflow Composer - Platform Composer)
*****************************************************************************/

#ifndef MM_ACCELERATOR_H
#define MM_ACCELERATOR_H

/***************************** Include Files *******************************/		
#include "xparameters.h"

/************************** Constant Definitions ***************************/
// #define XPAR_MM_ACCELERATOR_0_CFG_BASEADDR 0x44A00000
// #define XPAR_MM_ACCELERATOR_0_MEM_BASEADDR 0x76000000
// dout_2 local memory offset
#define MM_ACCELERATOR_MEM_2_OFFSET 0x400
// dout_1 local memory offset
#define MM_ACCELERATOR_MEM_3_OFFSET 0x800
// din local memory offset
#define MM_ACCELERATOR_MEM_1_OFFSET 0x0
// dout_0 local memory offset
#define MM_ACCELERATOR_MEM_4_OFFSET 0xc00

/************************* Functions Definitions ***************************/


int mm_accelerator_no_parallel(
	// port dout_0
	int size_dout_0, int* data_dout_0,
	// port dout_1
	int size_dout_1, int* data_dout_1,
	// port dout_2
	int size_dout_2, int* data_dout_2,
	// port din
	int size_din, int* data_din
);

int mm_accelerator_d0_parallel(
	// port dout_0
	int size_dout_0, int* data_dout_0,
	// port dout_1
	int size_dout_1, int* data_dout_1,
	// port dout_2
	int size_dout_2, int* data_dout_2,
	// port din
	int size_din, int* data_din
);


#endif /** MM_ACCELERATOR_H */
