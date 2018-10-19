# AdaptIve Profiling Hw Sub-system (AIPHS)

## Overview
AIPHS, acronym of Adaptive Profiling HW Sub-system, is basically conceived to support designers on the development of On-Chip Monitoring Systems (OCMSs) able to satisfy given Monitorability Requirements, namely requirements about possibility to observe the behaviour of a system with the goal of collecting metrics (e.g. related to execution time). It is a flexible framework that targets both SoCs implemented on Field Programmable Gate Arrays (FPGAs) and on Integrated Circuits integrating some reconfigurable logics.
AIPHS is a library of elements that, starting from some monitorability requirements and a description of the architecture, automatically offers a monitoring system that performs required measurements.

There are different planned steps related to AIPHS development, listed in the following:
- baseline/initial version
	- Distributed hardware monitoring system for targets implemented on FPGAs;
	- Run-time generation of logs for WCET analysis;
	- Runtime generation of logs for performance measurements on targets with multi-core processors, running bare-metal and Linux based applications;
- intermediate version
	- Generalization of the concept among monitoring infrastructures by defining a general reference architecture that can be adapted to different applications;
- final version
	- Development of a methodology to suggest the best monitoring mechanisms to be used in a given system, depending on data of interest and constraints to be satisfied;

The current development activities provide features related to baseline/initial version. In particular:
- The produced monitoring systems are described in VHDL;
- The monitoring systems can be strongly customized acting directly on VHDL code. There is an example adaptation to provide logs for WCET analysis with Rapitime tool (https://www.rapitasystems.com/products/rapitime), partially done during CRAFTERS european project (https://artemis-ia.eu/project/36-crafters.html).
- The monitoring system can act both on bare-metal application and Linux-based ones.
- The monitoring system can be controlled both by bare-metal applications and Linux-based ones: for the latter, a character device driver is provided.

## Installation Instructions
In order to install the monitoring system, the following actions can be performed:
- to obtain the Register Transfer Level (RTL) description of the system to be monitored. It is a system described in an RTL language (e.g., VHDL, Verilog, System Verilog);
- to clone the repository;
- to copy and paste the VHDL source files into the project folder containing the RTL description of the system under monitoring; - to connect the top-level entity of the monitoring system to the following two parts:
	- the first part to be connected to interconnections to be monitored;
	- the second part to be connected to control signals that will control/collect results from the monitoring system;
- to simulate and to implement the system using an FPGA synthesis tool;
- to write programs that control/collect results from the monitoring system using provided APIs.

## WEBSITE
TBD

## DOWNLOAD
Official Git repository: https://github.com/alkalir/aiphs_alka.git

## SYSTEM REQUIREMENTS
System requirements depend on the type of FPGA used. Specifically:
- for using Xilinx FPGAs, use Xilinx ISE Design suite or Xilinx Vivado Design Suite software;
- for using Intel FPGAs, use Intel Quartus software.

## RELEASE NOTES
Latest Release: 1.0.0

## SUPPORT
email: giacomo.valente@univaq.it 

## Getting started guidelines
TBD

## EXAMPLES
TBD

## FOLDERS

aiphs
- VHDL source files related to monitoring system

parsing: python source files related to parsing activity toward CTF format.
- dev folder contains files related to development activities.
- aiphs.py is the file that, starting from a log file composed of ID and timestamps, converts it in a trace following CTF format.

