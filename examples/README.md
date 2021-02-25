# Examples
In this page, some examples involving monitoring systems built using JOINTER, together with step-by-step instructions to recreate them, are provided.<br />
Each folder contains an example and associated README file.

Examples are briefly described in the following:

1. **monitor_ARM_processor** : this example shows how to monitor the execution of applications running on a dual-core ARM Cortex A9 processor on Zynq7000 SoC, through a monitoring system built on the FPGA-side of the chip. In particular, the monitor extracts specific points in the SW, associating a timestamp to them, and write its results on a dedicated on-chip RAM memory.

2. **monitor_MDC_based_coprocessors**: this example shows how to monitor the execution of HW-tasks executed on a coprocessor developed using the MDC tool, implemented on FPGA. The monitor is built on the same FPGA of the coprocessor, and it allows the extraction of three types of monitoring information: (i) the number of written bytes on the coprocessor, (ii) the latency of the coprocessing activity, and (iii) the number of transaction of custom signals extracted from the computation area of the coprocessor. A GUI is provided to configure the monitor in order to extract only the interested monitoring information.

3. **monitor_het_syst**: this example shows how to monitor the execution of applications running on a heterogeneous platform composed of a dual-core ARM Cortex A9 processor and a coprocessor performing the Sobel/Roberts (depending on some inputs) edge-detection, targeting the Zynq7000 SoC. The monitor is built on the FPGA-side of the chip, and it extracts the same monitoring information of example at point 1) for the processor, and at point 2) for the coprocessor.
