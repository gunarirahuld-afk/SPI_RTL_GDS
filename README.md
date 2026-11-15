# SPI Master–Slave, RTL to GDSII (SKY130)

An 8-bit full-duplex SPI master and slave in SystemVerilog (mode 0: sample on the rising edge, shift on the falling edge, MSB first), verified in simulation and taken through the SKY130 RTL-to-GDSII flow with LibreLane.

## Features

- Parameterised SCLK divider (`CLK_DIV`)
- Active-low chip select, full-duplex exchange in one 8-bit frame
- `busy` / `done` handshake on the master, `done` on the slave
- Top level `spi_master_slave_top` wires master and slave together for simulation and hardening

## Files

| File | Description |
|---|---|
| `spi_master.sv`, `spi_slave.sv`, `spi_master_slave_top.sv` | RTL |
| `tb_spi_master_slave.sv` | Testbench (master sends A5, slave sends 3C) |
| `spi_synth.v` | Yosys netlist |
| `spi_schematic.png`, `spi_schematic_clean.png` | RTL schematics |
| `config.yaml` | LibreLane configuration |

## Run it

```bash
iverilog -g2012 -o spi_sim spi_master.sv spi_slave.sv spi_master_slave_top.sv tb_spi_master_slave.sv
vvp spi_sim
gtkwave spi.vcd
```

Expected output:

```text
Master TX Data = a5
Slave TX Data  = 3c
Master RX Data = 3c
Slave RX Data  = a5
MASTER RX TEST: PASS
SLAVE RX TEST: PASS
```

## RTL to GDSII

```bash
librelane config.yaml
```

Flow: synthesis → floorplan → placement → CTS → routing → STA → DRC → LVS → GDSII, on the `sky130A` PDK at a 10 ns clock.

| Check | Result |
|---|---|
| DRC | PASS |
| LVS | PASS |
| Antenna | PASS |

![Layout](Screenshot%202026-09-16%20000852.png)

## Tools

SystemVerilog, Icarus Verilog, GTKWave, Yosys, LibreLane, OpenROAD, SKY130A PDK, KLayout

## Author

**Rahul Dayanand Gunari**, B.E. Electronics & Communication, Sri Venkateshwara College of Engineering, Bengaluru
[GitHub](https://github.com/gunarirahuld-afk) · gunarirahuld@gmail.com
