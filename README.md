# Jointer - Joining Flexible Monitors with Heterogeneous Architectures

This is the repository of JOINTER, a tool to build monitoring systems that aims at offering to the user the support on building custom monitors to runtime observe SW and HW-tasks execution implemented on FPGA.
To have a general view and explanation of JOINTER and its parts, please refer to [1], [2], [3], [4], and [5]. <br />
With the proposed tool, designers are able to build their own monitor by using the elements part of some libraries. In this repository, these libraries are made available in form of VHDL-described IP-cores, together with some configuration files to customize the final monitor. <br />
Furthermore, some examples of monitors developed using the proposed tool are proposed: in each example, the configuration files to customize the monitor are reported, together with a brief explanation of the choices. In addition, the steps to work with the example are provided, in order to offer a way to reproduce the tests. <br />

Information on how to create a custom monitoring system using JOINTER and its internal structure can be found in the [getting started](https://github.com/alkalir/jointer/tree/master/getting_started) page.

Examples involving monitoring systems built using JOINTER, together with step-by-step instructions to recreate them, can be found in the [examples](https://github.com/alkalir/jointer/tree/master/examples) page.





# References

[1] G. Valente, T. Fanni, C. Sau, T. Di Mascio, L. Pomante, F. Palumbo, (accepted, in press). A composable monitoring system for heterogeneous embedded platforms. ACM Transactions on Embedded Computing Systems. 

[2] G. Valente, T. Fanni, C. Sau and F. Di Battista, "Layering the monitoring action for improved flexibility and overhead control: work-in-progress," 2020 International Conference on Hardware/Software Codesign and System Synthesis (CODES+ISSS), Singapore, 2020, pp. 18-20, doi: 10.1109/CODESISSS51650.2020.9244018.

[3] A. Moro, F. Federici, G. Valente, L. Pomante, M. Faccio and V. Muttillo, "Hardware performance sniffers for embedded systems profiling," 2015 12th International Workshop on Intelligent Solutions in Embedded Systems (WISES), Ancona, 2015, pp. 29-34.

[4] G. Valente et al., "A Flexible Profiling Sub-System for Reconfigurable Logic Architectures," 2016 24th Euromicro International Conference on Parallel, Distributed, and Network-Based Processing (PDP), Heraklion, 2016, pp. 373-376, doi: 10.1109/PDP.2016.86.

[5] V. Muttillo, G. Valente, L. Pomante, H. Posadas, J. Merino and E. Villar, "Run-time Monitoring and Trace Analysis Methodology for Component-based Embedded Systems Design Flow," 2020 23rd Euromicro Conference on Digital System Design (DSD), Kranj, Slovenia, 2020, pp. 117-125, doi: 10.1109/DSD51259.2020.00029.

# Acknowledgements
Jointer has been developed in the context of [MegaM@RT2](https://megamart2-ecsel.eu/), and is currently under active development in the context of [FitOptiVis](https://fitoptivis.eu/), [Fractal](https://fractal-project.eu/), and [Comp4Drones](https://www.comp4drones.eu/) European projects.

