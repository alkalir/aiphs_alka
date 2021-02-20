# Monitor MDC-based coprocessors

## Prerequisites to run the example
- Python
- PIP Package Manager
- Some dedicated Python libraries: move to folder with the file *requirements.txt* and type:
`pip install -r requirements.txt`
- Xilinx Vivado Design Suite (Webpack edition is enough to run the proposed examples)

## Introduction
In this example, we are going to monitor an MDC-based coprocessor (i.e., developed using the MDC tool, where MDC stands for [Multi-Dataflow Composer](https://github.com/mdc-suite/mdc)), part of a system where there is also a dual-core ARM Cortex A9. Both the coprocessor and processor share an external DRAM. The coprocessor is able to automatically read data from DRAM, by using a DMA, and to write back results in DRAM, notifying the processor. <br />

The goal of the monitoring process is to measure the following metrics:<br />

- number of written bytes from ARM to coprocessor;

- latency of the coprocessing;

- number of transactions of selected signals happening inside the coprocessor. The selected signals are made available on a trace port part of the coprocessor.




We build three sniffers using the JOINTER library, to be connected and extract occurrences from three points of the coprocessor:<br />

- Transaction Level: a point inside the coprocessor where there is the management of data exchange with the rest of the system (e.g., the bus interface controller);

- Task Level: a point inside the coprocessor where there is the management of start, stop, and I/O data of the executed HW-Task;

- Operation Level: a point where the coprocessor performs the computations associated to the HW-task.


Each sniffer is customized to be connected at the levels of interest. In particular:<br />

- The sniffer at transaction level is able to count only the writes within a range of memory addresses. The range is programmable at runtime.

- The sniffer at task level is able to measure the time between the start and the end of the HW-task execution, without considering data access time.

- The sniffer is able to count the number of transaction of custom signals extracted from the computation area of the coprocessor.


An LMIC controls the three sniffers, and all of them write their results directly to registers part of a DCI. The DCI also interacts through an AXI4-lite bus with a host, represented by the ARM Cortex A9 in our example. <br />



The final monitoring system is provided to users as ready-to-use. By exploiting the customization capabilities provided by JOINTER, we provide a GUI-configuration that allows the configuration of the monitoring system, at design-time, in order to implement only the required sniffers inside the final scheme. We also provide scripts to automatically build the system and to connect the monitor to the MDC-based coprocessor and host.<br />
In this way, users can develop their own MDC-based coprocessor, and automatically add the monitoring levels required, selecting among the available metrics reported above.

The three sniffers work with the following limitations:<br />

- the transaction level sniffer can count from 1 to 1 MB of data;

- the task level sniffer, that has a time-monitor configured with a counter 64-bits wide, can monitor a latency of up to 4.5e15 clock cycles that, for a clock period equal to 10 ns, represents a maximum latency of 52 days for the coprocessor;

- the operation level sniffer has a structure that can be customized through the GUI-configuration.

The monitoring of two MDC-based coprocessors is described in the following. 

## Example 1 - Monitor of a custom multiplier coprocessor #
In the custom multiplications example, you will start from an application that is able to multiply the input values. 
Specifically, after receiving 48 numbers as input, the application performs the multiplication of the first 16 numbers, the second 16 numbers, and the third 16 numbers.<br />
This application, that can be executed in software, is a good candidate for acceleration, since it is parallelizable. Therefore, a coprocessor has been developed using MDC, whose output files are reported in examples/monitor_MDC_based_coprocessors/custom_multiplications folder.
Inside the folder, one can find files for targeting either Zedboard or ArtyZ7 board. It is worth noting that the provided HDL descriptions are target independent, and other boards can be used. The scripts work only for systems implemented on Zynq7000 SoC.
The output MDC files contain the HDL source files describing the coprocessor: in addition, MDC produces two TCL scripts that automatically generate a Vivado project with the coprocessor connected to a dual-core ARM processor of the Zynq7000 SoC. 

Follows the steps below to reproduce the example and use the monitor for coprocessors on custom multiplier (where we suppose to target the Zedboard):<br />
1. clone the repository;
2. copy the MDC output files from examples/monitor_MDC_based_coprocessors/custom_multiplications/zedboard to examples/monitor_MDC_based_coprocessors/jointer_MDC/project folder.
3. open Vivado in project mode;
4. by using the TCL shell, move to examples/monitor_MDC_based_coprocessors/jointer_MDC/project folder. Here you will find two folders: scripts and mm_accelerator;
5. by using the top-level menu, execute the TCL script called generate_ip.tcl inside the scripts folder;
6. by using the top-level menu, execute the TCL script called generate_top.tcl inside the scripts folder;
7. at this point, you will get a Vivado project with a block design where the ARM processor shares an external DRAM with the MDC-based multiplier;
8. close the Vivado project and move with a shell inside examples/monitor_MDC_based_coprocessors/jointer_MDC;
9. execute the Python script (named script.py) inside that folder. This will open the window to customize the monitor to be introduced within the project. Be aware to select the Custom Multiplications example. At the end, press Generate;
10. a Vivado project containing the coprocessor connected to the dual-core ARM Cortex A9, together with the monitoring system, will be opened;
11. The final folder structure in examples/monitor_MDC_based_coprocessors/jointer_MDC highlights the presence of a project_monitored inside, that contains the new generated project;
12. generate the bitstream and exports the hardware to Xilinx Vitis or XSDK (depending on the Vivado version installed on your PC);
13. in order to change the monitoring configuration, just delete the project_monitored folder and re-run the Python script;


Altro:

2. Execute the script script.py with Python inside the SEL_FOL. The first time you will get an error: however, you will get the downloaded files to populate your folder, necessary to executed JOINTER.
3. Two application examples are provided together with the tool: custom multiplications and sobel/roberts. Both applications are provided with their C source code, and both represent good candidate to be executed on a coprocessor, since they are highly parallelizable. In this regard, for both applications also a coprocessor is provided, developed using MDC. The two applications, with the provided content, can be found inside the getting_started repository folder



To use JOINTER in this example, perform the following steps
1. open a shell and set the Vivado environment variables<br />
2. copy the files associated to the board of your interest within the SEL_FOL: for example, supposing that we want to implement a monitoring system for the custom multiplications coprocessor for the zedboard, we would copy the files contained in getting_started/SW_HW/custom_multiplications/MDC_outputs/zedboard/ within SEL_FOL.
3. copy the file create_MDC_proj.tcl within SEL_FOL
4. create a new folder called project and copy the two folders mm_accelerator and scripts within the project folder
5. navigate with the shell to SEL_FOL and execute the TCL script:<br />
`vivado -mode batch -source create_MDC_proj.tcl`<br />
This will generate a Vivado project that makes use of the MDC coprocessor connected to the dual-core ARM Cortex A9 inside the Zynq7000 SoC [3].
6. Execute the script script.py with Python inside the SEL_FOL. This will open the window to customize the sniffer to be introduced within the project. At the end, press Generate.
7. A Vivado project containing the coprocessor connected to the dual-core ARM Cortex A9, together with the monitoring system, will be opened.
8. The final folder structure highlights the presence of a project_monitored inside, that contains the new generated project.
9. Generate the bitstream and exports the hardware to Xilinx Vitis or XSDK (depending on the Vivado version installed on your PC).


### Monitor of Sobel/Roberts coprocessor

The monitored events come out from the adapter_CAPH in the following way:

The monitored events come out from the adapter_CAPH in the following way:
count_event0 <= acc_line_buffer_0_real_size_rd;
count_event1 <= acc_fifo_big_line_buffer_0_in_pel_wr;
count_event2 <= acc_fifo_big_line_buffer_0_real_size_wr;
count_event3 <= acc_line_buffer_0_in_pel_rd;

by providing as input to the user interface the following vectors:<br /> 
`number of events = 4`<br />
`number of relative registers = 1,1,2,3`<br />
`size of relative counters = 10,10,10,10`<br />

and executing the sobel in hardware, we obtain (be sure that inside the Sobel HW API there is *(config) = 0x2000001, and in Roberts HW API there is *(config) = 0x1000001)<br />
`terzo livello e0e00100 = ‭11100000111000000000000100000000‬`<br />
`terzo livello e0e00100 = 11100000111000000000000100000000‬`<br />
`terzo livello e0e00000 = ‭11100000111000000000000000000000‬`<br />



