# https://leetcode.com/problems/permutations/?envType=problem-list-v2&envId=backtracking

class Solution:
    def permute(self, nums: list[int]) -> list[list[int]]:
        # Number of permutations for an array of size n = n!

        # This is a classic problem that uses the backtracking technique
        # The core idea has 3 parts:
        # 1) Choose
        # 2) Explore
        # 3) Unchoose

        # Fix a state, explore all possible paths in that state and move on to another state. 

        # Example flow
        # Fix the first element as 1.
        # We are either explore with 2 next or with 3 next
        # If we select 2, then we have the final path as follows - [1,2,3]
        # If we select 3, then we have - [1,3,2]

        result = [] # To store all the possible permutations
        current_path = [] # To store the current permutation that we are building
        n = len(nums)

        def backtrack():
            if len(current_path) == n:
                result.append(current_path.copy())
                return
            
            for num in nums:
                if num not in current_path:

                    # Choose 
                    current_path.append(num)

                    # Explore
                    backtrack()

                    # Unchoose
                    current_path.pop()
 
        backtrack()
        return result