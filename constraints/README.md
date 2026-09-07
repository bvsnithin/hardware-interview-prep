# SystemVerilog Constraints Interview Problems & Scenarios

SystemVerilog constrained-random verification (CRV) is the cornerstone of modern testbenches. This directory contains **70 interview problems, puzzle solvers, and real-world SoC verification scenarios** covering arrays, matrices, queues, distributions, and protocol rules.

---

## Directory Structure

```
constraints/
├── intel_questions/     # Real interview questions asked by Intel DV teams
├── scenarios/           # Real-world SoC verification scenarios (TLB, FIFO, Crossbar, Virtual Memory)
├── new_questions/       # Advanced puzzles (Latin Square, Parity generators)
├── patterns/            # Periodic sequence & pattern generator constraints
└── *.sv                 # 51 core constraint problems
```

---

## 1. Intel Interview Questions ([intel_questions/](intel_questions/))

Real-world constraint questions from Intel hardware verification interviews:

| File | Problem Statement & Verification Concept |
| :--- | :--- |
| [intel_questions/adjacent_elements_distinct.sv](intel_questions/adjacent_elements_distinct.sv) | Constrain an $M \times M$ square matrix such that no two adjacent elements (horizontal and vertical neighbors) have identical values. |
| [intel_questions/generate_power_of_2.sv](intel_questions/generate_power_of_2.sv) | Generate between 5 and 15 numbers that are strictly powers of two **without using the exponentiation operator `**`**. Solved using bitwise constraints (`$countones(val) == 1`). |
| [intel_questions/identify_power_of_2.sv](intel_questions/identify_power_of_2.sv) | Function and constraint implementation to identify and filter all powers of 2 from a randomized vector of integers. |
| [intel_questions/no_consequtive_7s.sv](intel_questions/no_consequtive_7s.sv) | Generate an integer array where the digit/value 7 never appears in consecutive indices (`array[i] == 7 -> array[i+1] != 7`). |
| [intel_questions/queue_7s.sv](intel_questions/queue_7s.sv) | Constrain a queue of fixed size 15 such that the value 7 appears at least $K$ times but never in adjacent positions. |
| [intel_questions/unique_and_increasing_array.sv](intel_questions/unique_and_increasing_array.sv) | Generate a strictly increasing unique array **without using the `unique` keyword** (`foreach(a[i]) if (i > 0) a[i] > a[i-1]`). |

---

## 2. Real-World SoC Verification Scenarios ([scenarios/](scenarios/))

Practical testbench stimulus generation mimicking real architectural blocks:

| File | Scenario Description |
| :--- | :--- |
| [scenarios/aligned_va_generation.sv](scenarios/aligned_va_generation.sv) | **Naturally Aligned Virtual Addresses**: Generate 64-bit virtual addresses that are strictly aligned to 4KB, 2MB, or 1GB page boundaries based on randomized page size configurations. |
| [scenarios/crossbar_switch_arbiter.sv](scenarios/crossbar_switch_arbiter.sv) | **4x4 Crossbar Switch Contention**: Randomize a $4 \times 4$ request matrix such that no output port is granted to more than one input port simultaneously (one-hot column constraint). |
| [scenarios/fifo_constraint_scenario.sv](scenarios/fifo_constraint_scenario.sv) | **Constrained-Random FIFO Stimulus**: Randomize push/pop sequences with weights that drive the FIFO toward near-full, near-empty, and simultaneous push-and-pop boundary states. |
| [scenarios/legal_tlb_access.sv](scenarios/legal_tlb_access.sv) | **TLB Access Verification**: Constrain TLB requests to legal memory access types (Read, Write, Execute, Prefetch) with privilege level enforcement (User vs. Supervisor). |
| [scenarios/lru_candiate_eviction.sv](scenarios/lru_candiate_eviction.sv) | **8-Way Set-Associative TLB LRU Selection**: Track age counters across ways and constrain stimulus to select candidate lines for eviction based on pseudo-LRU age counter maximums. |
| [scenarios/packet_transactions.sv](scenarios/packet_transactions.sv) | **Weighted Packet Distributions**: 2-bit packet type field constrained using `dist` so Type 0 appears 50% of the time, Type 1 appears 30%, and Types 2/3 share the remaining 20%. |
| [scenarios/tlb_hit_miss.sv](scenarios/tlb_hit_miss.sv) | **TLB Hit vs. Miss Distribution**: Generate access addresses that hit existing tags 70% of the time and miss (forcing page table walks) 30% of the time. |

---

## 3. Arrays, Queues & Dynamic Sizing

| File | Constraint Challenge |
| :--- | :--- |
| [array_payload_generation.sv](array_payload_generation.sv) | Randomize byte payloads with custom checksum constraints and length boundaries. |
| [array_sum_contraint.sv](array_sum_contraint.sv) | Generate a 10-element unique integer array whose total sum equals a fixed target value (`sum() with (int'(item)) == TARGET`). |
| [divide_array_to_n_queue_elements.sv](divide_array_to_n_queue_elements.sv) | Partition elements of an input array randomly and uniformly across $N$ parameterized queues. |
| [divide_queue_elements.sv](divide_queue_elements.sv) | Split a 15-element integer queue into multiple smaller queues according to value criteria (even/odd/prime). |
| [divide_queue_elements_1.sv](divide_queue_elements_1.sv) | Partition a single integer queue into 3 destination queues such that each queue contains mutually exclusive unique values. |
| [dynamic_array_repetition_rules.sv](dynamic_array_repetition_rules.sv) | Generate a 300-element dynamic array from set `{0,1,2,3,4,5}` where no element repeats more than twice consecutively. |
| [queue_size_based_randomization.sv](queue_size_based_randomization.sv) | Randomize queue size to $S$, and constrain each element $i$ in the queue to be bounded by $0 \le \text{queue}[i] < S$. |
| [rand_dynamic_arrays.sv](rand_dynamic_arrays.sv) | Jointly randomize two dynamic arrays `arr1` (size 6–9) and `arr2` (size 12–15) with sum and intersection constraints. |
| [unique_2d_array.sv](unique_2d_array.sv) | Randomize a 2D matrix ($M \times N$) such that all elements across all rows and columns are completely unique. |
| [unique_3d_array.sv](unique_3d_array.sv) | Constrain a $3 \times 3 \times 3$ cube array such that all 27 elements contain unique numbers from 1 to 27. |
| [unique_max_value_in_array.sv](unique_max_value_in_array.sv) | Constrain a 2D array such that each row has a strictly unique maximum element, and that maximum is different across all rows. |

---

## 4. Arithmetic, Bit-Level & Number Theory Constraints

| File | Concept & Constraints |
| :--- | :--- |
| [power_of_2.sv](power_of_2.sv) | Generate numbers that are powers of 2 without using exponentiation (`(val > 0) && ((val & (val - 1)) == 0)`). |
| [power_of_4.sv](power_of_4.sv) | Constrain a 32-bit number to be a power of 4 (must be power of 2 and non-zero bit must reside at an even bit position `val & 32'h55555555 != 0`). |
| [prime_number.sv](prime_number.sv) | Constrain an 8-bit random variable to only produce prime numbers (using set inclusion `inside` or helper table/divisibility constraints). |
| [factorial.sv](factorial.sv) | Constrain generated numbers to only valid factorial values ($1, 2, 6, 24, 120, 720, \dots$). |
| [equal_ones_zeroes.sv](equal_ones_zeroes.sv) | Generate 32-bit values with an equal number of set and unset bits (`$countones(val) == 16`). |
| [dynamic_ones_count_constraint.sv](dynamic_ones_count_constraint.sv) | Dynamically modulate the population count of variable `A` based on the random value of variable `B`. |
| [trailing_zeroes.sv](trailing_zeroes.sv) | Constrain a 32-bit number to have between 5 and 10 trailing binary zeroes (`val[4:0] == 0`, `val[10] != 0`). |
| [five_set_or_unset.sv](five_set_or_unset.sv) | **NVIDIA Interview Question**: 32-bit variable where either exactly 5 bits are set, or exactly 5 bits are unset. |
| [three_sum_even.sv](three_sum_even.sv) | Constrain an array such that the sum of any three consecutive elements is always even. |

---

## 5. Sequences, Patterns & History-Based Randomization

| File | Concept & Technique |
| :--- | :--- |
| [different_from_last_five.sv](different_from_last_five.sv) | State-dependent randomization: Current value must not match any of the previous 5 generated values using a state queue in `post_randomize()`. |
| [even_odd_with_distribution.sv](even_odd_with_distribution.sv) | Markov chain constraint: If previous value was odd, next has 80% probability of being even; if previous was even, next has 70% probability of being odd. |
| [even_odd_not_repeat.sv](even_odd_not_repeat.sv) | Alternate strictly between even and odd integers without repeating values across consecutive cycles. |
| [even_odd_sequence.sv](even_odd_sequence.sv) | Generate a sequence of $N$ even numbers followed immediately by $N$ odd numbers. |
| [even_odd_constraint.sv](even_odd_constraint.sv) | Parity matching: Even array indices must hold even values; odd indices must hold odd values (`a[i] % 2 == i % 2`). |
| [even_odd_sum_constraint.sv](even_odd_sum_constraint.sv) | Array constraint limiting the sum of all odd elements to $\le 30$ and sum of even elements to $\ge 50$. |
| [desecending_and_ascending.sv](desecending_and_ascending.sv) | Array sized between 20 and 30 that is partitioned into a strictly descending first half and strictly ascending second half. |
| [no_consecutive_zeroes.sv](no_consecutive_zeroes.sv) | Array constraint preventing consecutive zeroes (`!(a[i] == 0 && a[i+1] == 0)`). |
| [payload_seq_plus2.sv](payload_seq_plus2.sv) | Array of size 11–22 where each successive element is strictly `previous + 2`. |
| [random_5bit_pattern_constraint.sv](random_5bit_pattern_constraint.sv) | Generate values with only 5 bits set, with consecutive bits appearing 80% of the time. |
| [patterns/pattern_1.sv](patterns/pattern_1.sv) | Generate periodic sequence pattern `1, 2, 2, 1, 2, 2, 1, 2, 2...` |
| [patterns/pattern_2.sv](patterns/pattern_2.sv) | Generate repeating ascending cycles `1, 2, 3, 4, 5, 1, 2, 3, 4, 5...` |
| [patterns/pattern_3.sv](patterns/pattern_3.sv) | Generate escalating zero-padded sequence: `0, 1, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 0, 4, ...` |

---

## 6. Logic Puzzles, Matrices & Advanced Problems

| File | Problem Description |
| :--- | :--- |
| [eight_queens_constraint.sv](eight_queens_constraint.sv) | **Classic Eight Queens Puzzle**: Place 8 queens on an $8 \times 8$ chessboard using SystemVerilog constraints such that no two queens share the same row, column, or diagonal. |
| [sudoku.sv](sudoku.sv) | **Sudoku Solver**: Fully solve a $9 \times 9$ Sudoku grid where each row, column, and $3 \times 3$ sub-grid contains digits 1–9 uniquely. |
| [new_questions/latin_square.sv](new_questions/latin_square.sv) | Randomize an $N \times N$ Latin Square where every row and column contains numbers $1 \dots N$ exactly once. |
| [rotate_90.sv](rotate_90.sv) | Randomize a square matrix and constrain another matrix to be its 90-degree counter-clockwise rotated equivalent. |
| [matrix_multiplication_shape.sv](matrix_multiplication_shape.sv) | Jointly randomize matrix dimensions $(M \times K)$ and $(K \times N)$ ensuring inner dimension matching for matrix multiplication. |
| [matrix_sum_less_than_max.sv](matrix_sum_less_than_max.sv) | Generate an $M \times N$ binary matrix with total sum bounded below a threshold. |
| [four_monkeys.sv](four_monkeys.sv) | Four monkeys sharing 10 bananas such that every monkey gets at least 1 banana, no two monkeys get equal bananas, and specific monkey inequalities hold. |
| [pick_a_ball.sv](pick_a_ball.sv) | Randomly pick from 10 colored balls with unequal weights, ensuring consecutive draws do not pick the same color. |
| [implement_randc.sv](implement_randc.sv) | Simulate cyclic permutation behavior (`randc`) manually using an array, helper mask, and `post_randomize()` without using the `randc` keyword. |
| [gray_code.sv](gray_code.sv) | Constrain randomized 5-bit numbers to strictly follow Gray code transitions (Hamming distance of 1). |
| [consecutive_gray_code.sv](consecutive_gray_code.sv) | Randomize two 6-bit values ensuring they are adjacent valid Gray codes. |
| [differ_by_five.sv](differ_by_five.sv) | Randomize two variables `a` and `b` such that $|a - b| = 5$. |
| [differ_by_two_bits.sv](differ_by_two_bits.sv) | Randomize two 32-bit values such that their Hamming distance is exactly 2 bits (`$countones(val1 ^ val2) == 2`). |
| [exactly_one_duplicate.sv](exactly_one_duplicate.sv) | 10-element array where exactly one value is duplicated and all other 8 values are unique. |
| [exactly_3_same_values.sv](exactly_3_same_values.sv) | 10-element array where exactly three elements share the same value and the remaining 7 elements are distinct. |
| [exactly_3_same_values_1.sv](exactly_3_same_values_1.sv) | Alternate variant of 3-identical-values constraint using sum reduction. |
| [instruction_constraints.sv](instruction_constraints.sv) | Constrain processor instructions (`ADD`, `SUB`, `MUL`, `NOP`) such that no `ADD` is immediately followed by `MUL` (pipeline hazard avoidance). |
| [memory_class_constraint.sv](memory_class_constraint.sv) | Memory transaction class with 32-bit address and 64-bit data, enforcing word-aligned addresses and non-overlapping burst bounds. |
| [random_odd_matrix_gen.sv](random_odd_matrix_gen.sv) | Randomize an $N \times N$ matrix where $N$ is strictly odd and entries follow alternating odd/even row rules. |
| [new_questions/odd_parity.sv](new_questions/odd_parity.sv) | Function and constraint generating 8-bit values with odd parity without repeats. |
| [new_questions/xor_parity.sv](new_questions/xor_parity.sv) | Compute and constrain XOR parity across variable bit slices. |

---

## How to Run & Simulate

Simulate any constraint file using Cadence Xcelium:
```bash
xrun -sv <filename>.sv
```

To see multiple randomized iterations, ensure the testbench contains a repeat loop (e.g., `repeat (10) begin pkt.randomize(); pkt.print(); end`).
