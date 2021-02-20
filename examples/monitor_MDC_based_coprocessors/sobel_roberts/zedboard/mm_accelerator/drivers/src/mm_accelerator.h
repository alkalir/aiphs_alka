/*****************************************************************************
*  Filename:          mm_accelerator.h
*  Description:       Memory-Mapped Accelerator Driver Header
*  Date:              2019/12/06 08:45:57 (by Multi-Dataflow Composer - Platform Composer)
*****************************************************************************/

#ifndef MM_ACCELERATOR_H
#define MM_ACCELERATOR_H

/***************************** Include Files *******************************/		
#include "xparameters.h"

/************************** Constant Definitions ***************************/
// in_size local memory offset (size in terms of number of words)
#define MEM_1_SIZE 4
#define MM_ACCELERATOR_MEM_1_OFFSET 0
// out_pel local memory offset (size in terms of number of words)
#define MEM_3_SIZE 1024
#define MM_ACCELERATOR_MEM_3_OFFSET MM_ACCELERATOR_MEM_2_OFFSET + (MEM_2_SIZE<<2)
// in_pel local memory offset (size in terms of number of words)
#define MEM_2_SIZE 2048
#define MM_ACCELERATOR_MEM_2_OFFSET MM_ACCELERATOR_MEM_1_OFFSET + (MEM_1_SIZE<<2)
/************************* Functions Definitions ***************************/


int mm_accelerator_roberts(
	// port out_pel
	int size_out_pel, int* data_out_pel,
	// port in_pel
	int size_in_pel, int* data_in_pel,
	// port in_size
	int size_in_size, int* data_in_size
);

int mm_accelerator_sobel(
	// port out_pel
	int size_out_pel, int* data_out_pel,
	// port in_pel
	int size_in_pel, int* data_in_pel,
	// port in_size
	int size_in_size, int* data_in_size
);


#endif /** MM_ACCELERATOR_H */
