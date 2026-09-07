# Hardware Interview Prep

This is a comprehensive repository of RTL design, SystemVerilog constraints, coverage models, and interview preparation materials for hardware design verification and RTL engineering roles.

## Repository Structure

### Folders Overview

#### rtl - Register Transfer Level Designs
Contains foundational RTL implementations

#### constraints - SystemVerilog Constraints & Problems
A collection of SystemVerilog constraint programming exercises for randomization-based verification. 

For detailed list of constraint problems, check the [constraints/README.md](constraints/README.md) file.

#### coverage - Functional Coverage Models
Coverage scenarios

#### assertions - SystemVerilog Assertions
Assertion implementations/scenarios

#### scripting - Basics of Python and Perl 
Nothing major here yet. :')

---

## Getting Started

### Running Simulations

If you are from Texas A&M University, College station and have access to olympus server, execute the setup.bash script to initialize your environment:
```bash
./setup.bash
```

Note: Make sure to run the following Slurm command before executing the bashscript:
```bash
load-csce-616
```

If you don't want X11 forwarding (Case where you are running the terminal from vscode instead of MobaXterm on your windows), make sure to run the following command instead:
```bash
srun \
  --job-name=csce-616 \
  --cpus-per-task=1 \
  --partition=academic \
  --qos=olympus-academic \
  --pty \
  bash -l
```

## Notes
Use xrun command for Xcelium simulations and refer to each folder's documentation for specific details.

## Where to Start From

Depending on the role you are targeting and the time you have before your interview, follow these curated study paths:

### Track 1: Design Verification (DV) Engineer Roadmap

If you are interviewing for **ASIC/SoC Verification**, **DV Engineer**, or **Emulation** roles:

1. **Phase 1: SystemVerilog Core & Concurrency**
   - Start at [system_verilog/README.md](system_verilog/README.md).
   - Master the IEEE 1800 **Stratified Event Queue** (`system_verilog/regions/`) to understand Active, NBA, and Observed regions.
   - Practice the concurrency brainteasers in `system_verilog/fork_join/` (e.g., `automatic_fork_join.sv`, `parallel_dependency_graph.sv`, and `scenario_2.sv`).
   - Review data structures: dynamic arrays, associative arrays, and queues in `arrays.sv`.

2. **Phase 2: Constrained-Random Verification (CRV)**
   - Move to [constraints/README.md](constraints/README.md).
   - Start with real interview questions in `constraints/intel_questions/` and `constraints/scenarios/` (TLB eviction, FIFO stimulus, virtual address alignment).
   - Progress to tricky puzzles: `eight_queens_constraint.sv`, `sudoku.sv`, `implement_randc.sv`, and `unique_2d_array.sv`.

3. **Phase 3: SVA Assertions & Functional Coverage**
   - Study Assertions in SystemVerilog
   - Study Coverage: Understand covergroups, transition bins, cross coverage, and illegal vs. ignore bins.

4. **Phase 4: UVM Architecture & Testbench Design**
   - Master top interview topics:
     - `uvm_config_db/` (virtual interface propagation and debugging).
     - `analysis_port/` and `analysis_port_fifo/` (1-to-many broadcasting vs. decoupled FIFO consumption).
     - `objection/` (phase objection mechanism and drain times).
     - `override/` (factory type overrides).
     - `leetsilicon_scenario_based/` (out-of-order scoreboard matching and split-beat drivers).

5. **Phase 5: EDA Automation & Coding Rounds**
   - Review [scripting](scripting/) for simulation log parsing and regex error extraction.
   - Review [leetcode/README.md](leetcode/README.md), focusing primarily on the **Bit Manipulation** section.

---

### Track 2: RTL & Digital IC Design Engineer Roadmap

If you are interviewing for **RTL Design**, **Digital ASIC Engineer**, or **FPGA Design** roles:

1. **Phase 1: Foundational Combinational & Arithmetic Logic**

2. **Phase 2: Clock Dividers & Frequency Generators**

3. **Phase 3: FSMs & Sequential Control Logic**

4. **Phase 4: Clock Domain Crossing (CDC)**

5. **Phase 5: Arbitration & Buffering (FIFO)**

6. **Phase 6: Hardware-Oriented Coding Rounds**

