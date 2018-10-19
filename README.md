# AdaptIve Profiling Hw Sub-system (AIPHS)

## Overview

AIPHS, acronym of Adaptive Profiling HW Sub-system, is basically conceived to support designers on the development of On-Chip Monitoring Systems (OCMSs) able to satisfy given Monitorability Requirements, namely requirements about possibility to observe the behaviour of a system with the goal of collecting metrics (e.g. related to execution time), without inserting SW overhead. It is a flexible framework that targets SoCs implemented on Field Programmable Gate Arrays (FPGAs), or on Integrated Circuits (ICs) integrating some reconfigurable logics.

## Installation Instructions

TODO

## WEBSITE

TBD

## DOWNLOAD

Official Git repository: https://alkalir@bitbucket.org/alkalir/aiphs.git

## INSTALLATION

1. Copy and paste the AIPHS folder in the working directory of your VHDL project
2. Insert the component declaration in the VHDL module where the monitoring system is connected to
3. Build the whole system using an FPGA synthesis tool

## SYSTEM REQUIREMENTS

For using Xilinx FPGAs, Xilinx ISE Design suite or Xilinx Vivado Design Suite software.

For using Intel FPGAs, Intel Quartus software.

## RELEASE NOTES

Latest Release: 1.0.0

## SUPPORT

email: giacomo.valente@univaq.it 

## Getting started guidelines

TODO

## EXAMPLES

There are examples related to LEON3. 

## FOLDERS

aiphs

	VHDL source files related to monitoring system

parsing

	python source files related to parsing activity toward CTF format.
	dev folder contains files related to development activities.
	aiphs.py is the file that, starting from a log file composed of ID and timestamps, converts it in a trace following CTF format.

