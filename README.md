SPI Master-Slave Communication System using SystemVerilog
Overview

Designed and implemented an 8-bit SPI Master-Slave Communication System using SystemVerilog with full-duplex data transfer. The design was simulated using Icarus Verilog, verified with GTKWave, synthesized using Yosys, and implemented through a SKY130 RTL-to-GDSII flow using LibreLane.

Features
8-bit SPI Master and Slave
Full-duplex communication
Master-to-Slave and Slave-to-Master data transfer
RTL simulation and waveform verification
Yosys RTL synthesis
SKY130 RTL-to-GDSII implementation
Static Timing Analysis, DRC and LVS verification
Simulation Result
Master TX Data = a5
Slave TX Data  = 3c
Master RX Data = 3c
Slave RX Data  = a5

MASTER RX TEST: PASS
SLAVE RX TEST: PASS
RTL Synthesis

Yosys was used for RTL synthesis and design verification.

Found and reported 0 problems.
RTL-to-GDSII Flow
SystemVerilog RTL → RTL Simulation → Yosys Synthesis
→ Floorplanning → Placement → CTS → Routing
→ STA → DRC → LVS → GDSII
Physical Design Results
Antenna : PASS
LVS     : PASS
DRC     : PASS
Tools Used

SystemVerilog, Icarus Verilog, GTKWave, Yosys, LibreLane, OpenROAD, SKY130A PDK, KLayout.

Project Structure
SPI_RTL_GDS/
├── rtl/
├── tb/
├── sim/
└── README.md
Author

Rahul D G
Electronics and Communication Engineering
