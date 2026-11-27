# LeetCode & Algorithmic Problem Solving for Hardware Engineers

This directory contains **LeetCode solutions organized into 11 algorithmic patterns**.

---

## Directory Structure

```
leetcode/
├── bit_manipulation/        # Bit-level operations, masks, parity, XOR tricks
├── two_pointers/            # Two pointer & binary search algorithms
├── arrays_hashing/          # Hash map lookups, deduplication, frequency counting
├── linked_lists/            # Pointer manipulation, cycle detection, list merges
├── matrix/                  # 2D grid traversals, rotations, spiral order
├── stack/                   # Monotonic stacks, parenthesis matching, custom stacks
├── design_problems/         # Hardware-friendly data structure designs
├── dynamic_programming_1d/  # 1D memoization and recurrence relations
├── string/                  # Anagram filtering and string parsing
├── trees/                   # Binary tree traversals, BST operations, tree problems
├── trie/                    # Prefix tree (trie) implementations
└── backtracking/            # Combinatorics: permutations, combinations, tree paths
```

---

## 1. Bit Manipulation ([bit_manipulation/](bit_manipulation/))

| Problem | Language | LeetCode # |
| :--- | :--- | :--- |
| [number_of_1_bits.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/number_of_1_bits.py) | Python | 191. Number of 1 Bits (Hamming Weight) |
| [power_of_two.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/power_of_two.py) | Python | 231. Power of Two |
| [reverse_bits.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/reverse_bits.py) | Python | 190. Reverse Bits |
| [reverse_bits.cpp](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/reverse_bits.cpp) | C++ | 190. Reverse Bits |
| [counting_bits.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/counting_bits.py) | Python | 338. Counting Bits |
| [counting_bits.cpp](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/counting_bits.cpp) | C++ | 338. Counting Bits |
| [single_number.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/single_number.py) | Python | 136. Single Number |
| [single_number_2.cpp](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/single_number_2.cpp) | C++ | 137. Single Number II |
| [single_number_3.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/single_number_3.py) | Python | 260. Single Number III |
| [missing_number.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/missing_number.py) | Python | 268. Missing Number |
| [find_the_duplicate_number.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/find_the_duplicate_number.py) | Python | 287. Find the Duplicate Number |
| [maximum_product_of_word_lengths.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/maximum_product_of_word_lengths.py) | Python | 318. Maximum Product of Word Lengths |
| [sum_of_integers.cpp](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/sum_of_integers.cpp) | C++ | 371. Sum of Two Integers |
| [add_binary.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/add_binary.py) | Python | 67. Add Binary |
| [bitwise_and_of_numbers_range.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/bitwise_and_of_numbers_range.py) | Python | 201. Bitwise AND of Numbers Range |
| [subsets.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/subsets.py) | Python | 78. Subsets |
| [subsets_2.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/subsets_2.py) | Python | 90. Subsets II |
| [gray_code.cpp](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/gray_code.cpp) | C++ | 89. Gray Code |
| [number_of_even_and_odd_bits.cpp](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/number_of_even_and_odd_bits.cpp) | C++ | 2946. Number of Even and Odd Bits |
| [swap_even_odd_bits.cpp](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/swap_even_odd_bits.cpp) | C++ | Swap Even and Odd Bits |
| [important_bit_manipulation_techniques.cpp](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/bit_manipulation/important_bit_manipulation_techniques.cpp) | C++ | Reference: Common Bit Tricks |

---

## 2. Two Pointers & Binary Search ([two_pointers/](two_pointers/))

| Problem | Language | LeetCode # |
| :--- | :--- | :--- |
| [binary_search.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/two_pointers/binary_search.py) | Python | 704. Binary Search |
| [search_insert_position.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/two_pointers/search_insert_position.py) | Python | 35. Search Insert Position |
| [koko_eating_bananas.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/two_pointers/koko_eating_bananas.py) | Python | 875. Koko Eating Bananas |
| [two_sum_2_sorted_list.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/two_pointers/two_sum_2_sorted_list.py) | Python | 167. Two Sum II - Input Array Is Sorted |
| [three_sum.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/two_pointers/three_sum.py) | Python | 15. 3Sum |
| [three_sum_closest.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/two_pointers/three_sum_closest.py) | Python | 16. 3Sum Closest |
| [two_sum_4_bst.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/two_pointers/two_sum_4_bst.py) | Python | 653. Two Sum IV - Input is a BST |
| [valid_palindrome.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/two_pointers/valid_palindrome.py) | Python | 125. Valid Palindrome |
| [compare_version_numbers.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/two_pointers/compare_version_numbers.py) | Python | 165. Compare Version Numbers |

---

## 3. Arrays & Hashing ([arrays_hashing/](arrays_hashing/))

| Problem | Language | LeetCode # |
| :--- | :--- | :--- |
| [two_sum.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/arrays_hashing/two_sum.py) | Python | 1. Two Sum |
| [best_time_to_buy_and_sell_stocks.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/arrays_hashing/best_time_to_buy_and_sell_stocks.py) | Python | 121. Best Time to Buy and Sell Stock |
| [majority_element.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/arrays_hashing/majority_element.py) | Python | 169. Majority Element |
| [remove_duplicates_from_sorted_array.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/arrays_hashing/remove_duplicates_from_sorted_array.py) | Python | 26. Remove Duplicates from Sorted Array |
| [remove_duplicates.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/arrays_hashing/remove_duplicates.py) | Python | Remove Duplicates from Unsorted Array |
| [merge_two_sorted_arrays.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/arrays_hashing/merge_two_sorted_arrays.py) | Python | 88. Merge Sorted Array |
| [second_largest_element.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/arrays_hashing/second_largest_element.py) | Python | Second Largest Element in Array |
| [maximum_subarray.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/arrays_hashing/maximum_subarray.py) | Python | 53. Maximum Subarray (Kadane's) |
| [maximum_product_subarray.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/arrays_hashing/maximum_product_subarray.py) | Python | 152. Maximum Product Subarray |
| [minimum_moves_to_equal_array_elements_2.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/arrays_hashing/minimum_moves_to_equal_array_elements_2.py) | Python | 462. Minimum Moves to Equal Array Elements II |

---

## 4. Matrix & 2D Grids ([matrix/](matrix/))

| Problem | Language | LeetCode # |
| :--- | :--- | :--- |
| [rotate_image.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/matrix/rotate_image.py) | Python | 48. Rotate Image |
| [spiral_matrix.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/matrix/spiral_matrix.py) | Python | 54. Spiral Matrix |
| [transpose_matrix.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/matrix/transpose_matrix.py) | Python | 867. Transpose Matrix |

---

## 5. Linked Lists ([linked_lists/](linked_lists/))

| Problem | Language | LeetCode # |
| :--- | :--- | :--- |
| [reverse_linked_list.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/linked_lists/reverse_linked_list.py) | Python | 206. Reverse Linked List |
| [reverse_linked_list_2.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/linked_lists/reverse_linked_list_2.py) | Python | 92. Reverse Linked List II |
| [linked_list_cycle.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/linked_lists/linked_list_cycle.py) | Python | 141. Linked List Cycle |
| [linked_list_cycle_2.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/linked_lists/linked_list_cycle_2.py) | Python | 142. Linked List Cycle II |
| [merge_two_sorted_lists.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/linked_lists/merge_two_sorted_lists.py) | Python | 21. Merge Two Sorted Lists |
| [remove_duplicates_from_sorted_list.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/linked_lists/remove_duplicates_from_sorted_list.py) | Python | 83. Remove Duplicates from Sorted List |
| [remove_duplicates_from_sorted_list_2.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/linked_lists/remove_duplicates_from_sorted_list_2.py) | Python | 82. Remove Duplicates from Sorted List II |
| [remove_nth_node_from_end_of_list.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/linked_lists/remove_nth_node_from_end_of_list.py) | Python | 19. Remove Nth Node From End of List |
| [intersection_of_two_linked_lists.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/linked_lists/intersection_of_two_linked_lists.py) | Python | 160. Intersection of Two Linked Lists |
| [add_two_numbers.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/linked_lists/add_two_numbers.py) | Python | 2. Add Two Numbers |
| [swap_nodes_in_pairs.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/linked_lists/swap_nodes_in_pairs.py) | Python | 24. Swap Nodes in Pairs |
| [rotate_list.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/linked_lists/rotate_list.py) | Python | 61. Rotate List |
| [convert_sorted_list_to_bst.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/linked_lists/convert_sorted_list_to_bst.py) | Python | 109. Convert Sorted List to Binary Search Tree |

---

## 6. Stacks ([stack/](stack/))

| Problem | Language | LeetCode # |
| :--- | :--- | :--- |
| [valid_parantheses.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/stack/valid_parantheses.py) | Python | 20. Valid Parentheses |
| [min_stack.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/stack/min_stack.py) | Python | 155. Min Stack |
| [roman_to_integer.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/stack/roman_to_integer.py) | Python | 13. Roman to Integer |
| [simplify_path.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/stack/simplify_path.py) | Python | 71. Simplify Path |
| [mini_parser.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/stack/mini_parser.py) | Python | 385. Mini Parser |

---

## 7. Hardware-Friendly Design Problems ([design_problems/](design_problems/))

| Problem | Language | LeetCode # |
| :--- | :--- | :--- |
| [design_hashmap.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/design_problems/design_hashmap.py) | Python | 706. Design HashMap |
| [design_hashset.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/design_problems/design_hashset.py) | Python | 705. Design HashSet |

---

## 8. Dynamic Programming ([dynamic_programming_1d/](dynamic_programming_1d/))

| Problem | Language | LeetCode # |
| :--- | :--- | :--- |
| [climbing_stairs.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/dynamic_programming_1d/climbing_stairs.py) | Python | 70. Climbing Stairs |
| [min_cost_climbing_stairs.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/dynamic_programming_1d/min_cost_climbing_stairs.py) | Python | 746. Min Cost Climbing Stairs |
| [fibonacci_number.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/dynamic_programming_1d/fibonacci_number.py) | Python | 509. Fibonacci Number |
| [nth_tribonacci_number.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/dynamic_programming_1d/nth_tribonacci_number.py) | Python | 1137. N-th Tribonacci Number |
| [house_robber.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/dynamic_programming_1d/house_robber.py) | Python | 198. House Robber |
| [jump_game.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/dynamic_programming_1d/jump_game.py) | Python | 55. Jump Game |
| [coin_change.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/dynamic_programming_1d/coin_change.py) | Python | 322. Coin Change |
| [unique_binary_search_trees.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/dynamic_programming_1d/unique_binary_search_trees.py) | Python | 96. Unique Binary Search Trees |
| [factorial.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/dynamic_programming_1d/factorial.py) | Python | Factorial (recursion/DP reference) |

---

## 9. Strings ([string/](string/))

| Problem | Language | LeetCode # |
| :--- | :--- | :--- |
| [remove_anagrams.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/string/remove_anagrams.py) | Python | 2273. Find Resultant Array After Removing Anagrams |
| [zigzag_conversion.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/string/zigzag_conversion.py) | Python | 6. Zigzag Conversion |

---

## 10. Trees ([trees/](trees/))

| Problem | Language | LeetCode # |
| :--- | :--- | :--- |
| [binary_tree_inorder_traversal.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trees/binary_tree_inorder_traversal.py) | Python | 94. Binary Tree Inorder Traversal |
| [binary_tree_preorder_traversal.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trees/binary_tree_preorder_traversal.py) | Python | 144. Binary Tree Preorder Traversal |
| [binary_tree_postorder_traversal.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trees/binary_tree_postorder_traversal.py) | Python | 145. Binary Tree Postorder Traversal |
| [tree_traversals_dfs.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trees/tree_traversals_dfs.py) | Python | DFS Traversals Reference |
| [tree_traversal_bfs.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trees/tree_traversal_bfs.py) | Python | BFS Traversal Reference |
| [binary_tree_level_order_traversal.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trees/binary_tree_level_order_traversal.py) | Python | 102. Binary Tree Level Order Traversal |
| [binary_tree_zigzag_order_traversal.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trees/binary_tree_zigzag_order_traversal.py) | Python | 103. Binary Tree Zigzag Level Order Traversal |
| [maximum_depth_of_binary_tree.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trees/maximum_depth_of_binary_tree.py) | Python | 104. Maximum Depth of Binary Tree |
| [same_tree.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trees/same_tree.py) | Python | 100. Same Tree |
| [symmetric_trees.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trees/symmetric_trees.py) | Python | 101. Symmetric Tree |
| [invert_binary_tree.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trees/invert_binary_tree.py) | Python | 226. Invert Binary Tree |
| [balanced_binary_trees.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trees/balanced_binary_trees.py) | Python | 110. Balanced Binary Tree |
| [convert_sorted_array_to_bst.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trees/convert_sorted_array_to_bst.py) | Python | 108. Convert Sorted Array to Binary Search Tree |
| [binary_search_tree_to_greater_sum_tree.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trees/binary_search_tree_to_greater_sum_tree.py) | Python | 1038. BST to Greater Sum Tree |
| [reverse_odd_levels_of_binary_tree.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trees/reverse_odd_levels_of_binary_tree.py) | Python | 2415. Reverse Odd Levels of Binary Tree |

---

## 11. Trie ([trie/](trie/))

| Problem | Language | LeetCode # |
| :--- | :--- | :--- |
| [implement_trie.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trie/implement_trie.py) | Python | 208. Implement Trie (Prefix Tree) |
| [trie.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trie/trie.py) | Python | Trie Reference Implementation |
| [longest_common_prefix.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/trie/longest_common_prefix.py) | Python | 14. Longest Common Prefix |

---

## 12. Backtracking ([backtracking/](backtracking/))

| Problem | Language | LeetCode # |
| :--- | :--- | :--- |
| [permutations.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/backtracking/permutations.py) | Python | 46. Permutations |
| [combinations.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/backtracking/combinations.py) | Python | 77. Combinations |
| [binary_tree_paths.py](https://github.com/bvsnithin/hardware-interview-prep/blob/main/leetcode/backtracking/binary_tree_paths.py) | Python | 257. Binary Tree Paths |
