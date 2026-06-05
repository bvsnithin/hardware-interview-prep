#!/bin/bash
export UVMHOME="/opt/coe/cadence/XCELIUM/tools/methodology/UVM/CDNS-1.1d/sv"
source /opt/coe/cadence/XCELIUM/setup.XCELIUM.linux.bash
source /opt/coe/cadence/VMANAGER/setup.VMANAGER.linux.bash
alias imc="/opt/coe/cadence/VMANAGER/bin/imc"
echo Success

# --- RISC-V toolchain ---
export PATH="$HOME/tools/xpack-riscv-none-elf-gcc-15.2.0-1/bin:$PATH"
