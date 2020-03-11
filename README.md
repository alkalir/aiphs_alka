# AdaptIve Profiling Hw Sub-system (AIPHS)

## Overview
AIPHS, acronym of Adaptive Profiling HW Sub-system, is developed in the context of Megamart2 project and it is basically conceived to support designers on the development of On-Chip Monitoring Systems (OCMSs) able to satisfy given Monitorability Requirements. These type of requirements are related to the possibility to observe the behaviour of a system with the goal of collecting metrics (e.g., related to execution time). AIPHS is a flexible framework that targets both SoCs implemented on Field Programmable Gate Arrays (FPGAs) and on Integrated Circuits integrating some reconfigurable logics.
AIPHS is a library of elements that, starting from some monitorability requirements and a description of the architecture, automatically offers a monitoring system that performs required measurements.

AIPHS is able to monitor hardware targets for which the Register-Transfer-Level source code is available. The current supported processor is the Leon3 soft-core, available at Cobham Gaisler website (https://www.gaisler.com/index.php/downloads/leongrlib).
The final monitoring systems can be strongly customized acting directly on VHDL code. There is an example adaptation to provide logs for WCET analysis with Rapitime tool (https://www.rapitasystems.com/products/rapitime).
The monitoring system can monitor both bare-metal application and Linux-based ones. Moreover, it can be controlled both by bare-metal applications and Linux-based ones.

## Installation Instructions
In order to install the monitoring system, the following actions can be performed:
- to obtain the RTL source code of the hardware system to be monitored;
- to import the source code indicated above in a synthesis tool;
- to clone this repository;
- to copy and paste the VHDL source files into the project folder containing the RTL description of the system under monitoring, within the synthesis tool;
- to customize and to connect the top-level entity of the monitoring system to the following two parts:
	- the first part to be connected to interconnections to be monitored;
	- the second part to be connected to control signals that will control/collect results from the monitoring system;
- to implement the system using the synthesis tool;
- to write programs that control/collect results from the monitoring system using provided APIs.

## DOWNLOAD
Official Git repository: https://github.com/alkalir/aiphs_alka.git

## SYSTEM REQUIREMENTS
System requirements depend on the type of hardware target used. For example:
- for using Xilinx FPGAs, use Xilinx ISE Design suite or Xilinx Vivado Design Suite software;
- for using Intel FPGAs, use Intel Quartus II software.

## RELEASE NOTES
Latest Release: 1.0.2

## SUPPORT
email: giacomo.valente@univaq.it 

## Getting started guidelines
For getting started, we provide some guidelines in the folder "getting_started". There is an example based on Leon3 hardware platform: AIPHS will monitor the execution of a bare-metal application running on the processor.

## FOLDERS

getting_started
- Instructions for getting started with an example of monitoring of bare-metal applications running on Leon3 processor.

aiphs
- VHDL source files related to a hardware monitoring system for Leon3 processor, used in the getting_started.

parsing: python source files related to parsing activity toward CTF format.
- dev folder contains files related to development activities.
- aiphs.py is the file that, starting from a log file composed of ID and timestamps, converts it in a trace following CTF format.

