NMOS inverter example

.include "/home/ecelrc/students/agroszewski/lpr/hspice/models/32nm_LP.pm"

*Define Voltage Sources
Vin in gnd DC 1 PULSE(0 1.5 0n 1n 1n 18n 40n)
Vdd dd gnd DC 1.5

*Define load cap
Cg out gnd 250f

*Define mosfet
M1 out in gnd gnd nmos L=32nm W=320nm

*Analysis
.options post
.DC Vin 0 1.5 0.02
.tran .1n 25n

.end