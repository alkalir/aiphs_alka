#ifndef MONITOR_H
#define MONITOR_H

#include <stdio.h>
#include "xil_printf.h"

//#define IMPLEMENT_WITH_PRINTF
//#define OTHER_TESTS

#define N 10

#define BASE_MON 0x44A00000
#define BASE_MEM_TRACES 0x40000000

#define RST_CMD 0x00000002
#define RUN_CMD 0x00000001
#define INIT_AXI_SNIFF 0x00000010
#define INIT_AXIFULL_SNIFF 0x00000040
#define RUN_AXIFULL_SNIFF 0x00000080
#define STOP_ALL_CMD 0xFFFFFFFE
#define REMOVE_RST_CMD 0xFFFFFFFD
#define NORMAL_AXI_SNIFF 0x00000020
#define DEBUG_TST_CODE 0x00000040

// internal functions

void jointer_initialize(unsigned int *base_mon, unsigned int low_range,
		unsigned int high_range);
void jointer_run(unsigned int *base_mon);
void jointer_print_reg(unsigned int *base_mon);
void jointer_stop(unsigned int *base_mon);
void jointer_print_reg_ram(unsigned int *base_mon, unsigned int *base_mem);

#endif

