# https://leetcode.com/problems/subsets/?envType=problem-list-v2&envId=bit-manipulation

class Solution:
    def subsets(self, nums: list[int]) -> list[list[int]]:
        # Number of subsets = 2^length of the array

        # The core idea behind the solution using bit manipulation:
        # For an array of size n, there are 2^n possible subsets. For n = 3, it's 8
        # A 3 bit binary numbers goes from 000, 001, 010,....., 111
        # Look at the bits that are high (1) and the subsets below for the example: [1,2,3]
        # [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
        # Subset 1: [] maps to 000 becaue we selected none from the original array
        # Subset 2: [1] maps to 001, because we selected index 0 from the original array (bit 0 - LSB is high)
        # Subset 3: [2] maps to 010, because we selected index 1 from the original array (bit 1 - LSB is high)
        # Subset 4: [1,2] maps to 011, because we selected index 0 and index 1 from the original array (bit 0 - LSB is high and bit 1 - LSB is high)
        # Subset 7: [1,2,3] maps to 111, all bits are high so we select all the numbers in the array

        # For a given array, we'll iterate 2^n times and check the indices which are high and indculde those elements in our final list

        res = [] # Final list to store all the subsets

        n = len(nums)

        for mask in range(0, 1 << n):
            # mask goes from 0 to 2^n-1. For n = 3, we go from 000 to 111

            # Now we see the bits that are high in the mask and include that corresponding index element to the final results array. 
            # If mask = 101, it means, we select index 2 and index 0 because they are high(1)

            subset = []
            for j in range(n): # Check every bit position
                # Check if the bit j in the mask if high (basically checking if it's set or not)
                if mask & (1 << j):
                    subset.append(nums[j])
            
            res.append(subset)

        return res


