#https://leetcode.com/problems/single-number/description/

class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        x = 0

        #Iterating over the list with index
        for i in range(len(nums)):
            x = x^nums[i]
        return x

        #Iterating over the list directly
        # for n in nums:
        #     x = x^n
        # return x
        
