# SystemVerilog Constraints Interview Problems

This folder contains a collection of constraint-based verification problems that I sourced from different places on the internet.
---

## Problem List

### Array Constraints

- **array_payload_generation.sv** - Generate random payloads with specific properties for array elements
- **array_sum_contraint.sv** - Constraint to ensure the sum of array elements meets specific criteria
- **divide_queue_elements.sv** - Divide queue elements based on certain properties and constraints
- **dynamic_array_repetition_rules.sv** - Apply repetition rules to dynamic arrays with constraints

### Sequence and Pattern Constraints

- **gray_code.sv** - Generate valid Gray code sequences
- **consecutive_gray_code.sv** - Generate Gray codes with consecutive number constraints
- **no_consecutive_zeroes.sv** - Constraint ensuring no consecutive zero bits in generated values
- **different_from_last_five.sv** - Generate values that differ from the last five generated values
- **even_odd_sequence.sv** - Generate sequences that alternate or follow even/odd patterns

### Numeric and Logic Constraints

- **power_of_2.sv** - Generate only power-of-2 numbers
- **power_of_4.sv** - Generate only power-of-4 numbers
- **prime_number.sv** - Generate prime numbers
- **equal_ones_zeroes.sv** - Generate values with equal number of ones and zeroes
- **dynamic_ones_count_constraint.sv** - Constraint on the count of ones in binary representation
- **trailing_zeroes.sv** - Generate values with specific number of trailing zeroes

### Comparison and Difference Constraints

- **differ_by_five.sv** - Generate values that differ by exactly five
- **differ_by_two_bits.sv** - Generate values that differ by exactly two bits
- **exactly_one_duplicate.sv** - Generate sequences with exactly one duplicate value
- **exactly_3_same_values.sv** - Generate sequences with exactly 3 same values
- **exactly_3_same_values_1.sv** - Variant: Generate exactly 3 same values with different constraints

### Complex and Advanced Constraints

- **eight_queens_constraint.sv** - Classic Eight Queens puzzle solver using constraints
- **four_monkeys.sv** - Problem involving logic and constraint satisfaction
- **three_sum_even.sv** - Find three numbers that sum to an even value
- **rotate_90.sv** - Generate values for 90-degree rotation constraint
- **payload_seq_plus2.sv** - Generate payload sequences where each element is previous + 2

### Pattern and Random Generation

- **random_5bit_pattern_constraint.sv** - Generate specific 5-bit patterns with randomization
- **implement_randc.sv** - Implement randc (random cycle) functionality using constraints
- **five_set_or_unset.sv** - Constraint ensuring five bits are either set or unset
- **desecending_and_ascending.sv** - Generate sequences that are either descending or ascending

### Pattern Variations

The `patterns/` subfolder contains additional pattern-based constraint variations:
- **pattern_1.sv**
- **pattern_2.sv**
- **pattern_3.sv**

---

## Running and Testing

Compile and simulate your constraints using:
```bash
xrun -sv <constraint_file.sv>
```

---
