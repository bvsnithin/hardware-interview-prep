# LeetCode & Algorithmic Problem Solving for Hardware Engineers

This directory contains **LeetCode solutions organized into 9 algorithmic patterns**.

---

## Directory Structure

```
leetcode/
├── bit_manipulation/        # Bit-level operations, masks, parity, XOR tricks (13 files)
├── two_pointers/            # Two pointer & binary search algorithms (8 files)
├── arrays_hashing/          # Hash map lookups, deduplication, frequency counting (7 files)
├── linked_lists/            # Pointer manipulation, cycle detection, list merges (7 files)
├── matrix/                  # 2D grid traversals, rotations, spiral order (3 files)
├── stack/                   # Monotonic stacks, parenthesis matching, custom stacks (3 files)
├── design_problems/         # Hardware-friendly data structure designs (2 files)
├── dynamic_programming_1d/  # 1D memoization and recurrence relations (1 file)
└── string/                  # Anagram filtering and string parsing (1 file)
```

---

## 1. Bit Manipulation ([bit_manipulation/](bit_manipulation/))

| File | Language | Problem |
| :--- | :--- | :--- |
| [number_of_1_bits.py](bit_manipulation/number_of_1_bits.py) | Python | 191. Number of 1 Bits (Hamming Weight) |
| [power_of_two.py](bit_manipulation/power_of_two.py) | Python | 231. Power of Two |
| [reverse_bits.py](bit_manipulation/reverse_bits.py) | Python | 190. Reverse Bits |
| [reverse_bits.cpp](bit_manipulation/reverse_bits.cpp) | C++ | 190. Reverse Bits |
| [counting_bits.py](bit_manipulation/counting_bits.py) | Python | 338. Counting Bits |
| [counting_bits.cpp](bit_manipulation/counting_bits.cpp) | C++ | 338. Counting Bits |
| [single_number.py](bit_manipulation/single_number.py) | Python | 136. Single Number |
| [single_number_2.cpp](bit_manipulation/single_number_2.cpp) | C++ | 137. Single Number II |
| [single_number_3.py](bit_manipulation/single_number_3.py) | Python | 260. Single Number III |
| [missing_number.py](bit_manipulation/missing_number.py) | Python | 268. Missing Number |
| [find_the_duplicate_number.py](bit_manipulation/find_the_duplicate_number.py) | Python | 287. Find the Duplicate Number |
| [maximum_product_of_word_lengths.py](bit_manipulation/maximum_product_of_word_lengths.py) | Python | 318. Maximum Product of Word Lengths |
| [sum_of_integers.cpp](bit_manipulation/sum_of_integers.cpp) | C++ | 371. Sum of Two Integers |

---

## 2. Two Pointers & Binary Search ([two_pointers/](two_pointers/))

| File | Language | Problem |
| :--- | :--- | :--- |
| [binary_search.py](two_pointers/binary_search.py) | Python | 704. Binary Search |
| [search_insert_position.py](two_pointers/search_insert_position.py) | Python | 35. Search Insert Position |
| [koko_eating_bananas.py](two_pointers/koko_eating_bananas.py) | Python | 875. Koko Eating Bananas |
| [two_sum_2_sorted_list.py](two_pointers/two_sum_2_sorted_list.py) | Python | 167. Two Sum II - Input Array Is Sorted |
| [three_sum.py](two_pointers/three_sum.py) | Python | 15. 3Sum |
| [three_sum_closest.py](two_pointers/three_sum_closest.py) | Python | 16. 3Sum Closest |
| [two_sum_4_bst.py](two_pointers/two_sum_4_bst.py) | Python | 653. Two Sum IV - Input is a BST |
| [valid_palindrome.py](two_pointers/valid_palindrome.py) | Python | 125. Valid Palindrome |

---

## 3. Arrays & Hashing ([arrays_hashing/](arrays_hashing/))

| File | Language | Problem |
| :--- | :--- | :--- |
| [two_sum.py](arrays_hashing/two_sum.py) | Python | 1. Two Sum |
| [best_time_to_buy_and_sell_stocks.py](arrays_hashing/best_time_to_buy_and_sell_stocks.py) | Python | 121. Best Time to Buy and Sell Stock |
| [majority_element.py](arrays_hashing/majority_element.py) | Python | 169. Majority Element |
| [remove_duplicates_from_sorted_array.py](arrays_hashing/remove_duplicates_from_sorted_array.py) | Python | 26. Remove Duplicates from Sorted Array |
| [remove_duplicates.py](arrays_hashing/remove_duplicates.py) | Python | Remove Duplicates from Unsorted Array |
| [merge_two_sorted_arrays.py](arrays_hashing/merge_two_sorted_arrays.py) | Python | 88. Merge Sorted Array |
| [second_largest_element.py](arrays_hashing/second_largest_element.py) | Python | Second Largest Element in Array |

---

## 4. Matrix & 2D Grids ([matrix/](matrix/))

| File | Language | Problem |
| :--- | :--- | :--- |
| [rotate_image.py](matrix/rotate_image.py) | Python | 48. Rotate Image |
| [spiral_matrix.py](matrix/spiral_matrix.py) | Python | 54. Spiral Matrix |
| [transpose_matrix.py](matrix/transpose_matrix.py) | Python | 867. Transpose Matrix |

---

## 5. Linked Lists ([linked_lists/](linked_lists/))

| File | Language | Problem |
| :--- | :--- | :--- |
| [reverse_linked_list.py](linked_lists/reverse_linked_list.py) | Python | 206. Reverse Linked List |
| [linked_list_cycle.py](linked_lists/linked_list_cycle.py) | Python | 141. Linked List Cycle |
| [merge_two_sorted_lists.py](linked_lists/merge_two_sorted_lists.py) | Python | 21. Merge Two Sorted Lists |
| [remove_duplicates_from_sorted_list.py](linked_lists/remove_duplicates_from_sorted_list.py) | Python | 83. Remove Duplicates from Sorted List |
| [remove_nth_node_from_end_of_list.py](linked_lists/remove_nth_node_from_end_of_list.py) | Python | 19. Remove Nth Node From End of List |
| [intersection_of_two_linked_lists.py](linked_lists/intersection_of_two_linked_lists.py) | Python | 160. Intersection of Two Linked Lists |
| [add_two_numbers.py](linked_lists/add_two_numbers.py) | Python | 2. Add Two Numbers |

---

## 6. Stacks ([stack/](stack/))

| File | Language | Problem |
| :--- | :--- | :--- |
| [valid_parantheses.py](stack/valid_parantheses.py) | Python | 20. Valid Parentheses |
| [min_stack.py](stack/min_stack.py) | Python | 155. Min Stack |
| [roman_to_integer.py](stack/roman_to_integer.py) | Python | 13. Roman to Integer |

---

## 7. Hardware-Friendly Design Problems ([design_problems/](design_problems/))

| File | Language | Problem |
| :--- | :--- | :--- |
| [design_hashmap.py](design_problems/design_hashmap.py) | Python | 706. Design HashMap |
| [design_hashset.py](design_problems/design_hashset.py) | Python | 705. Design HashSet |

---

## 8. Dynamic Programming & Strings

| File | Language | Problem |
| :--- | :--- | :--- |
| [dynamic_programming_1d/climbing_stairs.py](dynamic_programming_1d/climbing_stairs.py) | Python | 70. Climbing Stairs |
| [string/remove_anagrams.py](string/remove_anagrams.py) | Python | Remove Anagrams from List of Words |
