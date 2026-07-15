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
  --partition=adademic \
  --qos=olympus-academic \
  --pty \
  bash -l
```

---

## Notes

I will try to keep this README as updated as possible, but for the most comprehensive and current list of interview questions and problems, please check the individual files in each folder, especially:
- [constraints/README.md](constraints/README.md) - for detailed constraint problems
- Individual .sv files for inline comments and implementation details

Use xrun command for Xcelium simulations and refer to each folder's documentation for specific details.

---
