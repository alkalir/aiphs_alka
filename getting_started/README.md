# Creation of a custom monitoring system

The structure of the HW monitoring systems that can be generated using JOINTER is reported in the following figure:


![Global-Monitor](https://i.imgur.com/xqNAz9M.png)

where there are seven sniffers distributed inside the components of a reference architecture (left-side of the image). Sniffers are controlled in teams: each team of sniffers can be controlled through a Local Monitoring Information Collector (LMIC). Sniffers write their results (monitoring information) to dedicated registers, part of a Data Collector Interface (DCI). In addition, the DCI allows controlling the sniffers through the LMICs and accessing monitoring information through a host. The register space of the DCI is shown in the b) side of the following figure:

![reg-space](https://i.imgur.com/HoEV4TB.png) 

Each LMIC has three assigned register areas inside the DCI register space, as reported in a) side of the figure: a single Control register (to control sniffers connected to that LMIC), a single Init register (to initialize the internal DCAPFs of the sniffers connected to that LMIC), and some Result Registers (where sniffers write their monitoring information). All the LMICs, together with a Data Collector Interface (DCI) and an Interrupt Controller, constitute the Global Monitor. <br />
The right-side of the picture at top of the page shows the internals of each sniffers, composed of an Event Instance Generator (EIG), one or multiple Data Capture and Filters (DCAPFs), and a Dispenser. It is worth noting that each DCAPF can measure a metric. <br />
The internal structure of the DCAPF is reported in the following figure:
![DCAPF](https://i.imgur.com/J52LpmJ.png)


In order to build their custom monitoring system, designers can make usage of IP-cores contained in the libraries in lib/HW folder. It is worth noting that some custom monitoring systems, provided with associated configuration files, are provided in the [examples](https://github.com/alkalir/jointer/tree/master/examples) page.
The following steps offer a way to create a custom monitoring system by putting files in a *work_fol* folder, with reference to the content of the *lib/HW* folder (we suggest using a VHDL-editor with built-in features to check syntax errors, such as Xilinx Vivado or Intel Quartus II editors):<br />

- CREATE THE GLOBAL MONITOR - Start by copying the *GLOBAL_MONITOR/global_mon.vhd* in your *work_fol*;

- CREATE THE SNIFFERS - Identify how many different interconnection points you need to monitor in your project, and create the corresponding number of sniffers. An interconnection point is defined as a point where (i) users require a measure, and (ii) signals evolve in the same clock domain. Supposing to monitor four different interconnection points, create four different sniffers. For example, a sniffer can be contained in a file named *sniff.vhd*. Examples of sniffers are contained in *GLOBAL_MONITOR/LMIC/SNIFFER* folder;

- CREATE THE EIGs - Identify which types of metrics are required, associated to each sniffer. Then, identify the basic event instances associated to each metric: an event instance is defined as the basic element that, by means of an aggregate function, can provide the metrics as a result. The event instance structure is shown in the d) side of the second figure (shown above).
Create an EIG for each sniffer able to output all the required types of event instances identified for that sniffer, starting from interconnection dependent signals. You can find examples of EIGs inside the *GLOBAL_MONITOR/LMIC/SNIFFER/EIG* folder;

- CREATE THE DCAPFs - Identify how many different metrics, associated to each sniffer, are required, and create the corresponding number of DCAPFs. Connect as input to each DCAPF the required event instances (generated at the previous point);

- COMPOSE THE DCAPF INTERNALS - Check which type of metrics are required and compose each DCAPF by introducing the required number of extractors and filters, together with a final aggregator. You can find examples of extractors, filters, and aggregators inside the *GLOBAL_MONITOR/LMIC/SNIFFER/DCAPF folder*;

- COMPOSE THE SNIFFERS - Compose each sniffer with the created DCAPFs and EIGs;

- CREATE THE LMICs - Create LMICs and instantiate the sniffers inside them. You can find examples of LMICs inside the *GLOBAL_MONITOR/LMIC* folder;

- CREATE THE DCI- Create a DCI module (e.g., inside a *dci.vhd* file) and decide how to store monitoring information from LMICs and how to make them available for the host. In addition, how to receive control and initialization commands from the host is also decided here. You can find examples of DCI inside the *GLOBAL_MONITOR/DCI* folder. DCI are provided to interact with hosts through AXI4, AXI4-Lite, APB, and AHB buses. 
In case the monitoring information are made available through an external memory (i.e., they need to be written in a master fashion), a module inside the DCI can be added. An example is provided in *GLOBAL_MONITOR/DCI/bram_writer.vhd*;

- COMPOSE THE GLOBAL MONITOR - Open your *global_mon.vhd* and instantiate the DCI and the LMICs;

- CONNECT THE GLOBAL MONITOR - Connect the global monitor to the host and to the monitored interconnections.

# APIs
The APIs to use the generated monitoring systems are contained in lib/SW folder. <br />
