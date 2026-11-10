# https://leetcode.com/problems/subsets-ii/?envType=problem-list-v2&envId=bit-manipulation

class Solution:
    def subsetsWithDup(self, nums: list[int]) -> list[list[int]]:
        # Similar to the "78. Subsets" question. But if the subset is already in the final list, then don't add it

        # However, we need to sort the array first for the solution to work. 
        # Take [1,2,1] for example: 
        # Mask 011 gives [1,2] and Mask 110 gives [2,1]. These are duplicate subsets. However, our code from the subsets does not recognize it and adds to res. 
        # But sorting fixes this as both masks return same result. 

        nums.sort()

        res = []
        n = len(nums)

        for mask in range(0, 1 << n):
            subset = []

            for j in range(n):
                if mask & (1 << j):
                    subset.append(nums[j])

            if subset not in res:
                res.append(subset)

        return res