# Creation of a custom monitoring system
The libraries to build a custom monitoring system are provided in the lib/HW folder.<br />
The structure of the monitoring system is reported in the following figure:


![Global-Monitor](https://i.imgur.com/xqNAz9M.png)

where there are seven sniffers distributed inside the components of a reference architecture (left-side of the image). Sniffers are controlled in teams: each team of sniffers can be controlled through a Local Monitoring Information Collector (LMIC). Sniffers write their results (monitoring information) to dedicated registers, part of a Data Collector Interface (DCI). In addition, the DCI allows controlling the sniffers through the LMICs and accessing monitoring information through a host. The register space of the DCI is shown in the b) side of the following figure:

![reg-space](https://i.imgur.com/HoEV4TB.png) 

Each LMIC has three assigned register areas inside the DCI register space, as reported in a) side of the figure: a single Control register (to control sniffers connected to that LMIC), a single Init register (to initialize the internal DCAPFs of the sniffers connected to that LMIC), and some Result Registers (where sniffers write their monitoring information). All the LMICs, together with a Data Collector Interface (DCI) and an Interrupt Controller, constitute the Global Monitor. <br />
The right-side of the picture shows the internal of each sniffers, composed of an Event Instance Generator (EIG), one or multiple Data Capture and Filters (DCAPFs), and a Dispenser. It is worth noting that each DCAPF can measure a metric. <br />
The internal structure of the DCAPF is reported in the b) side of the following figure:
![DCAPF](https://i.imgur.com/J52LpmJ.png)


 

# APIs
The APIs to use the generated monitoring systems are contained in lib/SW folder. <br />
