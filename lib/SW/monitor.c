#include "monitor.h"

// internal functions

void jointer_initialize(unsigned int *base_mon, unsigned int low_range,
		unsigned int high_range) {
	*(base_mon) = *(base_mon) | INIT_AXI_SNIFF; // (control = 010000) init mode for sniffer AXI
	// *(base_mon) = *(base_mon) | RST_CMD; // reset monitor
	// *(base_mon) = *(base_mon) & REMOVE_RST_CMD; //remove reset
	*(base_mon + 2) = low_range; // set location displacement to be monitored to 0x24
	// so indicating that we must write to (base_mon+9)
	// to produce a timestamp

	*(base_mon + 2) = high_range; // set also the other register to the same value
}

void jointer_run(unsigned int *base_mon) {
	*(base_mon) = *(base_mon) | NORMAL_AXI_SNIFF | RUN_CMD; // (control = 100000) set AXI sniffer in normal mode
//    *(base_mon) = *(base_mon) | RUN_CMD; // run monitor
}

void jointer_print_reg(unsigned int *base_mon) {
	xil_printf("Monitor reg values \n\r");
	xil_printf("slv_reg3 = %x\n\r", *(base_mon + 3));
	xil_printf("slv_reg4 = %x\n\r", *(base_mon + 4));
	xil_printf("slv_reg5 = %x\n\r", *(base_mon + 5));
	xil_printf("slv_reg6 = %x\n\r", *(base_mon + 6));
	xil_printf("\n\r");
	xil_printf("\n\r");
}

void jointer_print_reg_ram(unsigned int *base_mon, unsigned int *base_mem) {
	int i;

	xil_printf("BRAM values \n\r");
	for (i = 0; i < N; i++) {
		xil_printf("trace %d up is %x  \n\r", i, *(base_mem + 2 * i));
		if (i == 0)
			xil_printf("trace %d up is %x  \n\r", i, *(base_mem + 1));
		else
			xil_printf("trace %d down is %x  \n\r", i, *(base_mem + 2 * i - 1));
	}
	xil_printf("Monitor reg values \n\r");
	xil_printf("slv_reg3 = %x\n\r", *(base_mon + 3));
	xil_printf("slv_reg4 = %x\n\r", *(base_mon + 4));
	xil_printf("slv_reg5 = %x\n\r", *(base_mon + 5));
	xil_printf("slv_reg6 = %x\n\r", *(base_mon + 6));
	xil_printf("\n\r");
	xil_printf("\n\r");
}

void jointer_stop(unsigned int *base_mon) {
	*(base_mon) = *(base_mon) & STOP_ALL_CMD;
}
