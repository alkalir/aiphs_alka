# Creation of a custom monitoring system
The libraries to build a custom monitoring system are provided in the lib/HW folder.<br />
The structure of the monitoring system is reported in the following figure:


![Global-Monitor](https://i.imgur.com/xqNAz9M.png)

where there are seven sniffers distributed inside the components of a reference architecture (left-side of the image). Sniffers are controlled in teams: each team of sniffers can be controlled by a Local Monitoring Information Collector (LMIC). All the LMICs, together with a Data Collector Interface (DCI) and an Interrupt Controller, constitute the Global Monitor. <br />
The right-side of the picture shows the internal of each sniffers, composed of an Event Instance Generator (EIG), one or multiple Data Capture and Filters (DCAPFs), and a Dispenser. It is worth noting that each DCAPF can measure a metric. <br />
The internal structure of the DCAPF is reported in the following figure:
![DCAPF](https://i.imgur.com/J52LpmJ.png)


# APIs
The APIs to use the generated monitoring systems are contained in lib/SW folder. <br />
