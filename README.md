# RISC-V Single-Cycle Processor

A 32-bit **RISC-V (RV32I) single-cycle CPU** implemented in SystemVerilog, built as part of hands-on digital design training covering gate-level to behavioral modeling of processors.

## 🧠 Overview

This project implements a single-cycle datapath and control unit for the RV32I base integer instruction set, where every instruction completes in exactly one clock cycle.

## ⚙️ Architecture

- **Program Counter (PC)** with next-PC logic
- **Instruction Memory**
- **Register File** (32 x 32-bit registers)
- **ALU** with support for arithmetic, logic, and comparison operations
- **Immediate Generator** (I, S, B, U, J type immediates)
- **Data Memory**
- **Control Unit** (main decoder + ALU decoder)

## 📂 Repository Structure

```
├── rtl/            # SystemVerilog design files
│   ├── pc.sv
│   ├── alu.sv
│   ├── regfile.sv
│   ├── controller.sv
│   ├── datapath.sv
│   └── top.sv
├── tb/             # Testbench files
│   └── top_tb.sv
├── sim/            # Simulation waveforms / screenshots
└── README.md
```

## ▶️ How to Simulate

Using **ModelSim**:
```bash
vlog rtl/*.sv tb/*.sv
vsim -c top_tb -do "run -all"
```

Using **Icarus Verilog + GTKWave**:
```bash
iverilog -g2012 -o sim_out rtl/*.sv tb/top_tb.sv
vvp sim_out
gtkwave dump.vcd
```

## ✅ Supported Instructions

Base RV32I instructions including `add`, `sub`, `and`, `or`, `xor`, `slt`, `lw`, `sw`, `beq`, `bne`, `jal`, `jalr`, `lui`, `auipc`, and I-type/immediate variants.

## 📊 Verification

Functionality verified via testbench-driven simulation, with waveform analysis in GTKWave to confirm correct register writes, memory access, and branch/jump behavior across a range of test programs.

## 🔮 Future Work

- Extend to a **pipelined** version with hazard detection and forwarding (see: [pipelined RISC-V processor repo](https://github.com/EngrIrfan017/5-stage-risc-v-pipelined-processor.git))
- Add support for M-extension (multiply/divide)

---
*Part of an ongoing series of RISC-V CPU design projects — built to strengthen computer architecture and RTL design fundamentals.*
