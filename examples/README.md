# Examples

## Prerequisites to run the examples
- Python
- PIP Package Manager
- Some dedicated Python libraries: move to folder with the file *requirements.txt* and type:
`pip install -r requirements.txt`
- Xilinx Vivado Design Suite (Webpack edition is enough to run the proposed examples)


## Example 1 - Monitor of a custom multiplier coprocessor developed with the MDC tool #

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



The final monitoring system is provided to users as ready-to-use. By exploiting the customization capabilities provided by JOINTER, we provide a GUI-configuration that allows the configuration of the monitoring system, at design-time, in order to implement only the required sniffers inside the final scheme. We also provide scripts to automatically build the system and to connect the monitor to the MDC-based coprocessor and host.

The three sniffers work with the following limitations:<br />

- the transaction level sniffer can count from 1 to 1 MB of data;

- the task level sniffer, that has a time-monitor configured with a counter 64-bits wide, can monitor a latency of up to 4.5e15 clock cycles that, for a clock period equal to 10 ns, represents a maximum latency of 52 days for the coprocessor;

- the operation level sniffer has a structure that can be customized through the GUI-configuration.

The monitoring of two MDC-based coprocessors is described in the following. 

### Custom multiplications
In the custom multiplications example, you will start from an application that is able to multiply the input values. Specifically, after receiving 48 numbers as input, the application performs the multiplication of the first 16 numbers, the second 16 numbers, and the third 16 numbers.<br />
This application, that can be executed in software, is a good candidate for acceleration, since it is parallelizable. Therefore, a coprocessor has been developed using MDC, whose output files are reported in getting_started/MDC_outputs/custom_multiplications folder. The output files contains the HDL source files describing the coprocessor: in addition, MDC produces two TCL scripts that automatically generate a Vivado project with the coprocessor connected to a dual-core ARM processor of the Zynq7000 SoC. Notice that the MDC outputs are provided targeting two different Zynq7000 development boards: Arty-Z720 and Zedboard. 

Follows the steps below to reproduce the example and use the monitor for coprocessors:<br />
1. Clone the repository
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


### Monitor of Sobel/Roberts accelerator developed with the MDC tool

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



## Example 2 - Monitor applications executed on MicroBlaze processor #
**TODO: to report example against Lee**

## Example 3 - Monitor applications running on ARM Cortex A9 of Zynq7000 #
Open the configuration file config.vhd inside unifying/monitor_for_all/new_monitor_order/project_1/hdl_srcs and set AXI_sniffer_en = 1.

Follow the steps below: <br />
1. Clone the repository <br />
2. Create a Vivado project and set your preferred board. Here we consider the Zedboard. <br />
3. Create a new block design. <br />
4. Add the ARM Cortex A9 in the block design and select the Block Automation. Here we need only an UART connection to print out the results of the monitoring system.<br />
5. Add the folder contained in unifying/monitor_for_all inside the IP repository: an IP core will be automatically identified by the tool.<br />
6. Add one instance of the global monitor IP core.<br />
7. Select Run Connection Automation: the global monitor will be connected, through its slave port and an AXI4Lite bus, to the AXI GP port of the ARM Cortex A9.<br />
8. Add a block memory generator IP core, double click on it and configure it as True Dual port RAM.<br />
9. Add an AXI BRAM controller IP core, double click on it and configure it with only one BRAM interface and with a data width of 32 bit.<br />
10. Double click on the AXI interconnect and add a second master interface to connect the AXI BRAM controller. Manually draw a connection between the AXI interconnect and the AXI BRAM controller slave port.<br />
11. Connect the BRAM Port A of the AXI BRAM Controller to the Port B of the Block memory generator.<br />
12. Enlarge the Port A of the Block Memory Generator to access the buses part of that interface. <br />
13. Connect the din_ram of the global_monitor (GM) with the dina of the Block memory Generator (BMG).<br />
14. Connect the wea_ram of the GM with the wea of the BMG.<br />
15. Connect the rsta_ram of the GM with the rsta of the BMG. <br />
16. Connect the ena_ram of the GM with the ena of the BMG.<br />
17. Add an instance of Constant IP core and configure it with a width of 18 bit and a value of 0.<br />
18. Add an instance of Concat IP core.<br />
19. Connect the constant output to the In1 input of Concat.<br />
20. Connect the addr_ram of GM to the In0 input of Concat.<br />
21. Connect the dout of Concat to addra input of BMG.<br />
22. Run Connect Automation and accept all the proposed automations: at the end, all the clocks and resets are properly connected.<br />
23. Connect the FCLK0 output of the ARM Cortex A9 to clka input of GM.<br />
24. Go to Address Tab and auto-assign addresses for unmapped slaves. <br />
25. Generate the output products and generate the bitstream. <br />
26. Export the hardware to XSDK and open the workspace.<br />
27. Create a new bare-metal empty application and copy the source files inside examples/monitor_arm_processor<br />
28. Program the FPGA <br />
29. Open a terminal emulator and set the USB port where the board is connected to 115200/8/N/1.<br />
30. Execute the application.<br />

# Documentation

## Register-based control of the monitoring system #
**TODO: spiegare organizzazione a registri**

## APIs #
**TODO: spiegare APIs**


# ESECUZIONE #
La directory di lavoro è [source](./project_folder).</br> 
Prima di eseguire lo script occorre risolvere le dipendenze (richiede pip):</br>
- pip install -r requirements.txt</br>

Dopodiché si può seguire lo script (richiede python 2 o 3)t:</br>
- python3 script.py</br>

# TODO #

Legend: (P) means that we need it to obtain paper results. (F) means that we need it for Fitoptivis. </br>

- [ ] (P) to test bare-metal APIs to mask register accesses </br>
- [ ] to debug the 1st level monitor while working in Sobel/Roberts example </br>
- [ ] to debug the 1st level monitor while working in Toy example, when setting number of DMA bursts higher than 16
- [ ] to connect a DMA to a generic developed hardware with the monitoring system </br>
- [ ] to develop a Linux driver and to link the above bare-metal APIs </br>
- [ ] to </br>
