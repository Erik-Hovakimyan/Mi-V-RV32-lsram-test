# Mi-V-RV32-lsram-test
LSRAM test project for Microchip Mi-V RISC-V (discovery-kit) using the Mi-V Soft cpu.

This project is a **simple LSRAM test application** built for a
**Microchip Mi-V RISC-V soft processor** using the **Mi-V Extended Subsystem (ESS)**.

The main goal of this project is to **start an LSRAM test using a button,
measure how long the test takes, and report whether it passed or failed**
using GPIO signals and UART output.

The test timing is measured using the **RISC-V MTIME counter**, so the result
is accurate and independent of software delays.
