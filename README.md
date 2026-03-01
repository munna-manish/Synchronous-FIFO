# Parametric Synchronous FIFO

A robust, synthesizable Synchronous FIFO (First-In-First-Out) buffer implemented in Verilog. This module is designed to act as a reliable data bridge between different hardware blocks operating on the same clock domain.

## Features
- **Scalable Architecture:** Uses Verilog parameters for `WIDTH` and `DEPTH`.
- **Smart Pointer Sizing:** Employs `$clog2` to automatically calculate the minimum required address width.
- **Status Flags:** Provides `fifo_full` and `fifo_empty` signals for hardware handshaking.
- **Memory-Mapped:** Continuous assignment of `data_out` ensures the "head" of the FIFO is always visible.

## Specifications
- **Default Depth:** 16 slots
- **Default Width:** 8 bits
- **Reset Type:** Synchronous

## Verification Results
The design was verified using a testbench that stress-tests the FIFO by:
1. Performing a full reset to clear uninitialized (X) states.
2. Writing data until the `fifo_full` flag is asserted.
3. Reading data until the `fifo_empty` flag is asserted.

<img width="1919" height="1016" alt="Screenshot 2026-03-01 134254" src="https://github.com/user-attachments/assets/02db7468-926e-491c-9c1f-c2946614b5dc" />


## How to Run
1. Ensure you have **Icarus Verilog** and **GTKWave** installed.
2. Compile the design:
   `iverilog -o fifo_sim sync_fifo.v testbench.v`
3. Run simulation:
   `vvp fifo_sim`
4. View waveforms:
   `gtkwave fifo_waves.vcd`
