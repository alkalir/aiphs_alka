# Example 3 - Monitor applications running on ARM Cortex A9 of Zynq7000 #
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
