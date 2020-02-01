# Getting started with AIPHS on Leon3 based targets

## Overview
This getting started will allow to use the AIPHS generated monitoring systems on a Leon3 based target, physically implemented on FPGA, obtaining a working prototype on real silicon.

We selected a Leon3 processor based target since is a soft-processor (i.e., that can be customized in its hardware configuration) for which the RTL code is available under a permissive open-source license. Information about the processor can be downloaded at the following link: https://www.gaisler.com/index.php/downloads/leongrlib. Over this benefit, there is the fact that it is provided within a library, called GRLIB, where there are projects that target different existing development FPGA boards, allowing a rapid prototyping on real silicon.
So we here consider an FPGA implementation as getting started.

As FPGA target, we consider a Xilinx Artix-7 FPGA (https://www.xilinx.com/products/silicon-devices/fpga/artix-7.html), soldered on a low-cost Digilent Nexys4 DDR development board (https://store.digilentinc.com/nexys-4-ddr-artix-7-fpga-trainer-board-recommended-for-ece-curriculum/).

These choices are not limiting, since the same flow can be applied also to other processors, with their synthesis tools.

Follow these steps as getting started:
- Download the GRLIB library at the following link (https://www.gaisler.com/products/grlib/grlib-gpl-2019.4-b4246.tar.gz) and extract its content on your Ubuntu Desktop.
- Open a terminal inside it and set the Vivado 2017.4 environment variables by sourcing the settings64.sh script inside the Vivado installation folder.
- Go in the folder, using terminal, where there is the project associated with the Digilent Nexys4 DDR board. The folder is designs/leon3-digilent-nexys4ddr.
- Type make clean && make distclean to clean the folder metadata.
- Copy the files TOBEADDED
- Type make xconfig to configure the system based on Leon3.
- Type make vivado to launch the synthesis: it will take around 20 minutes to complete, depending on system configuration.
- Connect the board to the computer, set the jumper configuration for JTAG programming and power-on.
- Type make vivado-prog-fpga to download the generated bitstream, containing the hardware, to the FPGA. This will connect the FPGA components as set in your configuration.
- Download the bare-metal cross-compiler (BCC) for Leon3 processor from the following link: https://www.gaisler.com/anonftp/bcc2/bin/ 
- Extract it within /opt folder of your Ubuntu system.
- Having the Eclipse C/C++ installed in your PC, set the environment to cross-compile Leon3 applications following the instructions at the following link: https://www.gaisler.com/eclipse/qsg_sw_ide.pdf 
- Cross-compile the application contained within TOBEADDED
- Download the GRMON debugger (evaluation versione) for connecting to the target at the following link: https://www.gaisler.com/index.php/downloads/debug-tools
- Extract it within the /opt folder and add the GRMON executable to the PATH of your Ubuntu system.
- Launch GRMON and connect to the target with the command "grmon -digilent".
- When connected, download the executable within the target memory using the command "load name_executable.elf".
- Open a terminal emulator from your PC and connect to the board, setting the baudrate at 38400 bpd. 
- Execute the application using the command "run": you will obtain ID and execution time printed on the UART output, collected by the monitoring system.


