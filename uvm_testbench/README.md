# UVM Testbench Architecture & Design Verification Patterns

---

## Directory Structure

```
uvm_testbench/
├── memory_model/                   # Complete end-to-end UVM Verification Environment
├── analysis_port/                  # 1-to-many broadcasting with analysis ports & exports
├── analysis_port_fifo/             # Decoupling monitors and subscribers via TLM FIFO
├── uvm_config_db/                  # Hierarchical config DB, virtual interfaces & tracing
├── producer_consumer_blocking_port/# TLM 1.0 blocking put/get ports
├── objection/                      # Phase objections and end-of-test mechanisms
├── override/                       # Factory type and instance overrides
├── grab_lock_in_seq/               # Sequencer arbitration (grab() vs. lock())
├── simple_coverage/                # Coverage subscriber embedded in a UVM environment
├── statistics_dut/                 # Full testbench verifying a streaming arithmetic DUT
├── synchronous_adder/              # Monitor & scoreboard implementation for an adder
└── leetsilicon_scenario_based/     # Advanced out-of-order scoreboard & split driver
```

---