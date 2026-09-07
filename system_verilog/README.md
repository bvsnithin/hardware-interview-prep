# SystemVerilog Core Language, Concurrency & Simulation Semantics

This directory contains in-depth examples covering the SystemVerilog language specification, simulation event execution regions, inter-process communication, memory copying semantics, and multi-threaded `fork ... join` concurrency puzzles.

---

## Directory Structure

```
system_verilog/
├── fork_join/                 # Concurrency, process synchronization & dependency graphs (12 files)
├── regions/                   # Simulation execution event queue regions & semantics (5 files)
├── copy/                      # Object copying mechanisms (shallow vs. deep copy)
├── modports_clocking_blocks/  # Race-free testbench-DUT interface connections
└── *.sv                       # Core language concepts (arrays, casting, mailboxes, static/automatic)
```

---

## 1. Core Language Mechanisms (Root Files)

| File | Concepts & Interview Questions |
| :--- | :--- |
| [arrays.sv](arrays.sv) | Comprehensive tutorial on SystemVerilog array types: Fixed-size arrays, Dynamic arrays (`new[]`, `delete()`), Associative arrays (hash-map based, `exists()`, `first()`, `next()`, `delete()`), and Queues (`push_front`, `push_back`, `pop_front`, `pop_back`, bounded vs. unbounded). Array locator and reduction methods (`find`, `find_index`, `min`, `max`, `sum`). |
| [casting.sv](casting.sv) | **Static vs. Dynamic Casting**: Static cast (`type'(expression)`) vs. `$cast(dest, source)` dynamic downcasting in class inheritance hierarchies. Explains runtime type checking and handling `$cast` return status (0 on failure, 1 on success). |
| [functions_in_sv.sv](functions_in_sv.sv) | Pass-by-value vs. pass-by-reference (`ref`), `const ref` arguments, default values, void functions, and returning values/structures. |
| [iterate_associative_array.sv](iterate_associative_array.sv) | Iterating through associative arrays using `first()`, `next()`, and `do ... while` traversal loops where keys are strings or sparse integers. |
| [mailbox.sv](mailbox.sv) | Inter-process communication using SystemVerilog `mailbox`. Covers bounded vs. unbounded mailboxes, blocking methods (`put()`, `get()`, `peek()`), and non-blocking methods (`try_put()`, `try_get()`, `try_peek()`). |
| [static_vs_automatic.sv](static_vs_automatic.sv) | **Static vs. Automatic Lifetimes**: Critical interview topic explaining default static behavior in Verilog modules vs. automatic variables in classes and re-entrant tasks/functions. Demonstrates recursive functions and variable retention across task invocations. |

---

## 2. Multi-Threading & Concurrency ([fork_join/](fork_join/))

Understanding SystemVerilog thread spawning, joining rules, and process control is critical for testbench architecture.

| File | Concurrency Challenge / Question |
| :--- | :--- |
| [fork_join/automatic_fork_join.sv](fork_join/automatic_fork_join.sv) | **Loop Variable Binding Bug**: Explains the classic bug where a `for` loop spawns threads with `fork .. join_none`. Without an `automatic` copy inside the loop, all threads sample the loop index after it has finished incrementing. |
| [fork_join/multithreading.sv](fork_join/multithreading.sv) | Spawning 10 parallel threads inside a `fork .. join` block and tracking process lifetimes. |
| [fork_join/multithreading_1.sv](fork_join/multithreading_1.sv) | **Controlled Dependency**: Four processes ($A, B, C, D$). Process $C$ must start only after Process $A$ finishes, while $B$ and $D$ run independently in parallel. |
| [fork_join/multithreading_2.sv](fork_join/multithreading_2.sv) | Process synchronization using events and semaphores across concurrent threads. |
| [fork_join/fork_join_any_using_fork_join_none.sv](fork_join/fork_join_any_using_fork_join_none.sv) | **Brainteaser**: Implement the semantics of `fork .. join_any` using only `fork .. join_none` and synchronization primitives (events/mailboxes). |
| [fork_join/fork_join_none_using_fork_join_any.sv](fork_join/fork_join_none_using_fork_join_any.sv) | **Brainteaser**: Implement `fork .. join_none` behavior using `fork .. join_any`. |
| [fork_join/fork_join_using_fork_join_none.sv](fork_join/fork_join_using_fork_join_none.sv) | **Brainteaser**: Implement strict `fork .. join` (wait for all threads) using only `fork .. join_none`. |
| [fork_join/join_any_2.sv](fork_join/join_any_2.sv) | Demonstrates `join_any` followed by `disable fork` to kill remaining unfinished child threads once the fastest thread completes. |
| [fork_join/scenario_1.sv](fork_join/scenario_1.sv) | Analysis of process lifetime and automatic vs. static variables within nested fork-join blocks. |
| [fork_join/scenario_2.sv](fork_join/scenario_2.sv) | **4-out-of-5 Barrier**: 5 parallel tasks run; as soon as **any 4** tasks finish, terminate the 5th task immediately and proceed. |
| [fork_join/synchronization_challenge.sv](fork_join/synchronization_challenge.sv) | **Custom Barrier Sync**: Reusable synchronization barrier where $N$ independent worker threads rendezvous at a barrier before any can proceed to the next stage. |
| [fork_join/parallel_dependency_graph.sv](fork_join/parallel_dependency_graph.sv) | Complex DAG (Directed Acyclic Graph) of task dependencies executed concurrently with minimum overall simulation wall time. |

---

## 3. Simulation Event Execution Regions ([regions/](regions/))

The IEEE 1800 SystemVerilog simulation event queue divided into Preponed, Active, Inactive, NBA, Observed, Reactive, and Postponed regions:

| File | Concept & Interview Question |
| :--- | :--- |
| [regions/regions.sv](regions/regions.sv) | Comprehensive breakdown of the SystemVerilog Stratified Event Queue (IEEE 1800): Preponed, Active/Inactive/NBA (Design), Observed (Assertions), Reactive/Re-Inactive/Re-NBA (Testbench/Program), Postponed (Sampling/Strobes). |
| [regions/active_inactive.sv](regions/active_inactive.sv) | Difference between **Active region** (blocking assignments `=`, continuous assignments) and **Inactive region** (`#0` procedural delays). Explains why `#0` is bad practice and causes non-determinism. |
| [regions/nba.sv](regions/nba.sv) | **Non-blocking Assignment (NBA) Region**: How `<=` assignments are evaluated in Active and updated in NBA to prevent race conditions between registers. |
| [regions/print_statements.sv](regions/print_statements.sv) | Differences in execution regions for print statements: `$display` (Active region), `$strobe` (Postponed region, after all assignments settle), and `$monitor` (Postponed, triggered on signal changes). |
| [regions/assertions.sv](regions/assertions.sv) | Immediate assertions (executed in Active region) vs. Concurrent assertions (sampled in Preponed region, evaluated in Observed region, action block executed in Reactive region). |

---

## 4. Object Copying ([copy/](copy/))

| File | Concept |
| :--- | :--- |
| [copy/shallow_vs_deep_copy.sv](copy/shallow_vs_deep_copy.sv) | **Shallow Copy vs. Deep Copy**:<br>- **Shallow Copy (`dst = new src;`)**: Copies all primitive fields, but for nested object handles, it only copies the pointer/handle (both instances share the same child object).<br>- **Deep Copy**: Custom `copy()` or `clone()` method that recursively allocates new instances for all nested objects and copies values, providing complete memory isolation. |

---

## 5. Modports & Clocking Blocks ([modports_clocking_blocks/](modports_clocking_blocks/))

| File | Concept |
| :--- | :--- |
| [modports_clocking_blocks/modports_clocking_blocks.sv](modports_clocking_blocks/modports_clocking_blocks.sv) | **Race-Free Testbench Interfacing**:<br>- **Clocking Blocks**: Specifies input skew (`input #setup_time`) and output skew (`output #hold_time`) to eliminate setup/hold races between testbench driving and DUT sampling.<br>- **Modports**: Defines directional access restrictions (`input`, `output`, `inout`) on interface signals for DUT vs. Testbench. |

---

## How to Simulate

Compile and simulate any SystemVerilog example using Cadence Xcelium:
```bash
xrun -sv <path_to_file>.sv
```
